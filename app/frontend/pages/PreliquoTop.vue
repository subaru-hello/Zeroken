<template>
  <v-container style="max-width: 1030px; margin: 0 auto" id="izakaya">
    <FirstGreeting
      :dialog="isVisibleFirstGreeting"
      @close-dialog="isVisibleFirstGreeting = false"
    />

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
        <v-btn @click="loginFunction()"> さっそく酒ケジュールを作る</v-btn>

      </v-row>
    </v-col>
  </v-container>
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
      items: {
        title: [ 'あなたにとっての0軒目'],
 text: ['最適なお酒の飲む順番を提供します'],
        
      },
     
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
</style>
