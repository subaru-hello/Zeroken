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
        <v-card class="mx-auto my-5"  outlined tile height="150">
          <v-card-title class="headline" style="margin: 0% 40%; width: 50%">
            Q{{ question.num }}.
            {{ question.title }}
          </v-card-title>

          <v-col cols="12" xs="12" sm="12" md="12" lg="12">
            <v-layout justify-center>
              <v-card-title :id="'q-' + question.num">
                <v-container>
                       <p class="text-center mx-auto py-3" style="font-size: 26px">
                    あなたの回答： {{ question.answer }}
                  </p>
                  <v-radio-group :id="'q-' + question.num" mandatory row>
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
          style="font-size: 30px; margin-top: 50px;"
          x-large
          :disabled="isVisible"
          :ripple="{ center: false, class: 'gray--text' }"
          @click="createSchedule()"
        >
          診断
        </v-btn>
      </v-col>
      <!-- <div v-if="createSchedule()"></div> -->
    </v-row>
    <p
      v-if="isVisible"
      class="text-center red--text text--lightn-3 my-5 mb-5"
      outlined
      tile
      height="150"
    >
      <span></span>が未回答です。
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
    };
  },
  computed: {
    ...mapGetters('question', ['questions']),
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
    createSchedule() {
      // 1いつも出る 2時々出る 3全くない
      //1: q1が１だったら-10.04を返し、2だったらを5.22を返し、3だったら8.95を返す。を13項目作成する。。。

      const targetArray = this.questions;
      const Answers = Object.values(targetArray);
      //出力['1','2','1','3']のようになる。

      const result1 = (Answers) => {
        //Answers[0]で1を取得することができる。
        if (Answers[0].answer == 1) {
          return -10.04;
        } else if (targetArray[0].answer == 2) {
          return 8.95;
        } else {
          return 5.22;
        }
      };
      //2:  q1が１だったら-0.43を返し、2だったらを-2.98を返し、3だったら1.2を返す。

      const result2 = (Answers) => {
        //Answers[0]で1を取得することができる。
        if (Answers[0].answer == 1) {
          return -0.43;
        } else if (targetArray[0].answer == 2) {
          return -2.98;
        } else {
          return 1.2;
        }
      };
      //3:  q1が１だったら3.37を返し、2だったらを-3.89を返し、3だったら0.38を返す。

      const result3 = (Answers) => {
        //Answers[0]で1を取得することができる。
        if (Answers[0].answer == 1) {
          return -3.37;
        } else if (targetArray[0].answer == 2) {
          return -3.89;
        } else {
          return 0.38;
        }
      };
      //4:  q1が１だったら-0.58を返し、2だったらを-1.27を返し、3だったら0.25を返す。

      const result4 = (Answers) => {
        //Answers[0]で1を取得することができる。
        if (Answers[0].answer == 1) {
          return -0.58;
        } else if (targetArray[0].answer == 2) {
          return -1.27;
        } else {
          return 0.25;
        }
      };
      //5:  q1が１だったら0.31を返し、2だったらを0.36を返し、3だったら-1.03を返す。

      const result5 = (Answers) => {
        //Answers[0]で1を取得することができる。
        if (Answers[0].answer == 1) {
          return 0.31;
        } else if (targetArray[0].answer == 2) {
          return 0.36;
        } else {
          return -1.03;
        }
      };
      //6:  q1が１だったら0を返し、2だったらを-4.11を返し、3だったら0.1を返す。

      const result6 = (Answers) => {
        //Answers[0]で1を取得することができる。
        if (Answers[0].answer == 1) {
          return 0;
        } else if (targetArray[0].answer == 2) {
          return -4.11;
        } else {
          return 0.1;
        }
      };
      //7:  q1が１だったら-0.79を返し、2だったらを0.07を返し、3だったら0.01を返す。

      const result7 = (Answers) => {
        //Answers[0]で1を取得することができる。
        if (Answers[0].answer == 1) {
          return -0.79;
        } else if (targetArray[0].answer == 2) {
          return 0.07;
        } else {
          return 0.01;
        }
      };
      //8:  q1が１だったら0.83を返し、2だったら0.62を返し、3だったら-0.24を返す。

      const result8 = (Answers) => {
        //Answers[0]で1を取得することができる。
        if (Answers[0].answer == 1) {
          return 0.83;
        } else if (targetArray[0].answer == 2) {
          return 0.62;
        } else {
          return -0.24;
        }
      };
      //9:  q1が１だったら-3.25を返し、2だったらを1.43を返し、3だったら-0.44を返す。

      const result9 = (Answers) => {
        //Answers[0]で1を取得することができる。
        if (Answers[0].answer == 1) {
          return -3.25;
        } else if (targetArray[0].answer == 2) {
          return 1.43;
        } else {
          return -0.44;
        }
      };
      //10: q1が１だったら-1.88を返し、2だったらを0.04を返し、3だったら0.26を返す。

      const result10 = (Answers) => {
        //Answers[0]で1を取得することができる。
        if (Answers[0].answer == 1) {
          return -1.88;
        } else if (targetArray[0].answer == 2) {
          return 0.04;
        } else {
          return 0.26;
        }
      };
      //11: q1が１だったら-10.07を返し、2だったらを0.19を返し、3だったら0.03を返す。

      const result11 = (Answers) => {
        //Answers[0]で1を取得することができる。
        if (Answers[0].answer == 1) {
          return -10.07;
        } else if (targetArray[0].answer == 2) {
          return 0.19;
        } else {
          return 0.03;
        }
      };
      //12: q1が１だったら8.15を返し、2だったらを-2.42を返し、3だったら0.14を返す。
      const result12 = (Answers) => {
        //Answers[0]で1を取得することができる。
        if (Answers[0].answer == 1) {
          return 8.15;
        } else if (targetArray[0].answer == 2) {
          return -2.42;
        } else {
          return 0.14;
        }
      };
      //13: q1が１だったら-4.34を返し、2だったらを2.69を返し、3だったら-0.19を返す。
      const result13 = (Answers) => {
        //Answers[0]で1を取得することができる。
        if (Answers[0].answer == 1) {
          return -4.34;
        } else if (targetArray[0].answer == 2) {
          return 2.69;
        } else {
          return -0.19;
        }
      };

      //    if (Answers[0] === 1){
      //         return params =0.1,
      //         this.$router.push({ name: 'PreliquoTop',
      //   params: {
      //     id: 'X000001',
      //     name: 'Mike and Tom'}
      //          } );
      //     }else{
      //          this.$router.push({ name: 'PreliquoTop',
      //   params: {
      //     id: 'X000001',
      //     name: 'Mike and Tom'}
      //          } );
      //     }
      // }
      const total_points =
        result1 +
        result2 +
        result3 +
        result4 +
        result5 +
        result6 +
        result7 +
        result8 +
        result9 +
        result10 +
        result11 +
        result12 +
        result13;

      const DrunkState = (total_points) => {
        if (total_points === 0) {
          return 0;
        } else if (total_points < 0) {
          return 1;
        } else {
          return 2;
        }
      };
      //酒ケジュールを作成する。
      //酔いたい度(血中アルコール濃度)
      //爽快期(0.02,0.03,0.04)
      //ほろ酔い期(0.05,0.07,0.10)
      //酩酊期(0.16,0.23,0.30)

      //下戸（キャラクターをつけても面白いかも)
      //爽快期0.02
      //ほろ酔い期0.05
      //酩酊期0.16

      //凡人
      //爽快期0.03
      //ほろ酔い期0.07
      //酩酊期0.23

      //酒豪（キャラクターをつけても面白いかも）
      //爽快期0.04
      //ほろ酔い期0.10
      //酩酊期0.30

      // S 血中アルコール濃度 mg/ml＝
      //人それぞれある。度数が高いものを飲まないと酔わないという人もいる。（逆に、低いものなら何杯でもいけるという人もいる。)
      //Ａ（アルコール量ｇ20）／B 体重ｋｇ×2/3✖/1000（0.70アルコール体内分布係数）
    // = 15.6/体重(x)　＝血中濃度（y)
    //例えば70kgの場合、血中濃度は0.22になり、下戸だと酩酊になる。
      //S　血中アルコール濃度を求める
      //A アルコール量を求める
      //a: 酒の量(mL) × b: 度数または% / 100 × 比重 = 純アルコール量(g)
      //500(mL) × 0.05 × 0.8 = 20(g)
      //Alcoholモデル(polimorphism)(ハイボール、焼酎ロック、ビール、日本酒、ウィスキー、ワイン、缶チューハイ)
     
     
     //title:string ビール
      //percentages:integer　0.05
      //amounts:integer 350
      //pure_alcohol_intake 14
      //description 最初はやっぱりビールでしょ
    

      //title:string 缶チューハイ(スト缶一本)
      //percentages:integer　0.08
      //amounts:integer 500
      //pure_alcohol_intake 32
      //description 8%じゃないと酒じゃないっしょ

      //title:string ワイン(グラス一杯)
      //percentages:integer　0.15
      //amounts:integer 120
      //pure_alcohol_intake 12
      //description 芳醇な葡萄な香り

      //title:string 日本酒(1合)
      //percentages:integer　0.15
      //amounts:integer 180
      //pure_alcohol_intake 22
      //description 日本人が作った酒

      //title:string 焼酎（コップ一杯)
      //percentages:integer　0.25
      //amounts:integer 100
      //pure_alcohol_intake 20
      //description 強い漢にこれいっぱい

      //title:string ウィスキー(シングル)
      //percentages:integer　0.40
      //amounts:integer 30
      //pure_alcohol_intake 10
      //description 最初はやっぱりビールでしょ

      //お酒の1単位（純アルコールにして 20ｇ）
      //ビール5％500ml 日本酒15%1合180ml 焼酎25%0.6合110ml ウィスキー43%ダブル１杯60ml 缶チューハイ5%500ml

      //B 体重
      const alcohol_ratio = 0.8;

      const AlcoholInBody = alcohol.amounts * alocohol.percentages * alcohol_ratio;
      // const Shuchedule = =>{

      // }
    },
  },
};
</script>
