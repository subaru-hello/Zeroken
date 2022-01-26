<template>
  <div style="width: 100%; box-sizing: border-box">
    <div>
      <v-container
        fluid
        justify="center"
        style="background-color: rgb(0, 0, 0, 0.6); width: 80%; border-radius: 20%"
      >
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
                    {{ alcoholStrongness }}
                  </p>
                  <transition name="fade">
                    <div v-if="alcoholStrongness === '下戸'" class="text-center">
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
                  「 {{ analyze_results[analyze_results.length - 1]['description'] }}」
                </p>
              </v-col>
            </div>
            <div>
              <div class="text-center">
                <ZerokenButton
                  button-name="作成された酒ケジュール"
                  @click-response="isVisibleShuchedule()"
                ></ZerokenButton>
              </div>
            </div>
            <div>
              <ShowShucheduleModal
                v-if="showShuchedule"
                :alcoholDatas="alcohols"
                :childDialog="dialog"
                :loadingCircle="loading"
                :motivationImg="nextMotivationImg"
                @twitterShare="snsUrl"
                @closeModal="closeShucheduleModal"
              />
              <div>
                <!-- <ShowLoading /> -->
              </div>
            </div>

            <ShowCertificateModal
              v-if="showCertificate"
              :expirationDate="expirationDate"
              @closeCertificate="closeCertificateModal"
            />
          </v-col>
        </v-row>
      </v-container>
    </div>
    <v-row justify="center" align-content="center">
      <v-btn
        class="white--text mx-3 mt-4"
        style="background-color: rgb(0, 0, 0, 0.6); border-radius: 20%"
        @click="toTop()"
        x-large
      >
        トップに戻る
      </v-btn>
      <v-btn
        target="_blank"
        @click="snsUrl()"
        class="white--text mx-3 mt-4"
        style="background-color: rgb(0, 0, 0, 0.6); border-radius: 20%"
        x-large
        rel="noopener noreferrer"
      >
        シェアする<v-icon color="#1da1f2"> mdi-twitter </v-icon></v-btn
      >
    </v-row>
    <v-row justify="center" align-content="center">
      <v-btn
        @click="showRegisterModal = !showRegisterModal"
        class="white--text mx-3 mt-4"
        style="background-color: rgb(0, 0, 0, 0.6); border-radius: 20%"
        x-large
      >
        データを保存する(ログイン必須)<v-icon color="#1da1f2"> mdi-download </v-icon></v-btn
      >
    </v-row>
    <transition name="modal">
      <UserRegisterForm
        v-bind.sync="user"
        @create-user="registerFunction"
        v-if="showRegisterModal"
        register-title="ログインしてデータを保存する"
      ></UserRegisterForm>
    </transition>
    <v-row justify="center" align-content="center">
      <v-btn
        @click="alcoholInVeinDialog = true"
        class="white--text mx-3 mt-4"
        style="background-color: rgb(0, 0, 0, 0.6); border-radius: 20%"
        >アルコリズム①</v-btn
      >

      <v-btn
        @click="tastDialog = true"
        class="white--text mx-3 mt-4"
        style="background-color: rgb(0, 0, 0, 0.6); border-radius: 20%"
        >アルコリズム②</v-btn
      >

      <v-dialog
        v-model="alcoholInVeinDialog"
        scrollable
        max-width="80%"
        transition="dialog-top-transition"
      >
        <v-card>
          <v-card-title class="text-h5 alcoholism-back"
            >アルコール体内血中濃度計算グラフ</v-card-title
          >
          <v-card-text class="mx-auto"
            ><img :src="alcoholInVeinSrc" class="text-center" max-width="290" max-height="350"
          /></v-card-text>
          <v-card-text>
            厚生労働省 生活習慣病予防のための健康情報サイト
            (https://www.e-healthnet.mhlw.go.jp/information/dictionary/alcohol/ya-009.html)
          </v-card-text>
        </v-card>
      </v-dialog>

      <v-dialog v-model="tastDialog" scrollable max-width="100%" transition="dialog-top-transition">
        <v-card>
          <v-card-title class="text-h5 alcoholism-back"
            >TAST(東大式ALDH2スクリーニングテスト)グラフ</v-card-title
          >
          <img :src="tastSrc" max-width="370" class="text-center" max-height="350" />
          <v-card-text>
            (『お酒とのつきあい方をチェック』（後志保健福祉事務所保健福祉部）
            https://pehttps://perseus.blog.ss-blog.jp/2010-03-27rseus.blog.ss-blog.jp/2010-03-27)
          </v-card-text>
        </v-card>
      </v-dialog>
    </v-row>
    <v-layout>
      <v-row justify="center" align-content="center">
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
            <v-card-title class="contnents-image">
              {{ list.title }}
            </v-card-title>

            <v-card-subtitle>
              {{ list.subtext }}
            </v-card-subtitle>

            <!-- <v-card-actions>
              <v-spacer></v-spacer>

              <v-btn icon @click="show = !show">
                <v-icon>{{ show ? 'mdi-chevron-up' : 'mdi-chevron-down' }}</v-icon>
              </v-btn>
            </v-card-actions> -->

            <!-- <v-expand-transition>
              <div v-if="show">
                <v-divider></v-divider>
                <v-card-text>
                  {{ list.description }}
                </v-card-text>
              </div>
            </v-expand-transition> -->
          </v-card>
        </v-col>
      </v-row>
    </v-layout>
  </div>
</template>

<script>
import { mapActions, mapGetters, mapMutations } from 'vuex';
import StarRating from 'vue-star-rating';
import ZerokenButton from '../components/global/ZerokenButton';
import ShowShucheduleModal from '../components/result/ShowShucheduleModal';
import ShowCertificateModal from '../components/result/ShowCertificateModal';
import UserRegisterForm from '../components/forms/UserRegisterForm';
import axios from '../plugins/axios';
// import {fetchAlcohol }from '../apis/api'
export default {
  components: {
    StarRating,
    ZerokenButton,
    ShowShucheduleModal,
    ShowCertificateModal,
    UserRegisterForm,
  },
  data: function () {
    return {
      shuche: '',
      showShuchedule: false,
      alcoholContents: undefined,
      showRegisterModal: false,
      tastDialog: false,
      alcoholInVeinDialog: false,
      nonAlcoholImg: '',
      nextMotivationImg: '',
      alcohols: {},
      analyze: [],
      users: [],
      user: {
        nickname: '',
        email: '',
        password: '',
        password_confirmation: '',
      },
      logicLists: [
        {
          title: 'TAST',
          subtext:
            ' TASTという東大生が考案した、お酒の強さをはかる診断を使用しています。2013年にTwitterで拡散され、1.6万リツイートされるほどにバズりました。',
          description:
            '症状に対する３つの回答に点数が割り振られ、全部を合計してマイナスなら弱い～飲めない体質（ＡＡ型とＡＧ型）という風に判定できます。ZEROKENでは、より厳密に判断するために、「やや酒豪」「やや下戸」を追加しています。',
          img: require('../src/img/TAST.jpeg'),
          reference:
            '(『お酒とのつきあい方をチェック』（後志保健福祉事務所保健福祉部） https://pehttps://perseus.blog.ss-blog.jp/2010-03-27rseus.blog.ss-blog.jp/2010-03-27)',
        },
        {
          title: '酔い度合い算出ロジック',
          subtext:
            '  厚生労働省が用意している「体内血中アルコール濃度計算グラフ」を参考にして「酔いたい状態になるまでに必要なお酒の量」を算出しています。',
          description:
            '「酔い」というものは、血中アルコール濃度に応じて状態が変わってきます。ZEROKENでは、アルコール体内血中濃度と、なりたい状態「しっぽり・ほろ酔い・酩酊」をそれぞれ紐づけた独自のアルコリズムを構築しています。',
          img: require('../src/img/drunkness.png'),
          reference:
            '厚生労働省 生活習慣病予防のための健康情報サイト (https://www.e-healthnet.mhlw.go.jp/information/dictionary/alcohol/ya-009.html)',
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
      loading: true,
      analyzeData: '',
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
    ...mapGetters('analyze_result', ['analyze_results']),
    ...mapGetters('users', ['authUser']),
    currentUser() {
      return this.authUser['data']['attributes']['nickname'];
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
    alcoholInVeinSrc() {
      return require('../src/img/drunkness.png');
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
    strongnessStar() {
      const responseAnalyze = this.analyze_results;
      const sakeStrongness = responseAnalyze[responseAnalyze.length - 1]['alcohol_strongness'];
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
      const targetValues = this.alcohols;
const alcoholArray = targetValues["data"]
      const alcoholPercentage = 
     alcoholArray.map(function( value ) {
 
    //配列の各要素を2倍にする
    return value["alcohol_percentage"];
 
});
      const logoInspect = alcoholPercentage === 0 ? 'mdi-cup' : 'mdi-glass-mug';
      return logoInspect;
    },
  },
  mounted() {
    this.analyze_results = this.fetchAnalyzes;
    this.show = true;
    this.isVisibleShuchedule();
  },
  updated() {},
  async created() {
    const alcoholResponses = await axios.get('/alcohols');
    const changeAlcoholData = await (this.alcohols = alcoholResponses.data);
    this.loading = false;
    const analyzeResponses = await axios.get('/analyze_results');
    const targetAnalyze = analyzeResponses.data;

    this.analyzeData = targetAnalyze;
    const analyzeShuchedule = (this.alcoholOrders = changeAlcoholData)
analyzeShuchedule 
    this.fetchAnalyzes();
    this.clearAnswers();
    this.fetchAuthUser();
    this.currentAnalyze();
    this.changeSrc();
    // this.strongnessStar();
    //  this.isAlcohol() ;
  },
  methods: {
    ...mapActions('analyze_results', ['fetchAnalyzes']),
    ...mapMutations('question', ['clearAnswers']),
    // ...mapMutations('my_shuchedule', ['addMyShuchedule']),
    ...mapActions('users', ['fetchAuthUser']),
    ...mapActions('users', ['registerUser']),
    // ...mapActions('my_shuchedule', ['createMyShuchedule']),
    ...mapActions('snackbar', ['fetchSnackbarData']),
    async registerFunction() {
      const targetAnalyzes = this.analyze_results;
      let promise = new Promise((resolve, reject) => {
        // #1

        const updateSchuchedule = {
          user_id: targetUser.data.id,
          succeed_shuchedule: analyzeShuchedule,
          succeed_alcohol_strongness: analyzeAlcoholStrongness,
        };
        resolve(targetUser, this.createMyShuchedule(updateSchuchedule));
        reject();

        promise.then(() => {
          // #2
          return new Promise((resolve, reject) => {
            resolve(
              this.fetchSnackbarData({
                msg: '新規登録に成功しました',
                color: 'success',
                isShow: true,
              })
            );
            reject(
              this.fetchSnackbarData({
                msg: '新規登録に失敗しました',
                color: 'error',
                isShow: true,
              })
            );
          });
        });
      })
        .then(() => {
          // #3
          return new Promise((resolve, reject) => {
            resolve(this.$router.push({ name: 'UserProfile' }));
            reject(console.log());
          });
        })
        .catch(() => {
          // エラーハンドリング
          console.error('Something wrong!');
        });
      return promise;
    },
    toTop() {
      this.$router.push({ name: 'ZerokenTop' });
    },
    async currentAnalyze() {
      const responseAnalyze = await axios.get('/analyze_results');
      const targetAnalyze = await responseAnalyze['data'];
      const targetAlcoholStrongness = targetAnalyze[targetAnalyze.length - 1]['alcohol_strongness'];
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
      const AlcoholStrongness = (this.alcoholStrongness = result);
      return AlcoholStrongness;
    },
    alcoholDatas(response) {
      this.alcohols = response.data;
    },
    async changeSrc() {
      const responseAnalyze = await axios.get('/analyze_results');
      const thisAnalyze = await responseAnalyze['data'];
      const targetAnalyze = thisAnalyze[thisAnalyze.length - 1];
      const targetMotivation = targetAnalyze['next_motivation'];

      function checkMotivation(target) {
          return require(`../src/img/${target}_stamp.png`);
      }
      const result = checkMotivation(targetMotivation);

      const nextMotivation = (this.nextMotivationImg = result);
      return nextMotivation;
    },
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
          this.sns.url = encodeURIComponent(`https://www.zeroken.site`);
          this.sns.title = encodeURIComponent('【酒テータス】');

          const targetOrder = this.alcoholOrders;
          const firstOrder = targetOrder[0]['name'];
          const secondOrder = targetOrder[1]['name'];
          const thirdOrder = targetOrder[2]['name'];
          const forthOrder = targetOrder[3]['name'];
          // const thisAnalyze = this.analyzes;
          // const targetAnalyze = thisAnalyze[thisAnalyze.length - 1];
          // const sipporiArray = [
          //   'あんま飲みたくない',
          //   '今日はソフドリがいい',
          //   '今月試合あるから飲みたくない',
          //   '推しの録画をみたいから飲みたくない',
          // ];
          // const horoyoiArray = [
          //   '途中で帰りたい',
          //   '今日はソフドリがいい',
          //   '金欠だから飲みたくない',
          //   'ほろ酔いくらいまで飲みたい',
          // ];
          // const meiteiArray = [
          //   'とことん飲みたい',
          //   '酒で記憶を飛ばしたい',
          //   'あるだけ飲みたい',
          //   'とにかくたくさん飲みたい',
          // ];
          const characterMetapherWeak = [
            '五条悟も下戸らしいですよ',
            '織田信長も下戸らしいですよ',
            '夏目漱石も下戸らしいですよ',
            '戸愚呂弟も下戸らしいですよ',
            '西郷隆盛も下戸らしいですよ',
            '坂田銀時も下戸らしいですよ',
            '四乃森蒼紫も下戸らしいですよ',
            'チョッパーも下戸らしいですよ',
            '井之頭五郎も下戸らしいですよ',
            '南海先生も下戸らしいですよ',
          ];
          const characterMetapherNormal = ['凡人ですね。'];
          const characterMetapherStrong = [
            'ロロノアゾロくらい強いですね',
            '黒ひげくらい強いですね',
            '白ひげくらい強いですね',
            'ゴールドロジャーくらい強いですね',
            '赤井秀一くらい強いですね',
            '次元大介くらい強いですね',
            '葛城ミサトくらい強いですね',
            '六本木朱美くらい強いですね',
            '松本乱菊くらい強いですね',
            '只野仁くらい強いですね',
            'トリコくらい強いですね',
            '上杉謙信くらい強いですね',
            '張飛くらい強いですね',
            'カイドウくらい強いですね',
            'ハネオツパイくらい強いですね',
          ];

          // const sippporiiKibun = sipporiArray[Math.floor(Math.random() * sipporiArray.length)];
          // const horoyoiKibun = horoyoiArray[Math.floor(Math.random() * horoyoiArray.length)];
          // const meiteiKibun = meiteiArray[Math.floor(Math.random() * meiteiArray.length)];
          // const targetMotivation = targetAnalyze['next_motivation'];
          // function checkMotivation(target) {
          //   if (target === 'flesh') {
          //     return sippporiiKibun;
          //   } else if (target === 'tipsy') {
          //     return horoyoiKibun;
          //   } else {
          //     return meiteiKibun;
          //   }
          // }
          // const result = checkMotivation(targetMotivation);

          const weakCharacter =
            characterMetapherWeak[Math.floor(Math.random() * characterMetapherWeak.length)];
          const normalCharacter =
            characterMetapherNormal[Math.floor(Math.random() * characterMetapherNormal.length)];
          const strongCharacter =
            characterMetapherStrong[Math.floor(Math.random() * characterMetapherStrong.length)];

          const userAlcoholStrongness = this.alcoholStrongness;
          function checkAlcoholStrongness(target) {
            if (target === '酒豪') {
              return strongCharacter;
            } else if (target === '下戸') {
              return weakCharacter;
            } else {
              return normalCharacter;
            }
          }
          const strongnessResult = checkAlcoholStrongness(userAlcoholStrongness);
          this.sns.twitter =
            'https://twitter.com/intent/tweet?url=' +
            this.sns.url +
            '&text=' +
            `【酒テータス】%0A${this.alcoholStrongness}%0A${strongnessResult}%0A【1軒目の酒ケジュール】%0A1軒目は%0A1.${firstOrder}%202.${secondOrder}%203.${thirdOrder}%204.${forthOrder}%0Aでいきます` +
            '&hashtags=' +
            this.sns.hashtags;
          window.location.href = this.sns.twitter;
        }.bind(this),
        100
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
.modal-enter {
  transition: opacity 100ms cubic-bezier(0.4, 0, 0.2, 1) 1000ms;
}

.modal-leave-active {
  opacity: 0;
}

.modal-enter .modal-container,
.modal-leave-active .modal-container {
  -webkit-transform: scale(1.1);
  transform: scale(1.1);
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

.alcoholism-back {
  background: url(../src/img/woodtile.jpeg) center center / cover no-repeat fixed;
  border-radius: 20%;
}
</style>
