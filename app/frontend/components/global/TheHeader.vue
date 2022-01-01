<template>
  <div>
    <v-app-bar
      rounded
      elevation="24"
      fixed
      elevate-on-scroll
      style="background-color: rgb(0, 60, 80)"
    >
      <v-app-bar-nav-icon @click="drawer = true"></v-app-bar-nav-icon>
      <v-divider class="mx-4" style="color: white" vertical></v-divider>
      <v-toolbar-title @click="toHome()">
        <div style="color: white; float: left">
          <img :src="imgSrc" class="text-center mt-4" width="100" />
        </div>
        <!-- {{ checkUserRole }} -->
      </v-toolbar-title>
      <v-spacer></v-spacer>
      <v-list-item-group
        v-model="group"
        class="login-user d-flex justify-space-between"
        style="text-decoration: none"
      >
        <!-- <v-list-item>
          <v-btn
            @click="snsUrl()"
            class="white--text"
            style="background-color: rgb(0, 0, 0, 0.6); border-radius: 20%"
          >
            作者を応援<v-icon color="#1da1f2"> mdi-twitter </v-icon></v-btn
          >
        </v-list-item> -->
        <v-divider class="mx-4" style="color: white" vertical></v-divider>

        <v-list-item @click="toRegister()">
          <div class="white--text" style="font-size: 10px">新規登録</div>
        </v-list-item>
        <v-divider class="mx-4" style="color: white" vertical></v-divider>
        <v-list-item @click="toLogin()">
          <div class="white--text" style="font-size: 10px">ログイン</div>
        </v-list-item>
      </v-list-item-group>
    </v-app-bar>

    <v-navigation-drawer v-model="drawer" absolute temporary>
      <v-list nav>
        <v-list-item-group v-model="group" style="text-decoration: none">
          <v-list-item @click="toHome()">
            <div>
              <v-list-item-icon>
                <v-icon>mdi-home</v-icon>
              </v-list-item-icon>
            </div>
            <div>ZEROKEN</div>
          </v-list-item>
          <v-list-item @click="toPhrase()">
            <div>
              <v-list-item-icon>
                <v-icon>mdi-book-open-variant</v-icon>
              </v-list-item-icon>
            </div>
            <div>用語集</div>
          </v-list-item>
          <!-- <div v-if="authUser.data.attributes.role='member'"> -->
          <div v-if="authUser">
            <v-list-item @click="toProfile()">
              <div>
                <v-list-item-icon>
                  <v-icon>mdi-account</v-icon>
                </v-list-item-icon>
              </div>
              <div @click="toProfile()">酒テータス</div>
            </v-list-item>

            <v-list-item @click="logoutFunction">
              <div>
                <v-list-item-icon>
                  <v-icon>mdi-logout</v-icon>
                </v-list-item-icon>
              </div>
              <div>ログアウト</div>
            </v-list-item>
          </div>
          <div v-else>
            <v-list-item @click="toRegister()">
              <div>
                <v-list-item-icon>
                  <v-icon>mdi-account-plus</v-icon>
                </v-list-item-icon>
              </div>
              <div>新規登録</div>
            </v-list-item>
            <v-list-item @click="toLogin()">
              <div>
                <v-list-item-icon>
                  <v-icon>mdi-login</v-icon>
                </v-list-item-icon>
              </div>
              <div>ログイン</div>
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
      hashtags: 'ZEROKEN,アルハラ防止,酒ケジュール',
      user: [],
    };
  },
  computed: {
    ...mapGetters('users', ['authUser']),
    checkUserRole() {
      const currentUser = this.authUser['data'];
      const x = (this.user = currentUser);

      return currentUser;
    },
    imgSrc() {
      return require('../../src/img/zeroken-logo_4.png');
    },
  },
  created() {
    this.fetchAuthUser();
  },
  methods: {
    ...mapActions('users', ['logoutUser']),
    ...mapActions('snackbar', ['fetchSnackbarData']),
    ...mapActions('users', ['fetchAuthUser']),
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
    snsUrl() {
      setTimeout(
        function () {
          const url = encodeURIComponent(`https://www.zeroken.site`);
          const title = encodeURIComponent('【ZEROKEN】');
          const writer = encodeURIComponent(`@247subaru`);
          const twitter =
            'https://twitter.com/intent/tweet?url=' +
            url +
            '&text=' +
            title +
            `%0Aまだ酒ケジュールを作成していないですが、なんか良さそうなサイトでした!!` +
            '&hashtags=' +
            this.hashtags;
          window.location.href = twitter;
        }.bind(this),
        100
      );
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
<style scoped>
.login-user {
  float: right;
}
</style>
