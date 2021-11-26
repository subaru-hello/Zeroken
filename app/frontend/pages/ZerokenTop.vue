<template>
  <v-container fill-height fluid>
    <FirstGreeting
      :dialog="isVisibleFirstGreeting"
      @close-dialog="isVisibleFirstGreeting = false"
    />

    <v-row align-content="center">
      <v-col class="text-right align-self-center" cols="6">
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
      // users: [],
      tab: null,
      dialog: false,
      title: 'あなたにとっての0軒目',
      text: '華金に向けてお酒の強さを診断しましょう',
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
