<template>
  <div id="izakaya">
    <v-container fill-height fluid class="container" style="background-color: rgb(0, 0, 0, 0.4); box-sizing: border-box;">
      <FirstGreeting
        :dialog="isVisibleFirstGreeting"
        @close-dialog="isVisibleFirstGreeting = false"
      />

      <v-row justify="center" align-content="center">
        <v-col class="text-center align-self-center" cols="12">
          <p
            class="text-h5 mb-12 font-weight-bold d-sm-block text-no-wrap service-description title"
          >
            {{ title }}<br />{{ text }}
          </p>
          <transition name="fade">
            <div class="text-h2 bold title" style="font-size: 20px; font-weight: bold" v-if="show">
              ZEROKEN
            </div>
          </transition>

          <v-col>
            <!-- <img :src="imgSrc" class="img" width="150" height="100" /> -->
            <v-spacer />

            <div v-if="!authUser" class="text-center">
              <CreateShucheduleButton class="mb-8" x-large @click-response="loginFunction()" />
            </div>
            <div v-else class="text-center">
              <CreateShucheduleButton class="mb-8" x-large @click-response="toAnalyze()" />
            </div>
          </v-col>
        </v-col>
        <v-spacer />
        <v-container align-content="center" justyfy="center" class="ma-4">
        <v-row >
          <v-col>
            <v-card>
              <v-card-text class="text-center">
                <ZerokenAbout :autoplay="autoplay" />
              </v-card-text>
            </v-card>
            <v-icon class="text-center" x-large>mdi-chevron-down</v-icon>
          </v-col>
        </v-row>
        <v-container class="about">
          <v-row justify="center" align-content="center">
            <v-col
              cols="12"
              sm="8"
              class="d-flex inline text-center card-style"
              v-for="list in lists"
              :key="list.id"
            >
              <v-card class="mx-auto">
                <v-card-title style="border" class="text-center">
                  <v-subheader inset>
                    {{ list.title }}
                  </v-subheader>
                </v-card-title>
                <v-card-text>
                  {{ list.description }}
                </v-card-text>
              </v-card>
            </v-col>
          </v-row>
   
        <div v-if="!authUser">
          <CreateShucheduleButton
            class="mb-8"
            style="background-color: rgb(222, 184, 135)"
            x-large
            @click-response="loginFunction()"
          />
        </div>
        <div v-else>
          <CreateShucheduleButton
            class="mb-8"
            style="background-color: rgb(222, 184, 135)"
            x-large
            @click-response="toAnalyze()"
          />
        </div>
        </v-container>
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
import CreateShucheduleButton from '../components/global/CreateShucheduleButton';
import ZerokenAbout from '../components/top/ZerokenAbout';
export default {
  components: {
    FirstGreeting,
    ZerokenAbout,
    CreateShucheduleButton,
  },
  name: 'ZerokenTop',
  data() {
    return {
      isVisibleFirstGreeting: false,
      autoplay: true,
      show: false,
      emerge: false,
      dialog1: false,
      dialog2: false,
      dialog3: false,
      tab: null,
      dialog: false,
      title: 'あなたにとっての0軒目',
      text: '飲み会で飲むお酒を診断しよう',
      lists: [
        {
          title: '東大生の考案したアルゴリズムを採用',
          description:
            'アルコールパッチテストの簡易版とも言えるTASTを採用しています。13項目の質問に答えるだけであなたのお酒の強さを診断します。',
        },
        {
          title: '厚生労働省のデータに基づいた診断',
          description: '体内の血中アルコール濃度に基づいてなりたい状態までに必要なお酒の量を算出。',
        },
        {
          title: '下戸証明書を発行',
          description:
            '真の下戸に対して発行される証明書になります。これでお酒に弱い方でも飲み会に安心して参加することができます。',
        },
      ],
    };
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
.container::-webkit-scrollbar {
  display: none;
}
.card-style {
  align-content: center;
  width: 50%;
  margin: 0 auto;
}
.about {
  margin: 0, auto;
  display: flex;
  align-items: center;
  justify-content: center;
}
</style>
