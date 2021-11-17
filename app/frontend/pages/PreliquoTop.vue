<template>
  <v-container fill-height fluid>
    <FirstGreeting
      :dialog="isVisibleFirstGreeting"
      @close-dialog="isVisibleFirstGreeting = false"
    />

    <v-row align-content="center">
      <!-- <v-spacer /> -->
      <v-col class="text-right align-self-center" cols="6">
        <p class="text-h2 bold">ゼロケン</p>
        <p class="text-h5 mb-12 font-weight-bold d-sm-block text-no-wrap service-description">
          {{ title }}<br />{{ text }}
        </p>
        <img :src="imgSrc" class="img" width="150" height="100" />
        <v-spacer />
        <!-- 開始ボタン -->
        <div>
          <v-btn class="mb-8" color="primary" x-large dark @click="loginFunction()">
            さっそく酒ケジュールを作る
          </v-btn>
        </div>
      </v-col>

      <v-spacer />
    </v-row>
  </v-container>
  <!-- <v-container style="max-width: 1030px; margin: 0 auto" id="izakaya">
 
    <v-col >
      <v-row justify="center" align-content="center" >
        <v-col cols="12" xs="12" sm="12" md="12" lg="12">
          <h1 class="text-center" style="font-size: 50px" >ゼロケン</h1>
        </v-col>
        <v-card v-for="item in items" :key="item.id" >
          <v-col>
            <v-card-title>
              {{item.title}}
            </v-card-title>
            <v-card-text style="font-size: 25px">
              {{ item.text }}
            </v-card-text>
          </v-col>
        </v-card>
      
      </v-row>
    </v-col>
  </v-container> -->
</template>

<script>
import axios from '../plugins/axios';
import { mapActions, mapGetters } from 'vuex';
import FirstGreeting from '../components/FirstGreeting';
export default {
  name: 'PreliquoTop',
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
