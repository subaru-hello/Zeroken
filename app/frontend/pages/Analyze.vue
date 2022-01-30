<template>
  <!-- <div> -->
  <v-stepper v-model="e6" vertical id="izakaya">
    <v-stepper-step :complete="e6 > 1" step="1">
      <!-- <span class="white--text " 
          >お酒の強さを診断
        </span> -->
    </v-stepper-step>
    <v-spacer />
    <v-stepper-content id="izakaya" step="1">
      <v-row justify="center" align-content="center">
        <h2 class="ma-5 white--text rounded bold" style="background: rgba(0, 0, 0, 0.4)">
          お酒を飲んでいる時の状態を選択してください(13項目)
        </h2>
        <v-col v-for="question in questions" :key="question.num" cols="12">
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
                    >
                      1: いつも
                    </v-btn>
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
      <v-col cols="12" class="text-center">
        <ZerokenButton
          button-name="次へ"
          class="mb-8 text-center"
          style="background-color: rgb(222, 184, 135)"
          x-large
          :isVisible="isVisible"
          @click-response="clickScrollNext()"
        >
        </ZerokenButton>
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
              <v-col cols="12">
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
      <v-col cols="12" class="text-center">
        <ZerokenButton
          button-name="次へ"
          v-if="weight != '体重を選択'"
          @click-response="e6 = 3"
          :isVisible="isVisible"
        ></ZerokenButton>
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
              <v-col cols="12">
                <h1 class="text-center black--text" style="font-size: 25px">
                  一軒目でどのくらい酔いたいか選択してください
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
                                style="font-size: 40px"
                                label="酩酊(かなり)"
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
                                label="ほろ酔い(まあまあ)"
                              ></v-radio>
                              <!-- <img :src="sakeSrc" width="150" height="150" class="text-center" /> -->

                              <v-radio
                                :value="0"
                                style="font-size: 20px"
                                label="しっぽり(ほんの少し)"
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
                              button-name="酒ケジュールを作成する"
                              v-if="nextMotivation != 4"
                              class="text-center"
                              :ripple="{ center: false, class: 'gray--text' }"
                              v-bind="attrs"
                              v-on="on"
                              @click-response="createShuchedule()"
                            >
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
import axios from '../plugins/axios';
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
      nextMotivation: 4,
      user_id: '',
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
    ...mapGetters('analyze_result', ['analyze_results']),
    ...mapGetters('users', ['authUser']),

    highballSrc() {
      return require('../src/img/high_ball_kanpai.jpg');
    },
    imgSrc() {
      return require('../src/img/heavy_drunk_stamp.png');
    },
    sakeSrc() {
      return require('../src/img/tipsy_stamp.png');
    },
    drinkSrc() {
      return require('../src/img/flesh_stamp.png');
    },
  },
  created() {
    axios.get('users/me').then((userResponse) => (this.user_id = userResponse.data.id));
    this.fetchAuthUser();
    // this.userAuth();
    this.clearAnswers();
  },
  mounted() {
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
    ...mapMutations('analyze_result', ['addAnalyze']),
    ...mapActions('tast_answer', ['createTastAnswer']),
    ...mapActions('analyze_result', ['createAnalyze']),
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
      const questionResponce = await this.questions;
      const yourWeight = this.weight;
      const yourNomivation = this.nextMotivation;
      const selected_choices = [];
      questionResponce.forEach(function (element) {
        selected_choices.push(element['answer']);
      });
      function all() {
        let updateTast = {};
        for (let i = 0; i < selected_choices.length; i++) {
          //keyはindexを指し、caseは場所を指している。
          //最終的には、answer_1: array_1[1]のようになる
          let json_key = `selected_choices_${i}`;
          updateTast[json_key] = selected_choices[i];
        }
        // debugger;
        return updateTast;
      }
      const tastResult = all();
      let promise = new Promise((resolve, reject) => {
        const tastResult = all();
        resolve(this.createTastAnswer(tastResult));

        reject();
      });
      promise
        .then(() => {
          return new Promise((resolve, reject) => {
            setTimeout(() => {
              resolve((this.showModal = true));
              reject();
            }, 1);
          });
        })
        .then(() => {
          return new Promise((resolve, reject) => {
            setTimeout(() => {
              const updateAnalyzeResult = {
                weight: yourWeight,
                next_motivation: yourNomivation,
                user_id: this.user_id,
              };
              resolve(this.createAnalyze(updateAnalyzeResult));
              reject();
            }, 1);
          });
        })

        .then(() => {
          // #3
          return new Promise((resolve, reject) => {
            setTimeout(() => {
              resolve(this.$router.push('/result'));
              reject(console.log());
            }, 1);
          });
        })
        .catch((e) => {
          // エラーハンドリング
          console.error(e);
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
      this.show = true;
      this.e6 = 2;
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
  background: url(../src/img/woodtile.jpeg) / no-repeat;
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
