<template>
  <div>
    <v-app-bar
      rounded
      elevation="24"
      absolute
      app
      elevate-on-scroll
      shaped
      style="background-color: #6ea4ca"
    >
      <v-app-bar-nav-icon @click="drawer = true"></v-app-bar-nav-icon>

      <v-toolbar-title>
        <div @click="toHome()" style="color: white">ZEROKEN</div>
      </v-toolbar-title>
    </v-app-bar>

    <v-navigation-drawer v-model="drawer" absolute temporary>
      <v-list nav dense>
        <v-list-item-group v-model="group" style="text-decoration: none">
          <v-list-item>
            <div @click="toHome()">
              <v-list-item-icon>
                <v-icon>mdi-home</v-icon>
              </v-list-item-icon>
            </div>
            <div @click="toHome()">ZEROKEN</div>
          </v-list-item>
          <v-list-item>
            <div @click="toPhrase()">
              <v-list-item-icon>
                <v-icon>mdi-book-open-variant</v-icon>
              </v-list-item-icon>
            </div>
            <div @click="toPhrase()">用語集</div>
          </v-list-item>
          <!-- <div v-if="authUser.data.attributes.role='member'"> -->
          <div v-if="authUser">
            <v-list-item>
              <div @click="toProfile()">
                <v-list-item-icon>
                  <v-icon>mdi-account</v-icon>
                </v-list-item-icon>
              </div>
              <div @click="toProfile()">酒テータス</div>
            </v-list-item>

            <v-list-item>
              <div @click="logoutFunction">
                <v-list-item-icon>
                  <v-icon>mdi-logout</v-icon>
                </v-list-item-icon>
              </div>
              <div @click="logoutFunction">ログアウト</div>
            </v-list-item>
          </div>
          <div v-else>
            <v-list-item>
              <div @click="toRegister()">
                <v-list-item-icon>
                  <v-icon>mdi-account-plus</v-icon>
                </v-list-item-icon>
              </div>
              <div @click="toRegister()">新規登録</div>
            </v-list-item>
            <v-list-item>
              <div @click="toLogin()">
                <v-list-item-icon>
                  <v-icon>mdi-login</v-icon>
                </v-list-item-icon>
              </div>
              <div @click="toLogin()">ログイン</div>
            </v-list-item>
          </div>
        </v-list-item-group>
      </v-list>
      <v-dialog v-model="dialog" scrollable max-width="80%">
        <v-card>
          <v-card-title>作成中です。</v-card-title>
          <v-divider></v-divider>
          <v-card-text
            >大変申し訳ありません。作者が二日酔いのため作成が遅れております。しばしお待ちください。。
          </v-card-text>
        </v-card>
      </v-dialog>
    </v-navigation-drawer>
  </div>
</template>
<script>
import { mapActions, mapGetters } from 'vuex';
export default {
  name: 'TheHeader',
  data() {
    return {
      dialog: false,
      drawer: false,
      group: null,
    };
  },
  computed: {
    ...mapGetters('users', ['authUser']),
  },

  methods: {
    ...mapActions('users', ['logoutUser']),
    ...mapActions('snackbar', ['fetchSnackbarData']),
    toProfile() {
      this.$router.push({ name: 'UserProfile' });
    },
    toLogin() {
      this.$router.push({ name: 'UserLogin' });
    },
    toRegister() {
      this.$router.push({ name: 'UserRegister' });
    },
    toPhrase() {
      this.$router.push({ name: 'Phrases' });
    },
    toHome() {
      this.$router.push({ name: 'ZerokenTop' });
    },
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
<style scoped></style>
