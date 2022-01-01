<template>
  <v-container fluid style="background-color: rgb(0, 0, 0, 0.4); box-sizing: border-box">
    <v-row class="mb-10">
      <v-col class="pt-10 text-center register">
        <h3 class="text-h4 mb-4 font-weight-black white--text">新規登録</h3>
        <p class="text-body-1 white--text">
          アカウントをお持ちの方は
          <router-link class="router-link" :to="{ name: 'UserLogin' }"> こちら </router-link>
          から。
        </p>
      </v-col>
    </v-row>
    <v-row justify="center" align-content="center">
      <!-- <v-col cols="12" sm="5" md="5" lg="5" xl="5">
        <v-card height="100%">
          <p class="text-h6 pt-8 px-8 text-center font-weight-black">
            SNSで<br class="br-sp" />登録
          </p>
          <v-card-actions class="d-flex flex-column">
            <v-btn class="mb-12" x-large>Twitter</v-btn>
            <v-btn class="mb-12" x-large>Google</v-btn>
          </v-card-actions>
        </v-card>
      </v-col>
      <v-col class="d-flex justify-center align-center" cols="12" sm="2" md="2" lg="2" xl="2">
        <p>または</p>
      </v-col> -->
      <v-col cols="12" sm="5" md="5" lg="5" xl="5">
        <UserRegisterForm
          v-bind.sync="user"
          @create-user="registerFunction"
          register-title="メールアドレスで新規登録"
        />
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { mapActions } from 'vuex';
import UserRegisterForm from '../components/forms/UserRegisterForm.vue';
export default {
  name: 'UserRegister',
  components: {
    UserRegisterForm,
  },
  data() {
    return {
      user: {
        nickname: '',
        email: '',
        password: '',
        password_confirmation: '',
      },
    };
  },
  methods: {
    ...mapActions('users', ['registerUser']),
    ...mapActions('snackbar', ['fetchSnackbarData']),
    registerFunction() {
      this.registerUser(this.user).then((user) => {
        if (user) {
          this.$router.push({ name: 'ZerokenTop' });
        } else {
          this.fetchSnackbarData({
            msg: '新規登録に失敗しました',
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
  background-color: rgb(0, 0, 0, 0.4);
}
.outer-layer {
  /* background: url(../src/img/woodtile.jpeg) ; */
  background-color: rgb(0, 255, 0, 0.4);
  /* padding: 0.5em 1em;
  margin: 2em 0; */
  /* font-weight: bold; */
  border: solid 3px #000; /*線*/
  border-radius: 10px; /*角の丸み*/
}
</style>
