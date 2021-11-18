<template>
  <div>
    <v-stepper v-model="e6" vertical>
      <v-stepper-step :complete="e6 > 1" step="1">
        お酒の強さを診断
        <!-- <small>Summarize if needed</small> -->
      </v-stepper-step>

      <v-stepper-content step="1">
        <v-row justify="center" align-content="center">
          <v-col
            v-for="question in questions"
            :key="question.num"
            cols="12"
            xs="12"
            sm="12"
            md="12"
            lg="12"
          >
            <v-col cols="12" xs="12" sm="12" md="12" lg="12">
              <v-layout justify-center>
                <v-card-title>
                  <v-container>
                    <v-card
                      class="text-center mx-auto my-5 form"
                      elevation="2"
                      shaped
                      width="500"
                      id="form"
                    >
                      <v-card-title
                        style="width: 100%"
                        class="headline justify-center"
                        :id="'bigq' + question.num"
                      >
                        Q{{ question.num }}.
                        {{ question.title }}
                      </v-card-title>

                      <v-radio-group :id="'smallq' + question.num" mandatory row>
                        <v-radio
                          class="mx-auto justify-center"
                          fab
                          light
                          :ripple="{ center: false, class: 'gray--text' }"
                          @click="
                            clickScroll($event);
                            countAnswer(question.num, 1);
                          "
                          label="1: いつもある"
                        ></v-radio>
                        <v-radio
                          class="mx-auto justify-center"
                          fab
                          light
                          :ripple="{ center: false, class: 'gray--text' }"
                          @click="
                            clickScroll($event);
                            countAnswer(question.num, 2);
                          "
                          label="2: 時々ある"
                        ></v-radio>
                        <v-radio
                          class="mx-auto justify-center"
                          fab
                          light
                          :ripple="{ center: false, class: 'gray--text' }"
                          @click="
                            clickScroll($event);
                            countAnswer(question.num, 3);
                          "
                          label="3: 全くない"
                        ></v-radio>
                      </v-radio-group>
                      <p class="py-3" style="font-size: 16px">
                        あなたの回答： {{ question.answer }}
                      </p>
                    </v-card>
                  </v-container>
                </v-card-title>
              </v-layout>
            </v-col>
          </v-col>

          <v-col cols="4" xs="4" sm="2" md="2" lg="1">
            <!-- <v-btn
          style="font-size: 30px"
          x-large
          :disabled="isVisible"
          :ripple="{ center: false, class: 'gray--text' }"
          @click="clickScrollNext()"
        >
          次へ
        </v-btn> -->
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
            <span></span>未回答の項目があります。
          </p>
        </v-row>

        <v-btn
          color="primary"
          x-large
          style="font-size: 30px"
          :disabled="isVisible"
          @click="
            clickScrollNext();
            e6 = 2;
          "
        >
          次へ
        </v-btn>
      </v-stepper-content>

      <v-stepper-step :complete="e6 > 2" step="2"> 飲みベーション選択画面 </v-stepper-step>

      <v-stepper-content step="2">
        <template v-if="show">
          <v-container justify="center" align-content="center">
            <v-layout justify-center>
              <v-row justify-center>
                <v-col cols="12" xs="12" sm="12" md="12" lg="12">
                  <table>
                    <tbody>
                      <tr>
                        <th>Step 2</th>
                      </tr>
                      <tr>
                        飲みベーション選択画面
                      </tr>
                    </tbody>
                  </table>
                  <h1 class="text-center" style="font-size: 50px">なりたい状態をクリック！</h1>

                  <v-dialog v-model="dialog" width="500">
                    <template #activator="{ on, attrs }">
                      <div d-flex justify="center">
                        <v-layout justify-space-between align-content="center">
                          <v-card
                            @click="setShuchedule2()"
                            style="font-size: 30px; margin-left: 20px"
                            justify="center"
                            align-content="center"
                            x-large
                            :ripple="{ center: false, class: 'gray--text' }"
                            v-bind="attrs"
                            v-on="on"
                          >
                            <v-card-title
                              style="font-size: 32px; text-decoration: none; text-color: black"
                              >酩酊</v-card-title
                            >
                            <img :src="imgSrc" width="150" height="100" />
                          </v-card>
                          <v-card
                            @click="setShuchedule1()"
                            style="font-size: 30px"
                            x-large
                            :ripple="{ center: false, class: 'gray--text' }"
                            justify="center"
                            align-content="center"
                            v-bind="attrs"
                            v-on="on"
                          >
                            <v-card-title
                              style="font-size: 32px; text-decoration: none; text-color: black"
                              >ほろ酔い</v-card-title
                            >
                            <img :src="sakeSrc" width="150" height="100" />
                          </v-card>

                          <v-card
                            @click="setShuchedule0()"
                            style="font-size: 30px"
                            x-large
                            :ripple="{ center: false, class: 'gray--text' }"
                            justify="center"
                            align-content="center"
                            v-bind="attrs"
                            v-on="on"
                          >
                            <v-card-title
                              style="font-size: 32px; text-decoration: none; text-color: black"
                              >しっぽり</v-card-title
                            >
                            <img :src="drinkSrc" width="150" height="100" />
                          </v-card>
                        </v-layout>
                      </div>

                      <transition name="modal">
                        <div v-if="showModal" @close="showModal = false">
                          <div class="modal-mask">
                            <div class="modal-wrapper">
                              <div class="modal-container">
                                <div class="modal-body" align-content="center">
                                  <slot name="body">
                                    <FacebookLoader />

                                    <p style="font-size: 32px">
                                      酒ケジュール作成中
                                      <v-progress-linear
                                        indeterminate
                                        color="white"
                                        class="mb-0"
                                      ></v-progress-linear>
                                    </p>
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

        <!-- <v-btn
        color="primary"
        @click="e6 = 3"
      >
        Continue
      </v-btn>
      <v-btn text>
        Cancel
      </v-btn> -->
      </v-stepper-content>
    </v-stepper>
  </div>
</template>
<script>
import FacebookLoader from '@bit/joshk.vue-spinners-css.facebook-loader';
import axios from '../plugins/axios';
import { mapGetters, mapMutations, mapActions } from 'vuex';
export default {
  data() {
    return {
      isVisible: '',
      radios: null,
      sakeStrongness: [],
      dialog: false,
      show: false,
      showModal: false,
      users: [],
      alcohols: [],
      e6: 1,
    };
  },
  components: {
    FacebookLoader,
  },
  computed: {
    ...mapGetters('question', ['questions']),
    ...mapGetters('analyze', ['analyzes']),
    ...mapGetters('users', ['authUser']),
    imgSrc() {
      return require('../src/img/drunkman.svg');
    },
    sakeSrc() {
      return require('../src/img/sake.svg');
    },
    drinkSrc() {
      return require('../src/img/liquor.svg');
    },
    currentUserName() {
      return this.users[0];
    },
    Sakenotuyosa() {
      const yourSakeStrongness = this.analyzes.total_points;
      if (yourSakeStrongness < 0) {
        return '下戸';
      } else if (yourSakeStrongness === 0) {
        return '普通';
      } else {
        return '酒豪';
      }
    },
  },
  created() {
    this.users = this.fetchAuthUser;
    this.fetchAuthUser();
  },
  mounted() {
    axios.get('/users').then((userResponse) => (this.users = userResponse.data));
    axios.get('/alcohols').then((userResponse) => (this.alcohols = userResponse.data));
    const notAnswers = this.questions.filter((question) => question.answer === '未回答');
    //与えられた関数によって実装されたテストに合格したすべての配列からなる新しい配列を生成する
    //未回答以外の値数を算出
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
    //同期処理を記述する
    ...mapMutations('question', ['updateAnswer']),
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
    async setShuchedule0() {
      var trueAnswers = this.questions;
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
      let AlcoholStrongness = sumResult > 0 ? 2 : sumResult === 0 ? 1 : 0; //2: 酒豪, 1: 普通. 0: 下戸
      let Nomivation = 0;
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
          ? '酔った時の対処法を心得ているタイプの下戸'
          : sumResult < -2
          ? '強くも弱くもないため、お酒飲める人？と聞かれた時の返答に困っているタイプの下戸'
          : sumResult < -1
          ? '人並みには飲めるよと周りに言うタイプの下戸'
          : sumResult < 0
          ? '度数の高いお酒を飲んだらバタンキューするタイプの人'
          : sumResult < 1
          ? 'まあ飲めるけどそこまでお酒が好きじゃない酒豪'
          : sumResult < 2
          ? '周囲の酒の空き具合を見て次何飲む？と聞けるタイプの酒豪'
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
          ? '酒呑として界隈では有名な酒豪'
          : sumResult < 15
          ? '日本酒や焼酎が飲めるためよくおじさんに呑みの誘いを受けるタイプの酒豪'
          : '外人の血が入っている大酒豪。酒呑人';

      let promise = new Promise((resolve, reject) => {
        // #1
        const updAnalyze = {
          total_points: sumResult,
          sake_strongness_types: AlcoholStrongness,
          next_nomivation_types: Nomivation,
          description: Description,
        };

        resolve(this.createAnalyze(updAnalyze));
        reject();
      });
      promise
        .then(() => {
          // #2
          return new Promise((resolve, reject) => {
            setTimeout(() => {
              resolve((this.showModal = true));
              reject();
            }, 1000);
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
    async setShuchedule1() {
      var trueAnswers = this.questions;
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
      let AlcoholStrongness = sumResult > 0 ? 2 : sumResult === 0 ? 1 : 0; //2: 酒豪, 1: 普通. 0: 下戸
      let Nomivation = 1;
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
          ? '酔った時の対処法を心得ているタイプの下戸'
          : sumResult < -2
          ? '強くも弱くもないため、お酒飲める人？と聞かれた時の返答に困っているタイプの下戸'
          : sumResult < -1
          ? '人並みには飲めるよと周りに言うタイプの下戸'
          : sumResult < 0
          ? '度数の高いお酒を飲んだらバタンキューするタイプの人'
          : sumResult < 1
          ? 'まあ飲めるけどそこまでお酒が好きじゃない酒豪'
          : sumResult < 2
          ? '周囲の酒の空き具合を見て次何飲む？と聞けるタイプの酒豪'
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
          ? '酒呑として界隈では有名な酒豪'
          : sumResult < 15
          ? '日本酒や焼酎が飲めるためよくおじさんに呑みの誘いを受けるタイプの酒豪'
          : '外人の血が入っている大酒豪。酒呑人';

      let promise = new Promise((resolve, reject) => {
        // #1
        const updAnalyze = {
          total_points: sumResult,
          sake_strongness_types: AlcoholStrongness,
          next_nomivation_types: Nomivation,
          description: Description,
        };

        resolve(this.createAnalyze(updAnalyze));
        reject();
      });
      promise
        .then(() => {
          // #2
          return new Promise((resolve, reject) => {
            setTimeout(() => {
              resolve((this.showModal = true));
              reject();
            }, 1000);
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
    async setShuchedule2() {
      var trueAnswers = this.questions;
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
      let AlcoholStrongness = sumResult > 0 ? 2 : sumResult === 0 ? 1 : 0; //2: 酒豪, 1: 普通. 0: 下戸
      let Nomivation = 2;
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
          ? '酔った時の対処法を心得ているタイプの下戸'
          : sumResult < -2
          ? '強くも弱くもないため、お酒飲める人？と聞かれた時の返答に困っているタイプの下戸'
          : sumResult < -1
          ? '人並みには飲めるよと周りに言うタイプの下戸'
          : sumResult < 0
          ? '度数の高いお酒を飲んだらバタンキューするタイプの人'
          : sumResult < 1
          ? 'まあ飲めるけどそこまでお酒が好きじゃない酒豪'
          : sumResult < 2
          ? '周囲の酒の空き具合を見て次何飲む？と聞けるタイプの酒豪'
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
          ? '酒呑として界隈では有名な酒豪'
          : sumResult < 15
          ? '日本酒や焼酎が飲めるためよくおじさんに呑みの誘いを受けるタイプの酒豪'
          : '外人の血が入っている大酒豪。酒呑人';

      let promise = new Promise((resolve, reject) => {
        // #1
        const updAnalyze = {
          total_points: sumResult,
          sake_strongness_types: AlcoholStrongness,
          next_nomivation_types: Nomivation,
          description: Description,
        };

        resolve(this.createAnalyze(updAnalyze));
        reject();
      });
      promise
        .then(() => {
          // #2
          return new Promise((resolve, reject) => {
            setTimeout(() => {
              resolve((this.showModal = true));
              reject();
            }, 1000);
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
      const targetArea = e.currentTarget.getBoundingClientRect();
      window.scrollTo(0, window.pageYOffset + targetArea.top);
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
<style>
.Page-Btn {
  position: fixed;
  right: 14px;
  bottom: 14px;
  width: 32px;
  height: 32px;
  line-height: 32px;
  text-align: center;
  border-radius: 50%;
  background: #5bc8ac;
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

.modal-header h3 {
  margin-top: 0;
  color: #42b983;
}
.modal-body {
  margin: 20px 0;
}

.modal-default-button {
  float: right;
}
</style>
