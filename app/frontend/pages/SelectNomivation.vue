<template>
  <v-container fluid id="izakaya">
    <v-container
      justify="center"
      align-content="center"
      style="background-color: rgb(0, 0, 0, 0.4)"
    >
      <v-layout justify-center>
        <v-row justify-center>
          <v-col cols="12" xs="12" sm="12" md="12" lg="12">
            <h1 class="text-center white--text" style="font-size: 25px">
              一次会でどのくらい酔いたいかクリックしてください
            </h1>

            <v-dialog v-model="dialog" width="500">
              <template #activator="{ on, attrs }">
                <div>
                  <v-layout>
                    <v-row justify="center" align-content="center">
                      <v-col
                        cols="12"
                        sm="3"
                        @click="setShuchedule2()"
                        style="font-size: 30px"
                        class="text-center"
                        :ripple="{ center: false, class: 'gray--text' }"
                        v-bind="attrs"
                        v-on="on"
                      >
                        <img :src="imgSrc" width="150" height="150" class="text-center" />
                      </v-col>

                      <v-col
                        cols="12"
                        sm="3"
                        @click="setShuchedule1()"
                        style="font-size: 30px"
                        class="text-center"
                        :ripple="{ center: false, class: 'gray--text' }"
                        v-bind="attrs"
                        v-on="on"
                      >
                        <img :src="sakeSrc" width="150" height="150" class="text-center" />
                      </v-col>

                      <v-col
                        cols="12"
                        sm="3"
                        @click="setShuchedule0()"
                        style="font-size: 30px"
                        class="text-center"
                        :ripple="{ center: false, class: 'gray--text' }"
                        v-bind="attrs"
                        v-on="on"
                      >
                        <img :src="drinkSrc" width="150" height="150" class="text-center" />
                      </v-col>
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
                              <p style="font-size: 25px" class="text-center">酒ケジュール作成中</p>
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
  </v-container>
</template>

<script>
import FacebookLoader from '@bit/joshk.vue-spinners-css.facebook-loader';
import { mapGetters, mapMutations, mapActions } from 'vuex';
export default {
  name: 'SelectNomivation',
  data() {
    return {
      users: [],
      alcohols: [],
      isVisible: '',
      dialog: false,
      show: false,
      showModal: false,
    };
  },
  components: {
    FacebookLoader,
  },
  computed: {
    ...mapActions('analyze', ['fetchAnalyzes']),

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
    this.fetchAnalyzes;
    this.users = this.fetchAuthUser;
    // this.questions = this.fetchQuestions
    this.fetchAuthUser();
  },

  methods: {
    ...mapMutations('analyze', ['addAnalyze']),
    ...mapActions('analyze', ['createAnalyze']),
    ...mapActions('users', ['fetchAuthUser']),
    async setShuchedule0() {
      const targetAnalyze = this.analyzes;
      const sumResult = targetAnalyze[targetAnalyze.length - 1]['shuchedule'];
      const userAlcoholStrongness = targetAnalyze[targetAnalyze.length - 1]['alcohol_strongness'];
      let Nomivation = 0; //flesh: 0, tipsy: 1, heavy_drunk: 2
      const AlcoholStrongness =
        userAlcoholStrongness === 'strong'
          ? 4
          : userAlcoholStrongness === 'normal_strong'
          ? 3
          : userAlcoholStrongness === 'normal'
          ? 2
          : userAlcoholStrongness === 'weak_normal'
          ? 1
          : 0;
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
          total_points: 0,
          alcohol_strongness: AlcoholStrongness,
          next_motivation: Nomivation, //flesh: 0, tipsy: 1, heavy_drunk: 2
          shuchedule: sumResult,
          description: Description,
        };

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
    async setShuchedule1() {
      const targetAnalyze = this.analyzes;
      const sumResult = targetAnalyze[targetAnalyze.length - 1]['shuchedule'];
      const userAlcoholStrongness = targetAnalyze[targetAnalyze.length - 1]['alcohol_strongness'];
      let Nomivation = 1; //flesh: 0, tipsy: 1, heavy_drunk: 2
      const AlcoholStrongness =
        userAlcoholStrongness === 'strong'
          ? 4
          : userAlcoholStrongness === 'normal_strong'
          ? 3
          : userAlcoholStrongness === 'normal'
          ? 2
          : userAlcoholStrongness === 'weak_normal'
          ? 1
          : 0;
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
          total_points: 0,
          alcohol_strongness: AlcoholStrongness,
          next_motivation: Nomivation, //flesh: 0, tipsy: 1, heavy_drunk: 2
          shuchedule: sumResult,
          description: Description,
        };

        resolve(this.createAnalyze(updateAnalyze));
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
    async setShuchedule2() {
      const targetAnalyze = this.analyzes;
      const sumResult = targetAnalyze[targetAnalyze.length - 1]['shuchedule'];
      const userAlcoholStrongness = targetAnalyze[targetAnalyze.length - 1]['alcohol_strongness'];
      let Nomivation = 2; //flesh: 0, tipsy: 1, heavy_drunk: 2
      const AlcoholStrongness =
        userAlcoholStrongness === 'strong'
          ? 4
          : userAlcoholStrongness === 'normal_strong'
          ? 3
          : userAlcoholStrongness === 'normal'
          ? 2
          : userAlcoholStrongness === 'weak_normal'
          ? 1
          : 0;
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
          total_points: 0,
          alcohol_strongness: AlcoholStrongness,
          next_motivation: Nomivation, //flesh: 0, tipsy: 1, heavy_drunk: 2
          shuchedule: sumResult,
          description: Description,
        };

        resolve(this.createAnalyze(updateAnalyze));
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
  },
};
</script>
<style scoped>
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
#izakaya {
  background: url(../src/img/beer.jpeg) center center / cover no-repeat fixed;
}
.rounded {
  border-radius: 50px;
}
</style>
