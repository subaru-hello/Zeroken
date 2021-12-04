<template>
  <v-container fill-height fluid>
    <FirstGreeting
      :dialog="isVisibleFirstGreeting"
      @close-dialog="isVisibleFirstGreeting = false"
    />

    <v-row justify="center" align-content="center">
      <v-col class="text-center align-self-center" cols="12">
        <p class="text-h2 bold">ゼロケン</p>
        <p class="text-h5 mb-12 font-weight-bold d-sm-block text-no-wrap service-description">
          {{ title }}<br />{{ text }}
        </p>
        <img :src="imgSrc" class="img" width="150" height="100" />
        <v-spacer />
        <div>
          <v-btn class="mb-8" color="primary" x-large dark @click="loginFunction()">
            さっそく酒ケジュールを作る
          </v-btn>
        </div>
      </v-col>

      <v-spacer />
      <v-row class="text-center d-flex justify-space-around">
        <v-col cols="3" sm="10" md="12" lg="12">
          <v-btn @click="dialog1 = true">酒(シュ)ケジュールとは</v-btn>
          <v-dialog v-model="dialog1" scrollable max-width="80%" transition="dialog-top-transition">
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
          <v-btn @click="dialog2 = true">飲みベーションとは</v-btn>
          <v-dialog v-model="dialog2" scrollable max-width="80%" transition="dialog-top-transition">
            <v-card>
              <v-card-title class="text-h5 grey lighten-2">飲みベーションとは</v-card-title>
              <v-divider></v-divider>
              <v-card-text>次の飲み会に向けたモチベーションを意味しています。</v-card-text>
              <v-card-text>「飲み + ステータス」の造語です。</v-card-text>
              <v-card-text>使用例 「飲みべ低いので今日は帰ります。。」</v-card-text>
            </v-card>
          </v-dialog>
          <v-btn @click="dialog3 = true">酒テータスとは</v-btn>
          <v-dialog v-model="dialog3" scrollable max-width="80%" transition="dialog-top-transition">
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
    imgSrc() {
      return require('../src/img/beer.svg');
    },
  },
  mounted() {
    axios.get('/users').then((response) => (this.users = response.data));
  },

  created() {
    this.fetchAuthUser();
  },
  methods: {
    ...mapActions('users', ['fetchAuthUser']),
    ...mapActions('users', ['loginGuestUser']),
    ...mapActions('snackbar', ['fetchSnackbarData']),
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
  width: 500px;
  background-image: url(../../assets/images/Izakaya.jpeg);
}
.img {
  transform: scale(2, 2);
}
</style>
