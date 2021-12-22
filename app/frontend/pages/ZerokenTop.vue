<template>
  <div>
    <v-container
      fill-height
      fluid
      class="container"
      style="background-color: rgb(0, 0, 0, 0.4); box-sizing: border-box"
    >
      <FirstGreeting
        :dialog="isVisibleFirstGreeting"
        @close-dialog="isVisibleFirstGreeting = false"
      />

      <v-row justify="center" align-content="center">
        <v-col class="text-center align-self-center" cols="12">
          <p
            class="text-h5 mb-12 mt-5 font-weight-bold d-sm-block text-no-wrap service-description title"
          >
            {{ subtitle }}<br />{{ text }}
          </p>
          <transition name="fade">
            <div class="text-h2 bold title" style="font-size: 20px; font-weight: bold" v-if="show">
              {{ title }}
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
            <v-row justify="center" align-content="center">
              <v-icon
                class="text-center d-flex mt-5"
                color="#fff"
                @click="clickScroll($event)"
                x-large
                >mdi-chevron-down</v-icon
              >
            </v-row>
          </v-col>
        </v-col>

        <v-spacer />
        <v-container class="about">
          <v-container align-content="center" justyfy="center" class="ma-4">
            <v-row>
              <v-col>
                <v-card class="mx-auto" max-width="500" elevation="10">
                  <v-card-text class="text-center">
                    <ZerokenAbout :autoplay="autoplay" />
                  </v-card-text>
                </v-card>
              </v-col>
            </v-row>

            <v-row justify="center" align-content="center">
              <v-col
                cols="12"
                sm="8"
                class="d-flex inline text-center card-style"
                v-for="list in lists"
                :key="list.id"
              >
                <v-card class="mx-auto" max-width="344">
                  <v-card-title style="border" class="text-center">
                    {{ list.title }}
                  </v-card-title>
                  <v-card-text>
                    {{ list.description }}
                  </v-card-text>
                </v-card>
              </v-col>
            </v-row>
          </v-container>
        </v-container>

        <CreateShucheduleButton
          class="mb-8 text-center"
          v-if="!authUser"
          style="background-color: rgb(222, 184, 135)"
          x-large
          @click-response="loginFunction()"
        />

        <CreateShucheduleButton
          v-if="!!authUser"
          class="mb-8"
          style="background-color: rgb(222, 184, 135)"
          x-large
          @click-response="toAnalyze()"
        />
      </v-row>
    </v-container>
    <v-spacer></v-spacer>
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
      subtitle: 'あなたにとっての0軒目',
      title: 'ZEROKEN',
      text: '飲み会で飲むお酒を診断しよう',
      lists: [
        {
          title: '東大生の考案したアルゴリズムを採用',
          description:
            'アルコールパッチテストの簡易版とも言えるTASTを採用しています。13項目の質問に答えるだけであなたのお酒の強さを診断します。',
        },
        {
          title: '厚生労働省のデータに基づいた診断',
          description:
            '体内の血中アルコール濃度に基づいてなりたい状態までに必要なお酒の量を算出。酒ケジュールに従うだけで二日酔いをなくします。',
        },
        {
          title: 'アルハラ対策に最適な証明書を獲得',
          description:
            '真の下戸に対して下戸証明書を発行します。お守りとして携帯の待受にすることで、お酒に弱い方でも安心して飲み会に参加することができます。',
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
    clickScroll(e) {
      const targetArea = e.currentTarget.getBoundingClientRect().top;
      window.scrollTo({
        top: window.pageYOffset + targetArea,
        behavior: 'smooth',
      });
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
.crd-title {
  font-size: 15px;
  border-bottom: 1rem;
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
