<template>
  <div>
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
        <v-card class="mx-auto my-5 form" outlined tile height="150" id="form">
          <v-card-title
            class="headline"
            style="margin: 0% 40%; width: 50%"
            :id="'bigq' + question.num"
          >
            Q{{ question.num }}.
            {{ question.title }}
          </v-card-title>

          <v-col cols="12" xs="12" sm="12" md="12" lg="12">
            <v-layout justify-center>
              <v-card-title>
                <v-container>
                  <p class="text-center mx-auto py-3" style="font-size: 26px">
                    あなたの回答： {{ question.answer }}
                  </p>
                  <v-radio-group :id="'smallq' + question.num" mandatory row>
                    <v-radio
                      class="mx-1"
                      fab
                      light
                      :ripple="{ center: false, class: 'gray--text' }"
                      @click="countAnswer(question.num, 1)"
                      v-on:click="clickScroll"
                      label="1: いつもある"
                    ></v-radio>
                    <v-radio
                      class="mx-1"
                      fab
                      light
                      :ripple="{ center: false, class: 'gray--text' }"
                      @click="countAnswer(question.num, 2)"
                      v-on:click="clickScroll"
                      label="2: 時々ある"
                    ></v-radio>
                    <v-radio
                      class="mx-1"
                      fab
                      light
                      :ripple="{ center: false, class: 'gray--text' }"
                      @click="countAnswer(question.num, 3)"
                      v-on:click="clickScroll"
                      label="3: 全くない"
                    ></v-radio>
                  </v-radio-group>
                </v-container>
              </v-card-title>
            </v-layout>
          </v-col>
        </v-card>
      </v-col>
      <v-col cols="4" xs="4" sm="2" md="2" lg="1">
        <v-btn
          style="font-size: 30px; margin-top: 50px"
          x-large
          :disabled="isVisible"
          :ripple="{ center: false, class: 'gray--text' }"
          @click="moveToNomivation()"
        >
          診断
        </v-btn>
      </v-col>
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
  </div>
</template>

<script>
import Router from '../router/index';
import { mapGetters, mapMutations, mapActions } from 'vuex';
export default {
  data() {
    return {
      isVisible: '',
      radios: null,
      total_points: [],
      sake_strongness: [],
    };
  },
  computed: {
    ...mapGetters('question', ['questions']),
    totalPoints() {
      return this.total_points;
    },
    createSchedule() {
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
      this.total_points = sumResult;
      let AlcoholStrongness = sumResult > 0 ? '酒豪' : sumResult === 0 ? '凡人' : '下戸';
      this.sake_strongness = AlcoholStrongness;
      return AlcoholStrongness;
    },
  },
  watch: {},
  mounted() {
    const notAnswers = this.questions.filter((question) => question.answer === '未回答');
    //与えられた関数によって実装されたテストに合格したすべての配列からなる新しい配列を生成する
    //answerの状態が変わっていないオブジェクトを取り出す。
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
    countAnswer(indexNum, answerState) {
      this.updateAnswer({ indexNum, answerState });
    },
    clickScroll(e) {
      const targetRect = e.currentTarget.getBoundingClientRect();
      window.scrollTo(0, window.pageYOffset + targetRect.top);
    },
    moveToNomivation() {
      this.$router.push({ name: 'SelectNomivation' });
    },
    diagnosisPush() {},
  },
};
</script>
