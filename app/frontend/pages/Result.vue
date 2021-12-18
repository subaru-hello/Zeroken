<template>
  <div id="izakaya" style="width: 100%; box-sizing: border-box;">
    <div>
      <v-container
        fluid
        justify="center"
        style="background-color: rgb(0, 0, 0, 0.6); width: 80%; border-radius: 20%"
      >
        <!-- <p> {{alcoholContents}}</p> -->
        <v-row class="d-flex">
          <v-col cols="12">
            <div>
              <v-col>
                <p class="text-center white--text" style="font-size: 30px">酒テータス</p>
              </v-col>
            </div>
            <div class="d-flex" justify="center" align-content="center">
              <star-rating
                :rating="strongnessStar"
                :star-size="30"
                :show-rating="false"
                read-only
                class="mx-auto"
              ></star-rating>
            </div>
            <div class="d-flex" align-content="center">
              <v-col>
                <v-col>
                  <p class="text-center white--text" style="font-size: 30px">
                    {{ currentAnalyze }}
                  </p>
                  <transition name="fade">
                    <div v-if="currentAnalyze === '下戸'" class="text-center">
                      <v-btn x-large @click="isVisibleShowCertificate" class="text-center"
                        >証明書が発行されました</v-btn
                      >
                    </div>
                  </transition>
                </v-col>
              </v-col>
            </div>
            <div>
              <v-col>
                <p class="text-center white--text">
                  「 {{ analyzes[analyzes.length - 1]['description'] }}」
                </p>
              </v-col>
            </div>
            <div>
              <div class="text-center">
                <v-btn x-large @click="isVisibleShuchedule" class="text-center"
                  >酒ケジュールを見る</v-btn
                >
              </div>
            </div>

            <ShowShucheduleModal
              v-if="showShuchedule"
              :alcoholDatas="alcoholContents"
              :motivationImg="nextMotivationImg"
              @closeModal="closeShucheduleModal"
            />
            <ShowCertificateModal
              v-if="showCertificate"
              :expirationDate="expirationDate"
              :nonAlcoholImg="nonAlcoholImg"
              @closeCertificate="closeCertificateModal"
            />
          </v-col>
        </v-row>
      </v-container>
    </div>
    <v-row justify="center" align-content="center">
      <v-btn
        class="centered white--text"
        :to="{ name: 'ZerokenTop' }"
        style="background-color: rgb(0, 0, 0, 0.6); border-radius: 20%"
        x-large
      >
        トップに戻る
      </v-btn>
      <v-dialog v-model="dialog" width="400">
        <template v-slot:activator="{ on }">
          <v-btn
            v-on="on"
            x-large
            class="white--text"
            style="background-color: rgb(0, 0, 0, 0.6); border-radius: 20%"
          >
            シェアする
          </v-btn>
        </template>
        <v-card>
          <v-card-title>
            <span class="text-h6 font-weight-bold">Share</span>
            <v-spacer></v-spacer>
            <v-btn class="mx-0" icon @click="dialog = false">
              <v-icon>mdi-close-circle-outline</v-icon>
            </v-btn>
          </v-card-title>
          <v-list>
            <v-list-item>
              <v-list-item-action>
                <v-icon color="#1da1f2"> mdi-twitter </v-icon>
              </v-list-item-action>
              <v-btn :href="sns.twitter" target="_blank">{{ Twitter }} </v-btn>
            </v-list-item>
            <v-list-item>
              <v-list-item-action>
                <img :src="imgSrc" width="20" height="20" />
              </v-list-item-action>
              <v-btn :href="sns.line" target="_blank" rel="noopener noreferrer">LINE</v-btn>
            </v-list-item>
          </v-list>
        </v-card>
      </v-dialog>
    </v-row>
    <v-layout>
      <v-col
        class="text-center mx-auto my-5 form"
        style="width: 50%; border-radius: 20%"
        elevation="2"
        shaped
        v-for="list in logicLists"
        :key="list.title"
        id="form"
      >
        <v-card>

          <v-card-title>
            {{ list.title }}
          </v-card-title>

          <v-card-subtitle>
            {{ list.subtext }}
          </v-card-subtitle>

          <v-card-actions>
            <v-btn color="orange lighten-2" text> 詳細を見る </v-btn>

            <v-spacer></v-spacer>

            <v-btn icon @click="show = !show">
              <v-icon>{{ show ? 'mdi-chevron-up' : 'mdi-chevron-down' }}</v-icon>
            </v-btn>
          </v-card-actions>

          <v-expand-transition>
            <div v-show="show">
              <v-divider></v-divider>
              <v-card-text>
                {{ list.description }}
              </v-card-text>
            </div>
          </v-expand-transition>
        </v-card>
      </v-col>
    </v-layout>
  </div>
</template>

<script>
import { mapActions, mapGetters, mapMutations } from 'vuex';
import StarRating from 'vue-star-rating';
import ShowShucheduleModal from '../components/result/ShowShucheduleModal';
import ShowCertificateModal from '../components/result/ShowCertificateModal';
import axios from '../plugins/axios';
export default {
  components: {
    StarRating,
    ShowShucheduleModal,
    ShowCertificateModal,
  },
  data: function () {
    return {
      shuche: '',
      showShuchedule: false,
      alcoholContents: {},
      alcoholismDrunkness: false,
      alcoholismStrongness: false,
      nonAlcoholImg: '',
      nextMotivationImg: '',
      alcohols: {},
      analyze: [],
      users: [],
      logicLists: [
        {
          title: 'お酒の強さ算出ロジック',
          subtext:
            ' TASTという東大生が考案した、お酒の強さをはかる診断を使用しています。2013年にTwitterで拡散され、1.6万リツイートされるほどにバズりました。',
          description:
            ' 内容: 13項目からなる質問に３択で答えます。各項目にポイントがあり、ポイント合計が正の値だった場合は酒豪、0だったら普通、負の値だった場合は下戸という診断結果が出るようになっています。ZEROKENでは、より厳密に判断するために、「やや酒豪」「やや下戸」を追加しています。',
          img: require('../src/img/TAST.jpeg'),
          action: 'drunkness',
        },
        {
          title: '酔い度合い算出ロジック',
          subtext:
            '  厚生労働省が用意しているデータを参考にして「酔いたい状態になるまでに必要なお酒の量」を算出しています。',
          description:
            '「酔い」というものは、血中アルコール濃度に応じて状態が変わってきます。ZEROKENでは、下記のような構成でアルコール血中濃度と、「しっぽり・ほろ酔い・酩酊」をそれぞれ紐づけています。',
          img: require('../src/img/drunkness.png'),
          action: 'strongness',
        },
      ],
      errors: '',
      expirationDate: new Date(Date.now() + 7 - new Date().getTimezoneOffset() * 60000)
        .toISOString()
        .substr(0, 10),
      show: false,
      dialog: false,
      dialog0: false,
      dialog1: false,
      dialog2: false,
      showCertificate: false,
      alcoholOrders: {},
      alcoholStrongness: '',
      Twitter: 'Twitter',
      rating: [],
      sns: {
        twitter: '',
        url: '',
        title: '',
        hashtags: 'ZEROKEN,アルハラ防止,酒ケジュール',
        line: '',
        lineDescription: 'で一次会に向けてお酒の強さを診断しましょう。',
      },
    };
  },

  computed: {
    ...mapGetters('analyze', ['analyzes']),
    ...mapGetters('users', ['authUser']),
    currentUser() {
      return this.authUser['data']['attributes']['nickname'];
    },
    currentAnalyze() {
      const thisAnalyze = this.analyzes;
      const targetAnalyze = thisAnalyze[thisAnalyze.length - 1];
      const targetAlcoholStrongness = targetAnalyze['alcohol_strongness'];
      function checkAlcoholStrongness(target) {
        if (target === 'strong') {
          return '酒豪';
        } else if (target === 'weak') {
          return '下戸';
        } else if (target === 'normal') {
          return '普通の人';
        } else if (target === 'normal_strong') {
          return 'やや酒豪';
        } else {
          return 'やや下戸';
        }
      }
      const result = checkAlcoholStrongness(targetAlcoholStrongness);
      const AlcoholStrongness = (this.alcoholStrongness = result)
      return AlcoholStrongness ;
    },
    changeSrc() {
      const thisAnalyze = this.analyzes;
      const targetAnalyze = thisAnalyze[thisAnalyze.length - 1];
      const targetMotivation = targetAnalyze['next_motivation'];

      function checkMotivation(target) {
        if (target === 'flesh') {
          return require('../src/img/flesh_stamp.png');
        } else if (target === 'tipsy') {
          return require('../src/img/tipsy_stamp.png');
        } else {
          return require('../src/img/meitei_stamp.png');
        }
      }
      const result = checkMotivation(targetMotivation);
      const nextMotivation = (this.nextMotivationImg = result);
      return nextMotivation;
    },
    strongnessStar() {
      const targetAnalyze = this.analyzes;
      const sakeStrongness = targetAnalyze[targetAnalyze.length - 1]['alcohol_strongness'];
      const starState =
        sakeStrongness === 'weak'
          ? 1
          : sakeStrongness === 'weak_normal'
          ? 2
          : sakeStrongness === 'normal'
          ? 3
          : sakeStrongness === 'normal_strong'
          ? 4
          : 5;
      return starState;
    },
    isAlcohol() {
      const thisAnalyze = this.analyzes;

      const analyzeShuchedule = thisAnalyze[thisAnalyze.length - 1]['shuchedule'];

      const targetValues = this.alcohols;

      const contentsOfTarget = targetValues[analyzeShuchedule]; //数字を取り出している
      const alcoholPercentage = contentsOfTarget['alcohol_percentage'];
      const logoInspect = alcoholPercentage > 0 ? 'mdi-glass-mug' : 'mdi-cup';
      return logoInspect;
    },
    contents() {
      const thisAnalyze = this.analyzes;
      const targetValues = this.alcohols;
      const analyzeShuchedule = thisAnalyze[thisAnalyze.length - 1]['shuchedule'];
      const contentsOfTarget = Object.values(targetValues)[analyzeShuchedule];
      const changeProperty = (this.alcoholContents = contentsOfTarget);
      return changeProperty;
    },
    imgSrc() {
      return require('../src/img/line.png');
    },
    woodSrc() {
      return require('../src/img/woodtile.jpeg');
    },
    tastSrc() {
      return require('../src/img/TAST.jpeg');
    },
    drunknessSrc() {
      return require('../src/img/drunkness.png');
    },
    sakeSrc() {
      return require('../src/img/sake.svg');
    },
    drinkSrc() {
      return require('../src/img/drink.svg');
    },
    // ippaiSrc() {
    //   return require('../src/img/ippai_shuki.png');
    // },
    // sugusakeSrc() {
    //   return require('../src/img/sugusake_stamp.png');
    // },
    // sugumeiteiSrc() {
    //   return require('../src/img/sugumeitei_stamp.png');
    // },
    beerSrc() {
      return require('../src/img/beer.svg');
    },
    meiteiSrc() {
      return require('../src/img/meitei_stamp.png');
    },
    tipsySrc() {
      return require('../src/img/tipsy_stamp.png');
    },
    fleshSrc() {
      return require('../src/img/flesh_stamp.png');
    },
    certificateSrc() {
      return require('../src/img/certificate.png');
    },
    nonAlcoholSrc() {
      const img = require('../src/img/geko_stamp.png');
      const nonAlcoholPic = (this.nonAlcoholImg = img);
      return nonAlcoholPic;
    },
  },
  mounted() {
    this.analyze = this.fetchAnalyzes;
    this.show = true;
  },
  updated() {},
  created() {
    axios.get('/alcohols').then((alcoholResponse) => (this.alcohols = alcoholResponse.data));
    this.fetchAnalyzes();
    this.clearAnswers();
    this.fetchAuthUser();
    this.snsUrl();
    this.isVisibleShuchedule();
  },
  methods: {
    ...mapActions('analyze', ['fetchAnalyzes']),
    ...mapMutations('question', ['clearAnswers']),
    ...mapActions('users', ['fetchAuthUser']),

    closeShucheduleModal() {
      this.isVisibleShuchedule();
    },
    closeCertificateModal() {
      this.isVisibleShowCertificate();
    },
    isVisibleShowCertificate() {
      this.showCertificate = !this.showCertificate;
    },
    isVisibleShuchedule() {
      this.showShuchedule = !this.showShuchedule;
    },
    snsUrl() {
      setTimeout(
        function () {
          this.sns.url = encodeURIComponent(`https://zeroken.herokuapp.com`);
          this.sns.title = encodeURIComponent('【酒テータス】');
          this.sns.twitter =
            'https://twitter.com/intent/tweet?url=' +
            this.sns.url +
            '&text=' +
            `私は${this.alcoholStrongness}でした。1軒目は${this.alcoholOrders}でいきます。` +
            '&hashtags=' +
            this.sns.hashtags;
         
         this.sns.line =
            'https://timeline.line.me/social-plugin/share?url=' +
            this.sns.url +
            '&text=' +
            this.sns.title +
            this.sns.lineDescription;
        }.bind(this),
        300
      );
    },
  },
};
</script>

<style scoped>
/* #result-page{
  
} */

#izakaya {
  background: url(../src/img/beer.jpeg) center center / cover no-repeat fixed;
}
.fade-enter-active,
.fade-leave-active {
  /* 表示時のCSS */
  will-change: opacity;
  transition: opacity 1000ms cubic-bezier(0.4, 0, 0.2, 1) 3000ms;
}
.fade-enter,
.fade-leave-to {
  /* 非表示時のCSS */
  opacity: 0;
}
</style>
