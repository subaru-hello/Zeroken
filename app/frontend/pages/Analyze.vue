<template>
  <!-- <div> -->
    <v-stepper v-model="e6" vertical id="izakaya">
      <v-stepper-step :complete="e6 > 1" step="1">
        <!-- <span class="white--text " 
          >お酒の強さを診断
        </span> -->
      </v-stepper-step>
      <v-spacer />
      <v-stepper-content step="1">
        <v-row justify="center" align-content="center">
          <h2 class="ma-5 white--text rounded bold" style="background: rgba(0, 0, 0, 0.4)">
            お酒を飲んでいる時の状態を選択してください(13項目)
          </h2>
          <v-col
            v-for="question in questions"
            :key="question.num"
            cols="12"
            xs="12"
            sm="12"
            md="12"
            lg="12"
          >
            <v-layout justify-center>
              <v-card-title>
                <v-container>
                  <v-card
                    class="text-center mx-auto my-5 form rounded"
                    style="border-radius: 50%"
                    elevation="24"
                    shaped
                    width="500"
                    id="form"
                  >
                    <v-card-title
                      style="width: 100% white-space:pre-wrap;"
                      class="headline justify-center v-radio"
                      :id="'bigq' + question.num"
                    >
                      問{{ question.num }}.
                      {{ question.title }}
                    </v-card-title>
                    <div :id="'smallq' + question.num" row>
                      <v-btn
                        outlined
                        :ripple="{ class: 'gray--text' }"
                        @click="
                          clickScroll($event);
                          countAnswer(question.num, 1);
                        "
                        >1: いつも</v-btn
                      >
                      <v-btn
                        class="mx-auto justify-center"
                        outlined
                        :ripple="{ center: false, class: 'gray--text' }"
                        @click="
                          clickScroll($event);
                          countAnswer(question.num, 2);
                        "
                        label="2: 時々"
                        >2: 時々</v-btn
                      >
                      <v-btn
                        class="mx-auto justify-center"
                        outlined
                        :ripple="{ center: false, class: 'gray--text' }"
                        @click="
                          clickScroll($event);
                          countAnswer(question.num, 3);
                        "
                        label="3: 全くない"
                        >3: 全くない</v-btn
                      >
                    </div>
                    <p v-if="question.answer === '未回答'">
                      <strong class="red--text accent-3">未回答です！</strong>
                    </p>
                    <p class="py-3" style="font-size: 16px">あなたの回答： {{ question.answer }}</p>
                  </v-card>
                </v-container>
              </v-card-title>
            </v-layout>
          </v-col>
          <p class="Page-Btn">
            <v-btn fab dark small color="primary" @click="scrollTop()">
              <v-icon>mdi-arrow-up-thick</v-icon>
            </v-btn>
          </p>
          <p
            v-if="isVisible"
            class="text-center red--text text--lightn-3 my-5 mb-5"
            outlined
            tile
            height="150"
          >
            <span style="background-color: white"></span>未回答の項目があります。
          </p>
        </v-row>
        <v-spacer></v-spacer>
        <v-col cols="12" xs="4" sm="6" md="12" lg="12" class="text-center">
          <ZerokenButton
            @click-response="
              e6 = 2;
              clickScrollNext();
            "
            :isVisible="isVisible"
            >次へ</ZerokenButton
          >
        </v-col>
      </v-stepper-content>

      <v-stepper-step :complete="e6 > 2" step="2">
        <!-- <span class="white--text">体重設定画面 </span> -->
      </v-stepper-step>
      <v-stepper-content step="2">
        <template v-if="show">
          <v-container justify="center" align-content="center" class="analyze-title-weight">
            <h2 class="mt-5 black--text text-center">現在の体重を選択してください</h2>
            <v-layout justify-center>
              <v-row justify-center>
                <v-col cols="12" xs="12" sm="12" md="12" lg="12">
                  <v-select
                    v-model="weight"
                    :items="items"
                    label="クリックで体重を選択"
                    class="white--text"
                  ></v-select>
                </v-col>
              </v-row>
            </v-layout>
          </v-container>
        </template>
        <v-col cols="12" xs="4" sm="6" md="12" lg="12" class="text-center">
          <ZerokenButton
            v-if="weight != '体重を選択'"
            @click-response="e6 = 3"
            :isVisible="isVisible"
            >次へ</ZerokenButton
          >
        </v-col>
      </v-stepper-content>
      <v-stepper-step :complete="e6 > 3" step="3">
        <!-- <span class="white--text analyze-title" >
          飲みベーション選択画面</span
        > -->
      </v-stepper-step>

      <v-stepper-content step="3">
        <template v-if="show">
          <v-container justify="center" align-content="center" class="analyze-title-weight">
            <v-layout justify-center>
              <v-row justify-center>
                <v-col cols="12" xs="12" sm="12" md="12" lg="12">
                  <h1 class="text-center black--text" style="font-size: 25px">
                    一次会でどのくらい酔いたいかクリックしてください
                  </h1>

                  <v-dialog v-model="dialog" width="500">
                    <template #activator="{ on, attrs }">
                      <div>
                        <v-layout>
                          <v-row justify="center" align-content="center">
                            <div>
                              <v-radio-group
                                cols="12"
                                sm="3"
                                v-model="nextMotivation"
                                style="font-size: 30px"
                                class="text-center"
                                :ripple="{ center: false, class: 'gray--text' }"
                                v-bind="attrs"
                                v-on="on"
                              >
                                <v-radio
                                  :value="2"
                                  style="font-size: 20px"
                                  label="酩酊になりたい"
                                ></v-radio>
                                <!-- <img
                                  :src="imgSrc"
                                  width="150"
                                  height="150"
                                  class="text-center"
                                  :value="2"
                                /> -->

                                <v-radio
                                  :value="1"
                                  style="font-size: 20px"
                                  label="ほろ酔いになりたい"
                                ></v-radio>
                                <!-- <img :src="sakeSrc" width="150" height="150" class="text-center" /> -->

                                <v-radio
                                  :value="0"
                                  style="font-size: 20px"
                                  label="ほぼしらふでいい"
                                ></v-radio>

                                <!-- <img
                                  :src="drinkSrc"
                                  width="150"
                                  height="150"
                                  class="text-center"
                                  :value="0"
                                /> -->
                              </v-radio-group>

                              <ZerokenButton
                                v-if="nextMotivation >= 0"
                                class="text-center"
                                :ripple="{ center: false, class: 'gray--text' }"
                                v-bind="attrs"
                                v-on="on"
                                @click-response="createShuchedule()"
                                >酒ケジュールを作成する
                              </ZerokenButton>
                            </div>
                          </v-row>
                        </v-layout>
                      </div>
                      <transition name="modal">
                        <div v-if="showModal" @close="showModal = false">
                          <div class="modal-mask">
                            <div class="modal-wrapper">
                              <div class="modal-container">
                                <div class="modal-body" align-content="center">
                                  <slot name="body" style="padding-left: 20px">
                                    <p style="font-size: 25px" class="text-center">
                                      酒ケジュール作成中
                                    </p>
                                    <div align="center">
                                      <Facebook-loader />
                                      <img :src="highballSrc" width="50" height="50" />
                                      <Facebook-loader />
                                    </div>
                                  </slot>
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>
                      </transition>
                    </template>
                  </v-dialog>
                </v-col>
              </v-row>
            </v-layout>
          </v-container>
        </template>
      </v-stepper-content>
    </v-stepper>
  <!-- </div> -->
</template>
<script>
import FacebookLoader from '@bit/joshk.vue-spinners-css.facebook-loader';
// import axios from '../plugins/axios';
import ZerokenButton from '../components/global/ZerokenButton';
import { mapGetters, mapMutations, mapActions } from 'vuex';
const start = 40;
const end = 100;
const weightRange = [...Array(end - start + 1).keys()].map((e) => e + start);
export default {
  data() {
    return {
      row: null,
      items: weightRange,
      isVisible: '',
      dialog: false,
      show: false,
      radio: '',
      showModal: false,
      nextMotivation: '',
      // users: [],
      e6: 1,
      weight: '体重を選択',
    };
  },
  components: {
    FacebookLoader,
    ZerokenButton,
  },
  computed: {
    ...mapGetters('question', ['questions']),
    ...mapGetters('analyze', ['analyzes']),
    ...mapGetters('users', ['authUser']),
    highballSrc() {
      return require('../src/img/high_ball_kanpai.jpg');
    },
    imgSrc() {
      return require('../src/img/meitei_stamp.png');
    },
    sakeSrc() {
      return require('../src/img/tipsy_stamp.png');
    },
    drinkSrc() {
      return require('../src/img/flesh_stamp.png');
    },
  },
  created() {
    console.warn('this.authUser');
    console.warn(this.authUser);
    this.fetchAuthUser();
    this.clearAnswers();
  },
  mounted() {
    // axios.get('/users').then((userResponse) => (this.users = userResponse.data));
    console.log('this.authUser');
    console.log(this.authUser.data);
    const notAnswers = this.questions.filter((question) => question.answer === '未回答');
    if (notAnswers.length > 0) {
      this.isVisible = true;
    } else {
      this.isVisible = false;
    }
  },
  updated() {
    const notAnswers = this.questions.filter((question) => question.answer === '未回答');
    if (notAnswers.length > 0) {
      this.isVisible = true;
    } else {
      this.isVisible = false;
    }
  },
  methods: {
    ...mapMutations('question', ['updateAnswer']),
    ...mapMutations('question', ['clearAnswers']),
    ...mapMutations('analyze', ['addAnalyze']),
    ...mapActions('analyze', ['createAnalyze']),
    ...mapActions('users', ['fetchAuthUser']),

    scrollTop() {
      window.scrollTo({
        top: 0,
        behavior: 'smooth',
      });
    },

    countAnswer(indexNum, updAnswer) {
      this.updateAnswer({ indexNum, updAnswer });
    },
    async createShuchedule() {
      //TODO 要リファクト
      //以下の式を塊に切り出してthis.で呼び出す
      var trueAnswers = this.questions;
      console.log("trueAnswers")
      console.log(trueAnswers)
      const answer0 = trueAnswers[0]['answer'];
      const answer1 = trueAnswers[1]['answer'];
      const answer2 = trueAnswers[2]['answer'];
      const answer3 = trueAnswers[3]['answer'];
      const answer4 = trueAnswers[4]['answer'];
      const answer5 = trueAnswers[5]['answer'];
      const answer6 = trueAnswers[6]['answer'];
      const answer7 = trueAnswers[7]['answer'];
      const answer8 = trueAnswers[8]['answer'];
      const answer9 = trueAnswers[9]['answer'];
      const answer10 = trueAnswers[10]['answer'];
      const answer11 = trueAnswers[11]['answer'];
      const answer12 = trueAnswers[12]['answer'];

      let answerFirst = answer0 === 1 ? -10.04 : answer0 === 2 ? 8.95 : 5.22; //重要
      let answerSecond = answer1 === 1 ? -0.43 : answer1 === 2 ? -2.98 : 1.2;
      let answerThird = answer2 === 1 ? 3.37 : answer2 === 2 ? 0.38 : 0.38;
      let answerForth = answer3 === 1 ? -0.58 : answer3 === 2 ? -1.27 : 0.25;
      let answerFifth = answer4 === 1 ? 0.31 : answer4 === 2 ? 0.36 : -1.03;
      let answerSixth = answer5 === 1 ? 0 : answer5 === 2 ? -4.11 : 0.1;
      let answerSeventh = answer6 === 1 ? -0.79 : answer6 === 2 ? 0.07 : 0.01;
      let answerEighth = answer7 === 1 ? 0.83 : answer7 === 2 ? 0.62 : -0.24;
      let answerNinth = answer8 === 1 ? -3.25 : answer8 === 2 ? 1.43 : -0.44;
      let answerTenth = answer9 === 1 ? -3.25 : answer9 === 2 ? 1.43 : -0.44;
      let answerEleventh = answer10 === 1 ? -10.07 : answer10 === 2 ? -0.79 : 10.8;
      let answerTwelvth = answer11 === 1 ? 8.15 : answer11 === 2 ? -2.42 : 0.14;
      let answerThirteenth = answer12 === 1 ? -4.34 : answer12 === 2 ? 2.69 : -0.19;

      const sumResult =
        answerFirst +
        answerSecond +
        answerThird +
        answerForth +
        answerFifth +
        answerSixth +
        answerSeventh +
        answerEighth +
        answerNinth +
        answerTenth +
        answerEleventh +
        answerTwelvth +
        answerThirteenth;
        console.log("sumResult")
      console.log(sumResult)
      let AlcoholStrongness =
        sumResult > 3 ? 4 : sumResult > 0 ? 3 : sumResult === 0 ? 2 : sumResult > -3 ? 1 : 0; //4: 酒豪, 3: やや酒豪, 2: 普通, 1: やや下戸, 0: 下戸
      let Nomivation = this.nextMotivation; //flesh: 0, tipsy: 1, heavy_drunk: 2
       console.log("AlcoholStrongness")
      console.log(AlcoholStrongness)
      let alcoholInVein =
        AlcoholStrongness === 4 && Nomivation === 0
          ? 0.04
          : AlcoholStrongness === 4 && Nomivation === 1
          ? 0.1
          : AlcoholStrongness === 4 && Nomivation === 2
          ? 0.15
          : AlcoholStrongness === 3 && Nomivation === 0
          ? 0.04
          : AlcoholStrongness === 3 && Nomivation === 1
          ? 0.09
          : AlcoholStrongness === 3 && Nomivation === 2
          ? 0.14
          : AlcoholStrongness === 2 && Nomivation === 0
          ? 0.03
          : AlcoholStrongness === 2 && Nomivation === 1
          ? 0.07
          : AlcoholStrongness === 2 && Nomivation === 2
          ? 0.13
          : AlcoholStrongness === 1 && Nomivation === 0
          ? 0.03
          : AlcoholStrongness === 1 && Nomivation === 1
          ? 0.06
          : AlcoholStrongness === 1 && Nomivation === 2
          ? 0.12
          : AlcoholStrongness === 0 && Nomivation === 0
          ? 0.02
          : AlcoholStrongness === 0 && Nomivation === 1
          ? 0.05
          : AlcoholStrongness === 0 && Nomivation === 2
          ? 0.11
          : 0.02;
           console.log("alcoholInVein")
      console.log(alcoholInVein)
      let coefficient = 833;
      let yourWeight = this.weight;
      let totalAlcoholAmount = yourWeight * coefficient * alcoholInVein;
      let yourShuchedule =
        totalAlcoholAmount < 2000
          ? 21
          : totalAlcoholAmount < 2500
          ? 20
          : totalAlcoholAmount < 3000
          ? 19
          : totalAlcoholAmount < 3500
          ? 18
          : totalAlcoholAmount < 4000
          ? 17
          : totalAlcoholAmount < 4500
          ? 16
          : totalAlcoholAmount < 5000
          ? 15
          : totalAlcoholAmount < 5500
          ? 14
          : totalAlcoholAmount < 6000
          ? 13
          : totalAlcoholAmount < 6500
          ? 12
          : totalAlcoholAmount < 7000
          ? 11
          : totalAlcoholAmount < 7500
          ? 10
          : totalAlcoholAmount < 8000
          ? 9
          : totalAlcoholAmount < 8500
          ? 8
          : totalAlcoholAmount < 9000
          ? 7
          : totalAlcoholAmount < 9500
          ? 6
          : totalAlcoholAmount < 10000
          ? 5
          : totalAlcoholAmount < 10500
          ? 4
          : totalAlcoholAmount < 11000
          ? 3
          : totalAlcoholAmount < 11500
          ? 2
          : totalAlcoholAmount < 12000
          ? 1
          : totalAlcoholAmount < 12500
          ? 0
          : 24;
               console.log("yourShuchedule ")
      console.log(yourShuchedule )
      let Description =
        sumResult < -20
          ? '過去に飲み会でトラウマを抱えているタイプの下戸'
          : sumResult < -19
          ? '飲み会にいてくれるだけで感謝されるタイプの下戸'
          : sumResult < -18
          ? '先輩や上司から好かれるタイプの下戸'
          : sumResult < -17
          ? '本当は家でのんびり華金を過ごしたいタイプの下戸'
          : sumResult < -16
          ? '酒は飲むより飲まれるタイプの下戸'
          : sumResult < -15
          ? '飲んだら顔がすぐに真っ赤になるタイプの下戸'
          : sumResult < -14
          ? '飲み会で体調を心配されるタイプの下戸'
          : sumResult < -13
          ? '飲まされると顔が赤くなって口数が少なくなるタイプの下戸'
          : sumResult < -12
          ? '家でしっぽりと飲む方が好きなタイプの下戸'
          : sumResult < -11
          ? '弱いけど呑みたいタイプの下戸'
          : sumResult < -10
          ? '酒は弱いが行きつけのバーを持っているタイプの下戸'
          : sumResult < -9
          ? '先輩から好かれるタイプの下戸'
          : sumResult < -8
          ? '強いお酒を飲んでみたいと密かに思っているタイプの下戸'
          : sumResult < -7
          ? '好きな人と飲むとすぐによっちゃうタイプの下戸'
          : sumResult < -6
          ? 'お酒が入るといつもの自分と違う一面が出てしまうタイプの下戸'
          : sumResult < -5
          ? '上司の前だと酔わないが気を許した仲間の前だとすぐに酔うタイプの下戸'
          : sumResult < -4
          ? 'お酒強い？と聞かれた時の返答に困っているタイプの下戸'
          : sumResult < -3
          ? '酔った時の対処法を心得ているタイプのやや下戸'
          : sumResult < -2
          ? '強くも弱くもないため、お酒飲める人？と聞かれた時の返答に困っているタイプのやや下戸'
          : sumResult < -1
          ? '人並みには飲めるよと周りに言うタイプの普通の人'
          : sumResult < 0
          ? '度数の高いお酒を飲んだらバタンキューするやや酒豪'
          : sumResult < 1
          ? 'まあ飲めるけどそこまでお酒が好きじゃないやや酒豪'
          : sumResult < 2
          ? '周囲の酒の空き具合を見て次何飲む？と聞ける酒豪'
          : sumResult < 3
          ? '気配り上手で先輩から好かれるタイプの酒豪'
          : sumResult < 4
          ? 'お酒よりおつまみが好きなタイプの酒豪'
          : sumResult < 5
          ? '気持ち悪くなるまで呑み続けてしまう愉快なタイプの酒豪'
          : sumResult < 6
          ? '飲み会の場でテンションが高くなって飲み会終わりに反省するタイプの酒豪'
          : sumResult < 7
          ? '潰れた人を介抱する技術を磨いてきたタイプの酒豪'
          : sumResult < 8
          ? '異性の前で仕事の話をしてウザがられるタイプの酒豪'
          : sumResult < 9
          ? '日本酒は獺祭と豪快しか知らないタイプの酒豪'
          : sumResult < 10
          ? '酒の強さを聞かれたらまあ人並みにはと答えるタイプの酒豪'
          : sumResult < 11
          ? '酒が強いキャラで界隈に轟かせてるタイプの酒豪'
          : sumResult < 12
          ? '九州の血が入っているタイプの酒豪'
          : sumResult < 13
          ? '飲み会の席では潰れた人の介抱をする係を任されるタイプの酒豪'
          : sumResult < 14
          ? '酒呑として界隈では有名な酒豪。'
          : sumResult < 15
          ? '日本酒や焼酎が飲めるためよくおじさんに呑みの誘いを受けるタイプの酒豪'
          : '超弩級のウルトラ酒呑人。血液が酒でできている。';

      let promise = new Promise((resolve, reject) => {
        // #1
        const updateAnalyze = {
          total_points: sumResult,
          alcohol_strongness: AlcoholStrongness,
          next_motivation: Nomivation, //flesh: 0, tipsy: 1, heavy_drunk: 2
          shuchedule: yourShuchedule,
          description: Description,
        };
console.log('updateAnalyze' )
console.log(updateAnalyze )
        resolve(

          this.createAnalyze(updateAnalyze)
          // this.clearAnswers()
        );
        reject();
      });
      promise
        .then(() => {
          // #2
          return new Promise((resolve, reject) => {
            setTimeout(() => {
              resolve((this.showModal = true));
              reject();
            }, 600);
          });
        })
        .then(() => {
          // #3
          return new Promise((resolve, reject) => {
            setTimeout(() => {
              resolve(this.$router.push('/result'));
              reject(console.log());
            }, 3200);
          });
        })
        .catch(() => {
          // エラーハンドリング
          console.error('Something wrong!');
        });
      return promise;
    },
    clickScroll(e) {
      const targetArea = e.currentTarget.getBoundingClientRect().top;
      window.scrollTo({
        top: window.pageYOffset + targetArea,
        behavior: 'smooth',
      });
    },
    clickScrollNext() {
      let promise = new Promise((resolve, reject) => {
        resolve((this.show = !this.show));
        reject();
      });
      promise
        .then(() => {
          return new Promise((resolve, reject) => {
            setTimeout(() => {
              resolve(window.scrollBy(0, 500));
              reject();
            }, 10);
          });
        })
        .catch(() => {
          // エラーハンドリング
          console.error('Something wrong!');
        });
      return promise;
    },
  },
};
</script>
<style scoped>
body {
  background-color: white;
}
.Page-Btn {
  position: fixed;
  right: 14px;
  bottom: 14px;
  width: 32px;
  height: 32px;
  line-height: 32px;
  text-align: center;
  border-radius: 50%;
}
.Page-Btn-Icon {
  color: #fff;
  font-size: 16px;
}

.modal-enter {
  opacity: 0;
}

.modal-leave-active {
  opacity: 0;
}

.modal-enter .modal-container,
.modal-leave-active .modal-container {
  -webkit-transform: scale(1.1);
  transform: scale(1.1);
}
.modal-mask {
  position: fixed;
  z-index: 9998;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5);
  display: table;
  transition: opacity 0.3s ease;
}

.modal-wrapper {
  display: table-cell;
  vertical-align: middle;
}
.modal-container {
  width: 300px;
  margin: 0px auto;
  padding: 20px 30px;
  background-color: #fff;
  border-radius: 2px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.33);
  transition: all 0.3s ease;
  font-family: Helvetica, Arial, sans-serif;
}
.outer-layer {
  padding: 0.5em 3em;
  margin: 2em 0;
  font-weight: bold;
  border: solid 3px rgb(243, 190, 92);
}
.modal-body {
  margin: 20px 0;
}

.modal-default-button {
  float: right;
}
#izakaya {
  background: url(../src/img/beer.jpeg)  /  no-repeat;
}
.rounded {
  border-radius: 50px;
}
.analyze-title {
  background-color: rgb(0, 0, 0, 0.4);
}
.analyze-title-weight {
  background-color: rgb(255, 254, 254, 0.7);
}

.v-label {
  font-size: 30px;
}
</style>
