<template>
    <div>
        <v-app-bar  style="background-color: #165e83;" id="page-header">
            <v-toolbar-title>
                <router-link class="router-link text-h4" style="color: #6EA4CA"
                :to="{ name: 'PreliquoTop' }">
                PRELIQUO
                </router-link>
            </v-toolbar-title>
            <v-spacer></v-spacer>
                 <template v-if="!!authUser">
                     <v-btn text style="color: #6EA4CA">マイページ</v-btn>
                     <v-btn text style="color: #6EA4CA">呑んべえ一覧</v-btn>
                     <v-btn text style="color: #6EA4CA">用語集</v-btn>
        <v-btn text rounded plain :ripple="{ center: true }" x-large @click="logoutFunction" id="logput_btn" style="color: white">
          ログアウト
        </v-btn>
        <router-link class="router-link text"
                :to="{ name: 'Analyze' }"
                style="color: #6EA4CA"
                >
                酒ケジュールを作成する
                </router-link>
      </template>
        <template v-else>
        <v-btn :to="{ name: 'UserRegister' }" text rounded :ripple="{ center: true }" x-large style="color: white">
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
    name: "TheHeader",
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
}
</script>