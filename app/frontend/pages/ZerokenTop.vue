<template>
  <div id="izakaya">
    <v-container fill-height fluid style="width: 100%">
      <FirstGreeting
        :dialog="isVisibleFirstGreeting"
        @close-dialog="isVisibleFirstGreeting = false"
      />

      <v-row justify="center" align-content="center">
        <v-col
          class="text-center align-self-center"
          style="background-color: rgb(0, 0, 0, 0.4)"
          cols="12"
        >
          <transition name="fade">
            <div class="text-h2 bold title" v-if="show">ZEROKEN</div>
          </transition>
          <p
            class="text-h5 mb-12 font-weight-bold d-sm-block text-no-wrap service-description title"
          >
            {{ title }}<br />{{ text }}
          </p>
          <v-col>
            <img :src="imgSrc" class="img" width="150" height="100" />
            <v-spacer />

            <div v-if="!authUser">
              <v-btn
                class="mb-8"
                style="background-color: rgb(222, 184, 135)"
                x-large
                @click="loginFunction()"
              >
                さっそく酒ケジュールを作る
              </v-btn>
            </div>
            <div v-else>
              <v-btn @click="toAnalyze()" style="background-color: rgb(222, 184, 135)" x-large
                >さっそく酒ケジュールを作る</v-btn
              >
            </div>
          </v-col>
        </v-col>
        <v-spacer />
        <v-container align-content="center" justyfy="center" class="ma-4">
          <v-row>
            <v-col>
              <div>
                <v-card class="mx-auto" max-width="344">
                  <div align-content="center">
                    <v-img :src="beersSrc" width="344" height="100" />
                  </div>
                  <v-card-title> 飲み会の前に </v-card-title>

                  <v-card-subtitle> ついつい飲み過ぎちゃう時ってありますよね </v-card-subtitle>

                  <v-card-actions>
                    <v-btn color="orange lighten-2" text> 解決方法</v-btn>

                    <v-spacer></v-spacer>

                    <v-btn icon @click="emerge = !emerge">
                      <v-icon>{{ emerge ? 'mdi-chevron-up' : 'mdi-chevron-down' }}</v-icon>
                    </v-btn>
                  </v-card-actions>

                  <v-expand-transition>
                    <div v-show="emerge">
                      <v-divider></v-divider>

                      <v-card-text>
                        そんな時はZEROKENで事前に自分のお酒の強さをチェック。年を忘れる前にサクッとZEROKEN
                      </v-card-text>
                    </div>
                  </v-expand-transition>
                </v-card>
              </div>
            </v-col>
            <v-col>
              <v-card class="mx-auto" max-width="344">
                <div align-content="center">
                  <v-img :src="beersSrc" width="344" height="100" />
                </div>

                <v-card-title> デートの前に </v-card-title>

                <v-card-subtitle>緊張するとすぐ飲みすぎちゃう</v-card-subtitle>

                <v-card-actions>
                  <v-btn color="orange lighten-2" text> 解決方法</v-btn>

                  <v-spacer></v-spacer>

                  <v-btn icon @click="emerge = !emerge">
                    <v-icon>{{ emerge ? 'mdi-chevron-up' : 'mdi-chevron-down' }}</v-icon>
                  </v-btn>
                </v-card-actions>

                <v-expand-transition>
                  <div v-show="emerge">
                    <v-divider></v-divider>

                    <v-card-text>
                      そんな時はZEROKENを使って事前に自分のお酒の強さをチェック。デートの前日にサクッとZEROKEN。
                    </v-card-text>
                  </div>
                </v-expand-transition>
              </v-card>
            </v-col>
            <v-col>
              <v-card class="mx-auto" max-width="344">
                <v-img :src="beersSrc" width="344" height="100" />

                <v-card-title> 歓送迎会の前に </v-card-title>

                <v-card-subtitle> アルハラが怖い会ですよね。 </v-card-subtitle>

                <v-card-actions>
                  <v-btn color="orange lighten-2" text>解決方法</v-btn>

                  <v-spacer></v-spacer>

                  <v-btn icon @click="emerge = !emerge">
                    <v-icon>{{ emerge ? 'mdi-chevron-up' : 'mdi-chevron-down' }}</v-icon>
                  </v-btn>
                </v-card-actions>

                <v-expand-transition>
                  <div v-show="emerge">
                    <v-divider></v-divider>

                    <v-card-text>
                      そんな時はZEROKENを使って事前に自分のお酒の強さをチェック。歓送迎会の前にサクッとZEROKEN
                    </v-card-text>
                  </div>
                </v-expand-transition>
              </v-card>
            </v-col>
          </v-row>
        </v-container>
        <v-row class="text-center d-flex justify-space-around">
          <v-col cols="3" sm="10" md="12" lg="12">
            <!-- <v-btn @click="dialog1 = true">酒(シュ)ケジュールとは</v-btn> -->
            <v-dialog
              v-model="dialog1"
              scrollable
              max-width="80%"
              transition="dialog-top-transition"
            >
              <v-card>
                <v-card-title class="text-h5 grey lighten-2">酒(シュ)ケジュールとは</v-card-title>
                <v-divider></v-divider>
                <v-card-text>次の飲み会でのむお酒の順番を意味しています。</v-card-text>
                <v-card-text>「お酒の順番 + スケジュール」の造語です。</v-card-text>
                <v-card-text
                  >使用例
                  「酒ケジュールによると次はノンアルを飲む予定になっているのでもうお酒は飲めません。。」</v-card-text
                >
              </v-card>
            </v-dialog>
            <!-- <v-btn @click="dialog2 = true">飲みベーションとは</v-btn> -->
            <v-dialog
              v-model="dialog2"
              scrollable
              max-width="80%"
              transition="dialog-top-transition"
            >
              <v-card>
                <v-card-title class="text-h5 grey lighten-2">飲みベーションとは</v-card-title>
                <v-divider></v-divider>
                <v-card-text>次の飲み会に向けたモチベーションを意味しています。</v-card-text>
                <v-card-text>「飲み + ステータス」の造語です。</v-card-text>
                <v-card-text>使用例 「飲みべ低いので今日は帰ります。。」</v-card-text>
              </v-card>
            </v-dialog>
            <!-- <v-btn @click="dialog3 = true">酒テータスとは</v-btn> -->
            <v-dialog
              v-model="dialog3"
              scrollable
              max-width="80%"
              transition="dialog-top-transition"
            >
              <v-card>
                <v-card-title class="text-h5 grey lighten-2">酒テータスとは</v-card-title>
                <v-divider></v-divider>
                <v-card-text
                  >ユーザーのお酒の強さ、そして次の飲み会で飲むお酒の順番を表す状態になります。</v-card-text
                >
                <v-card-text>「お酒 + ステータス」の造語です。</v-card-text>
                <v-card-text
                  >使用例: 「私の酒テータス下戸だから飲み会参加できないんです。。」</v-card-text
                >
              </v-card>
            </v-dialog>
          </v-col>
        </v-row>
      </v-row>
    </v-container>
  </div>
</template>

<script>
import axios from '../plugins/axios';
import { mapActions, mapGetters } from 'vuex';
import FirstGreeting from '../components/FirstGreeting';
export default {
  name: 'ZerokenTop',
  data() {
    return {
      isVisibleFirstGreeting: false,
      show: false,
      emerge: false,
      dialog1: false,
      dialog2: false,
      dialog3: false,
      tab: null,
      dialog: false,
      title: 'あなたにとっての0軒目',
      text: '飲み会で飲むお酒を診断しよう',
    };
  },
  components: {
    FirstGreeting,
  },
  beforeRouteEnter(to, from, next) {
    if (from.name === 'UserRegister')
      next((self) => {
        self.fetchAuthUser().then((authUser) => {
          if (authUser) return (self.isVisibleFirstGreeting = true);
        });
      });
    else next();
  },
  computed: {
    ...mapGetters('users', ['authUser']),
    izakayaSrc() {
      return require('../src/img/Izakaya_4.jpeg');
    },
    beersSrc() {
      return require('../src/img/beer.jpeg');
    },
    imgSrc() {
      return require('../src/img/beer.svg');
    },
    enkaiSrc() {
      return require('../src/img/nomikai.png');
    },
    dateSrc() {
      return require('../src/img/date.png');
    },
  },
  mounted() {
    axios.get('/users').then((response) => (this.users = response.data));
    this.show = true;
  },

  created() {
    this.fetchAuthUser();
  },
  methods: {
    ...mapActions('users', ['fetchAuthUser']),
    ...mapActions('users', ['loginGuestUser']),
    ...mapActions('snackbar', ['fetchSnackbarData']),
    toAnalyze() {
      this.$router.push({ name: 'Analyze' });
    },
    loginFunction() {
      this.loginGuestUser(this.user).then((user) => {
        if (user) {
          this.$router.push({ name: 'Analyze' });
        } else {
          this.fetchSnackbarData({
            msg: 'ログインに失敗しました',
            color: 'error',
            isShow: true,
          });
        }
      });
    },
  },
};
</script>
<style scoped>
#izakaya {
  background: url(../src/img/beer.jpeg) center center / cover no-repeat fixed;
}

html {
  width: 1024px;
}
.img {
  transform: scale(2, 2);
}
.fade-enter-active,
.fade-leave-active {
  /* 表示されている際のCSSはこのブロックに記述 */
  will-change: opacity;
  transition: opacity 225ms cubic-bezier(0.4, 0, 0.2, 1) 500ms;
}
.fade-enter,
.fade-leave-to {
  /* 非表示の際のCSSはこのブロックに記述 */
  opacity: 0;
}

.title {
  color: white;
}
</style>
