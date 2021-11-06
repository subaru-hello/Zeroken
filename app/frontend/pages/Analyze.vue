<template>
  <div>
    <p>Step.1 酒の強さ診断画面</p>
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
                  <p class="py-3" style="font-size: 16px">あなたの回答： {{ question.answer }}</p>
                </v-card>
              </v-container>
            </v-card-title>
          </v-layout>
        </v-col>
      </v-col>
      <p>{{ createSchedule }}</p>

      <v-col cols="4" xs="4" sm="2" md="2" lg="1">
        <v-btn
          style="font-size: 30px"
          x-large
          :disabled="isVisible"
          :ripple="{ center: false, class: 'gray--text' }"
          @click="clickScrollNext()"
        >
          次へ
        </v-btn>
      </v-col>
      <p class="Page-Btn">
        <v-btn fab dark small color="primary" @click="scrollTop()">
          <v-icon>mdi-arrow-up-thick</v-icon>
        </v-btn>
      </p>
    </v-row>

    <p
      v-if="isVisible"
      class="text-center red--text text--lightn-3 my-5 mb-5"
      outlined
      tile
      height="150"
    >
      <span></span>未回答の項目があります。
    </p>
    <template v-if="show">
      <v-container justify="center" align-content="center">
        <v-row>
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
            <h1 class="text-center" style="font-size: 50px">飲み会へのモチベーションを選択</h1>
          </v-col>
          <v-dialog v-model="dialog" width="500" justify="center" align-content="center">
            <template #activator="{ on, attrs }">
              <v-col
                @click="setShuchedule()"
                style="font-size: 30px; margin-left: 20px"
                x-large
                :ripple="{ center: false, class: 'gray--text' }"
                v-bind="attrs"
                v-on="on"
              >
                <p style="font-size: 32px; text-decoration: none; text-color: black">酩酊</p>
                <img :src="imgSrc" width="150" height="100" />
              </v-col>
              <v-col
                @click="setShuchedule()"
                style="font-size: 30px"
                x-large
                :ripple="{ center: false, class: 'gray--text' }"
                v-bind="attrs"
                v-on="on"
              >
                <p style="font-size: 32px; text-decoration: none; text-color: black">ほろ酔い</p>
                <img :src="sakeSrc" width="150" height="100" />
              </v-col>

              <v-col
                @click="setShuchedule()"
                style="font-size: 30px"
                x-large
                :ripple="{ center: false, class: 'gray--text' }"
                v-bind="attrs"
                v-on="on"
              >
                <p style="font-size: 32px; text-decoration: none; text-color: black">しっぽり</p>
                <img :src="drinkSrc" width="150" height="100" />
              </v-col>
              <transition name="modal">
                <div v-if="showModal" @close="showModal = false">
                  <div class="modal-mask">
                    <div class="modal-wrapper">
                      <div class="modal-container">
                        <div class="modal-body" align-content="center">
                          <slot name="body">
                            <FacebookLoader />

                            <p style="font-size: 32px">酒ケジュール作成中...</p>
                          </slot>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </transition>
            </template>
          </v-dialog>
        </v-row>
      </v-container>
    </template>
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
      return require('../src/img/liquor.svg');
    },
    sakeSrc() {
      return require('../src/img/sake.svg');
    },
    drinkSrc() {
      return require('../src/img/drink.svg');
    },

    createSchedule() {
      var currentAnalyzes = this.analyzes;
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
      let AlcoholStrongness = sumResult > 0 ? 2 : sumResult === 0 ? 1 : 0;
      currentAnalyzes.total_points = sumResult;
      currentAnalyzes.sake_strongness_types = AlcoholStrongness;

      return currentAnalyzes.sake_strongness_types;
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
    this.fetchAuthUser();
  },
  watch: {},
  mounted() {
    axios.get('/users').then((userResponse) => (this.users = userResponse.data));
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
    async setShuchedule() {
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

      let promise = new Promise((resolve, reject) => {
        // #1
        const updAnalyze = {
          total_points: sumResult,
          sake_strongness_types: AlcoholStrongness,
          next_nomivation_types: Nomivation,
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
