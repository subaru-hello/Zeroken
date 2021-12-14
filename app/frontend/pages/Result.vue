<template>
  <div id="izakaya" style="width: 100%">
    <div>
      <v-container
        fluid
        justify="center"
        style="background-color: rgb(0, 0, 0, 0.6); width: 50%; border-radius: 20%"
      >
        <v-row class="d-flex">
          <v-col cols="12">
            <div>
              <v-col>
                <p class="text-center white--text" style="font-size: 40px">酒テータス</p>
              </v-col>
              <v-col> </v-col>
            </div>
            <div class="d-flex" justify="center" align-content="center">
              <star-rating
                :rating="strongnessStar"
                :show-rating="false"
                read-only
                class="mx-auto"
              ></star-rating>
            </div>
            <div class="d-flex" align-content="center">
              <v-col>
                <p class="text-center"></p>
                <v-col>
                  <p class="text-center white--text" style="font-size: 40px">
                    {{ currentAnalyze }}
                  </p>
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
              <v-col class="text-center">
                <p>
                  <img :src="`${changeSrc}`" width="150" height="150" />
                </p>
              </v-col>
            </div>
            <transition name="fade">
              <div v-if="currentAnalyze === '下戸'" class="text-center">
                <v-btn
                  v-if="show"
                  x-large
                  @click="showCertificate = !showCertificate"
                  class="text-center"
                  >証明書が発行されました</v-btn
                >
              </div>
            </transition>
            <modal v-if="showCertificate" @close="showCertificate = false">
              <transition name="modal">
                <div class="modal-mask">
                  <div class="modal-wrapper">
                    <div class="modal-container" style="width: 500px; height: 300px">
                      <div class="modal-body">
                        <slot name="body">
                          <v-img :src="certificateSrc" width="500" height="200" />
                        </slot>
                      </div>

                      <div class="modal-footer">
                        <v-btn class="modal-default-button" @click="showCertificate = false">
                          納めました
                        </v-btn>
                      </div>
                    </div>
                  </div>
                </div>
              </transition>
              <v-card> </v-card>
            </modal>
          </v-col>
        </v-row>
      </v-container>
    </div>

    <v-layout>
      <v-col
        class="text-center mx-auto my-5 form"
        style="background-color: rgb(0, 0, 0, 0.6); width: 50%; border-radius: 20%"
        elevation="2"
        shaped
        id="form"
      >
        <v-card-title style="width: 100%" class="headline justify-center">
          <h2 class="centered white--text" style="white--text">酒ケジュール</h2>
        </v-card-title>
        <v-container>
          <v-row justify="center" align-content="center">
            <v-col cols="12" sm="3" class="d-flex" v-for="data in contents" :key="data.id">
              <v-card
                class="text-center mx-auto my-5 form"
                elevation="2"
                width="100%"
                shaped
                id="form"
              >
                <v-icon>{{ data.alcohol_percentage === 0 ? 'mdi-cup' : 'mdi-glass-mug' }}</v-icon>

                <v-card-title style="width: 100%" class="headline justify-center">
                  {{ data.name }}
                </v-card-title>
                <v-row justify="center" align-content="center">
                  <p>度数: {{ data.alcohol_percentage }}%</p>
                  <p>量: {{ data.alcohol_amount }}ml</p>
                </v-row>
              </v-card>
            </v-col>
          </v-row>
          <v-btn @click="dialog2 = !dialog2"> 詳細を見る </v-btn>
          <!-- <transition name="fade"> -->
          <div
            style="overflow-y: auto"
            v-show="dialog2"
            max-width="100%"
            transition="dialog-top-transition"
            justify="center"
            align-content="center"
          >
            <v-row class="d-flex" justify="center" align-content="center">
              <v-col cols="3" md="12" v-for="data in contents" :key="data.id">
                <v-card
                  class="text-center mx-auto my-5 form"
                  elevation="2"
                  width="100%"
                  shaped
                  id="form"
                >
                  <v-card-title style="width: 100%" class="headline justify-center">
                    {{ data.name }}
                  </v-card-title>
                  <v-row justify="center">
                    <v-icon>{{
                      data.alcohol_percentage === 0 ? 'mdi-cup' : 'mdi-glass-mug'
                    }}</v-icon>
                    <!-- <v-img
                        :lazy-src="data.image_url"
                        :src="data.image_url"
                        max-height="150"
                        max-width="100"
                      >
                        <template v-slot:placeholder>
                          <v-row class="fill-height ma-0" align="center" justify="center">
                            <v-progress-circular
                              indeterminate
                              color="grey lighten-5"
                            ></v-progress-circular>
                          </v-row>
                        </template>
                      </v-img> -->
                  </v-row>
                  <v-row justify="center" align-content="center">
                    <p>度数: {{ data.alcohol_percentage }}%</p>
                    <p>量: {{ data.alcohol_amount }}ml</p>
                  </v-row>
                  <div>
                    {{ data.description }}
                  </div>
                </v-card>
              </v-col>
            </v-row>
          </div>
          <!-- </transition> -->
        </v-container>
      </v-col>
    </v-layout>

    <v-row justify="center" align-content="center">
      <v-btn
        class="centered white--text"
        :to="{ name: 'ZerokenTop' }"
        style="background-color: rgb(0, 0, 0, 0.6); width: 50%; border-radius: 20%"
        text
        rounded
        plain
        x-large
      >
        もう一度診断する
      </v-btn>
      <v-dialog v-model="dialog" width="400">
        <template v-slot:activator="{ on }">
          <v-btn
            v-on="on"
            class="white--text"
            style="background-color: rgb(0, 0, 0, 0.6); width: 50%; border-radius: 20%"
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
                <v-icon color="indigo"> mdi-facebook </v-icon>
              </v-list-item-action>
              <v-card-title>Facebook</v-card-title>
            </v-list-item>
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
  </div>
</template>

<script>
import { mapActions, mapGetters, mapMutations } from 'vuex';
import StarRating from 'vue-star-rating';
import axios from '../plugins/axios';
export default {
  components: {
    StarRating,
  },
  data: function () {
    return {
      shuche: '',
      alcohols: [],
      analyze: [],
      users: [],
      logo: '',
      errors: '',
      show: false,
      dialog: false,
      dialog0: false,
      dialog1: false,
      dialog2: false,
      showCertificate: false,
      Twitter: 'Twitter',
      rating: [],
      sns: {
        twitter: '',
        url: '',
        title: '',
        hashtags: 'ZEROKEN,アルハラ防止',
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
      return result;
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
      return result;
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

      const analyzeShuchedule = thisAnalyze[thisAnalyze.length - 1]['shuchedule'];

      const targetValues = this.alcohols;

      const contentsOfTarget = Object.values(targetValues)[analyzeShuchedule];

      return contentsOfTarget;
    },
    imgSrc() {
      return require('../src/img/line.png');
    },
    sakeSrc() {
      return require('../src/img/sake.svg');
    },
    drinkSrc() {
      return require('../src/img/drink.svg');
    },
    ippaiSrc() {
      return require('../src/img/ippai_shuki.png');
    },
    sugusakeSrc() {
      return require('../src/img/sugusake_stamp.png');
    },
    sugumeiteiSrc() {
      return require('../src/img/sugumeitei_stamp.png');
    },
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
  },
  mounted() {
    axios.get('/alcohols').then((alcoholResponse) => (this.alcohols = alcoholResponse.data));
    this.analyze = this.fetchAnalyzes;
    this.show = true;
  },
  updated() {},
  watch: {
    //ページ移動するたびに
    $route(to, from) {
      this.snsUrl();
    },
  },
  created() {
    this.fetchAnalyzes();
    this.clearAnswers();
    this.fetchAuthUser();
    this.snsUrl();
  },
  methods: {
    ...mapActions('analyze', ['fetchAnalyzes']),
    ...mapMutations('question', ['clearAnswers']),
    ...mapActions('users', ['fetchAuthUser']),
    snsUrl() {
      setTimeout(
        function () {
          // 現在のurlをエンコード
          this.sns.url = encodeURIComponent(`https://zeroken.herokuapp.com`);
          this.sns.title = encodeURIComponent(document.title);
          this.sns.twitter =
            'https://twitter.com/intent/tweet?url=' +
            this.sns.url +
            '&text=' +
            this.sns.title +
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
html {
  overflow-x: hidden;
  width: 1024px;
}
#izakaya {
  background: url(../src/img/beer.jpeg) center center / cover no-repeat fixed;
}
.fade-enter-active,
.fade-leave-active {
  /* 表示されている際のCSSはこのブロックに記述 */
  will-change: opacity;
  transition: opacity 1000ms cubic-bezier(0.4, 0, 0.2, 1) 3000ms;
}
.fade-enter,
.fade-leave-to {
  /* 非表示の際のCSSはこのブロックに記述 */
  opacity: 0;
}
</style>
