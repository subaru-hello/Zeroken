<template>
  <v-container fluid>
    <v-row>
      <v-col cols="12" sm="12">
        <v-row class="d-flex justify-center">
          <v-col
            cols="12"
            sm="8"
            class="pt-16 d-flex justify-space-between mb-6"
            :color="$vuetify.theme.dark ? 'grey darken-3' : 'grey lighten-4'"
            flat
            tile
          >
            <v-sheet id="profile-sheet" class="py-6 px-10 text-center" elevation="1">
              <h3 class="text-h6 font-weight-black mb-8">プロフィール</h3>
              <v-avatar class="or-avatar mb-5" size="200">
                <img :src="sakeSrc" width="150" height="100" />
              </v-avatar>
              <div class="text-left mb-6">
                <div>
                  <h3 class="text-subtitle-1 font-weight-black">ニックネーム</h3>
                  <div>{{ authUser.data.attributes.nickname }}</div>
                </div>
                <v-divider class="mb-6" />
                <div>
                  <h3 class="text-subtitle-1 font-weight-black">メールアドレス</h3>
                  <div>{{ authUser.data.attributes.email }}</div>
                </div>
                <v-divider class="mb-6" />
              </div>
              <v-btn class="mb-6" x-large @click.stop="displayProfileEditDialog">
                <v-icon class="mr-1">mdi-account-cog</v-icon>
                編集する
              </v-btn>
              <p class="text-body2">
                パスワードを変更する場合は
                <a @click.stop="displayPasswordEditDialog"> こちら </a>
              </p>
            </v-sheet>
            <div style="margin-left: 10%">
              <h3
                class="text-h6 font-weight-black mb-8 mx-auto text-center"
                @click.stop="dialog = true"
              >
                過去の酒ケジュール
              </h3>

              <!-- <v-date-picker full-width @click.stop="dialog = true"></v-date-picker> -->
              <v-date-picker
                full-width
                v-model="date1"
                :events="arrayEvents"
                event-color="green lighten-1"
                @click="opened()"
              ></v-date-picker>

              <v-dialog v-model="dialog" scrollable max-width="80%">
                <v-card>
                  <v-card-title>11月12日の酒ケジュール</v-card-title>
                  <v-divider></v-divider>
                  <v-card-text height="200px"
                    >1. ビール 2. ハイボール 3. 日本酒 4. ワイン</v-card-text
                  >
                </v-card>
              </v-dialog>
            </div>

            <ProfileEditForm
              v-if="editProfileActed"
              v-bind.sync="authUserEdit"
              :isShow.sync="editProfileDialogDisplayed"
              @updateProfiles="updateProfiles"
              @changeDialog="changeProfileToPassword"
              @closeDialog="closeEditProfileDialog"
            />
            <!-- パスワード編集フォーム -->
            <!-- @updatePassword="updatePassword"でパスワードの更新を行なっている。 -->
            <PasswordEditForm
              v-if="editPasswordActed"
              :password.sync="password"
              :password_confirmation.sync="password_confirmation"
              :isShow.sync="editPasswordDialogDisplayed"
              @updatePassword="updatePassword"
              @changeDialog="changePasswordToProfile"
              @closeDialog="closeEditPasswordDialog"
            />
          </v-col>
        </v-row>
        <v-col> </v-col>
      </v-col>
    </v-row>
    <div>{{ whuAreYou }}</div>
  </v-container>
</template>

<script>
import { mapActions, mapGetters } from 'vuex';
import axios from '../plugins/axios';
import ProfileEditForm from '../components/forms/ProfileEditForm.vue';
import PasswordEditForm from '../components/forms/PasswordEditForm.vue';
// import Jimp from 'jimp/es';
export default {
  components: {
    ProfileEditForm,
    PasswordEditForm,
  },
  data() {
    return {
      users: [],
      dialog: false,
      arrayEvents: null,
      date1: new Date(Date.now() - new Date().getTimezoneOffset() * 60000)
        .toISOString()
        .substr(0, 10),
      date2: new Date(Date.now() - new Date().getTimezoneOffset() * 60000)
        .toISOString()
        .substr(0, 10),
      authUserEdit: {},
      password: '',
      password_confirmation: '',
      editProfileActed: false,
      editPasswordActed: false,
      editProfileDialogDisplayed: false,
      editPasswordDialogDisplayed: false,
    };
  },
  computed: {
    ...mapGetters('users', ['authUser']),
    sakeSrc() {
      return require('../src/img/default_profile.png');
    },
    whuAreYou() {
      const currentUserData = this.authUserEdit;
      return currentUserData;
    },
  },
  mounted() {
    axios.get('/users').then((response) => (this.users = response.data));
    this.arrayEvents = [...Array(6)].map(() => {
      const day = Math.floor(Math.random() * 30);
      const d = new Date();
      d.setDate(day);
      return d.toISOString().substr(0, 10);
    });
  },
  created() {
    this.fetchAuthUser();
    const authUserData = {
      nickname: this.authUser.data.attributes.nickname,
      email: this.authUser.data.attributes.email,
      // password: currentUserData["password"],
      // password_confirmation: currentUserData["password_confirmation"],
      avatar: this.authUser.data.attributes.avatar,
    };
    this.authUserEdit = authUserData;
  },
  methods: {
    ...mapActions('users', ['updateAuthUser']),
    ...mapActions('users', ['fetchAuthUser']),
    ...mapActions('snackbar', ['fetchSnackbarData']),
    functionEvents(date) {
      const [, , day] = date.split('-');
      if ([12, 17, 28].includes(parseInt(day, 10))) return true;
      if ([1, 19, 22].includes(parseInt(day, 10))) return ['red', '#00f'];
      return false;
    },
    opened() {
      this.dialog = true;
    },
    displayProfileEditDialog() {
      // this.initAuthUserEdit();
      this.handleShowEditProfile();
      this.editProfileActed = true;
    },
    displayPasswordEditDialog() {
      this.handleShowEditPassword();
      this.editPasswordActed = true;
    },
    closeEditPasswordDialog() {
      this.handleShowEditPassword();
      this.password = '';
      this.password_confirmation = '';
    },
    closeEditProfileDialog() {
      this.handleShowEditProfile();
    },
    changeProfileToPassword() {
      this.closeEditProfileDialog();
      this.displayPasswordEditDialog();
    },
    changePasswordToProfile() {
      this.closeEditPasswordDialog();
      this.displayProfileEditDialog();
    },
    handleShowEditPassword() {
      this.editPasswordDialogDisplayed = !this.editPasswordDialogDisplayed;
    },
    handleShowEditProfile() {
      this.editProfileDialogDisplayed = !this.editProfileDialogDisplayed;
    },
    updateProfile() {
      this.updateAuthUser(this.authUserEdit).then((user) => {
        if (user) {
          this.handleShowEditProfile();
          this.fetchSnackbarData({
            msg: 'プロフィールを更新しました',
            color: 'success',
            isShow: true,
          });
        } else {
          this.fetchSnackbarData({
            msg: 'プロフィールを更新できませんでした',
            color: 'error',
            isShow: true,
          });
        }
      });
    },
    updatePassword() {
      axios
        .patch(`profile/password`, {
          password: this.password,
          password_confirmation: this.password_confirmation,
        })
        .then(() => {
          this.handleShowEditPassword();
          this.fetchSnackbarData({
            msg: 'パスワードを更新しました',
            color: 'success',
            isShow: true,
          });
        })
        .catch((err) => {
          this.fetchSnackbarData({
            msg: 'パスワードの更新に失敗しました',
            color: 'error',
            isShow: true,
          });
          console.log(err);
        });
    },
    updateProfiles() {
      axios
        .patch('profile/edit', {
          nickname: this.authUser.data.attributes.nickname,
          email: this.authUser.data.attributes.email,
        })
        .then(() => {
          this.handleShowEditProfile();
          this.fetchSnackbarData({
            msg: 'プロフィールを更新しました',
            color: 'success',
            isShow: true,
          });

          this.$router.push({ name: 'ZerokenTop' });
        })
        .catch((err) => {
          this.fetchSnackbarData({
            msg: 'プロフィールを更新できませんでした',
            color: 'error',
            isShow: true,
          });
          console.log(err);
        });
    },
    //Todo authUserEditにavatarを追加する

    // initAuthUserEdit() {
    //   this.authUserEdit = this.authUser;
    //   // base64でencodeしてないとサーバー側でdecodeする際にerror
    //   Jimp.read(this.authUserEdit.avatar).then((image) => {
    //     image.getBase64(Jimp.MIME_PNG, (err, src) => {
    //       return (this.authUserEdit.avatar = src);
    //     });
    //   });
    // },
  },
};
</script>
