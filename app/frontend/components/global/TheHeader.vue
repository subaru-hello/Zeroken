<template>
  <div>
    <v-app-bar style="background-color: #165e83" id="page-header">
      <v-toolbar-title>
        <router-link
          class="router-link text-h4"
          style="color: #6ea4ca"
          :to="{ name: 'ZerokenTop' }"
        >
          ZEROKEN
        </router-link>
      </v-toolbar-title>
      <v-spacer></v-spacer>
      <template v-if="!!authUser">
        <router-link
          class="router-link text"
          :to="{ name: 'UserProfile' }"
          text
          rounded
          plain
          :ripple="{ center: true }"
          x-large
          style="color: white"
        >
          酒テータス
        </router-link>
        <v-btn
          class="router-link text"
          text
          rounded
          plain
          :ripple="{ center: true }"
          x-large
          style="color: white"
          @click="dialog = true"
          >用語集</v-btn
        >
        <v-dialog v-model="dialog" scrollable max-width="80%">
          <v-card>
            <v-card-title>作成中です。</v-card-title>
            <v-divider></v-divider>
            <v-card-text
              >大変申し訳ありません。作者が二日酔いのため作成が遅れております。しばしお待ちください。。
            </v-card-text>
          </v-card>
        </v-dialog>
        <v-btn
          text
          rounded
          plain
          class="router-link text"
          :ripple="{ center: true }"
          x-large
          @click="logoutFunction"
          id="logput_btn"
          style="color: white"
        >
          ログアウト
        </v-btn>
        <router-link
          class="router-link text"
          :to="{ name: 'Analyze' }"
          style="color: white"
          text
          rounded
          plain
          :ripple="{ center: true }"
          x-large
        >
          酒ケジュール作成
        </router-link>
      </template>
      <template v-else>
        <v-btn
          :to="{ name: 'UserRegister' }"
          text
          rounded
          :ripple="{ center: true }"
          x-large
          style="color: white"
        >
          新規登録
        </v-btn>
        <v-btn text style="color: white">用語集</v-btn>
        <v-btn
          class="hidden-sm-and-down"
          :to="{ name: 'UserLogin' }"
          text
          rounded
          :ripple="{ center: true }"
          x-large
          style="color: white"
        >
          ログイン
        </v-btn>
      </template>
    </v-app-bar>
  </div>
</template>
<script>
import { mapActions, mapGetters } from 'vuex';
export default {
  name: 'TheHeader',
  data() {
    return {
      dialog: false,
    };
  },
  computed: {
    ...mapGetters('users', ['authUser']),
  },

  methods: {
    ...mapActions('users', ['logoutUser']),
    ...mapActions('snackbar', ['fetchSnackbarData']),
    logoutFunction() {
      this.logoutUser().then((res) => {
        if (res) {
          this.$router.go({ path: this.$router.currentRoute.path });
          this.fetchSnackbarData({
            msg: 'ログアウトしました',
            color: 'success',
            isShow: true,
          });
        } else {
          this.fetchSnackbarData({
            msg: 'ログアウトに失敗しました',
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
.izakaya {
  width: 100%;
  background-image: url(../../../assets/images/Izakaya.jpeg);
}
</style>
