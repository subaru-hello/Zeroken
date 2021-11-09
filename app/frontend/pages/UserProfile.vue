<template>
  <v-container fluid>
    <v-row>
      <v-col cols="12" sm="6">
        <v-row class="d-flex justify-center">
          <v-col cols="12" sm="8" class="pt-16">
            <v-sheet id="profile-sheet" class="py-6 px-10 text-center" elevation="1">
              <h3 class="text-h6 font-weight-black mb-8">マイプロフィール</h3>
              <v-avatar class="or-avatar mb-5" size="200">
                <img :src="currentUser.avatar" />
              </v-avatar>
              <div class="text-left mb-6">
                <div>
                  <h3 class="text-subtitle-1 font-weight-black">ニックネーム</h3>
                  <div>{{currentUser.nickname}}</div>
                </div>
                <v-divider class="mb-6" />
                <div>
                  <h3 class="text-subtitle-1 font-weight-black">メールアドレス</h3>
                  <div>{{currentUser.email}}</div>
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
            <!-- プロフィール編集フォーム -->
            <ProfileEditForm
              v-if="editProfileActed"
              v-bind.sync="authUserEdit"
              :isShow.sync="editProfileDialogDisplayed"
              @updateProfile="updateProfile"
              @changeDialog="changeProfileToPassword"
              @closeDialog="closeEditProfileDialog"
            />
            <!-- パスワード編集フォーム -->
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
      </v-col>
    </v-row>
    <div>{{whuAreYou}}</div>
  </v-container>
</template>

<script>
import { mapActions, mapGetters } from 'vuex';
import axios from '../plugins/axios';
import ProfileEditForm from '../components/forms/ProfileEditForm.vue';
import PasswordEditForm from '../components/forms/PasswordEditForm.vue';
import Jimp from 'jimp/es';
export default {
  components: {
    ProfileEditForm,
    PasswordEditForm,
  },
  data() {
    return {
      users: [],
      authUserEdit:{},
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
    whuAreYou(){
      const currentUserData =  this.authUserEdit;
      return currentUserData
    },
    currentUser(){
      const currentUserData =  this.authUser["data"]["attributes"];
      const authUserData = {
        nickname: currentUserData["nickname"],
        emamil: currentUserData["email"],
        // password: currentUserData["password"],
        // password_confirmation: currentUserData["password_confirmation"],
        avatar: currentUserData["avatar"],
      }
      this.editAuthUser = authUserData;
      return currentUserData;
    }
  },
    mounted() {
    axios.get('/users').then((response) => (this.users = response.data));
  },
  created() {
    this.authUserEdit = this.authUser;
    this.fetchAuthUser();
  },
  methods: {
    ...mapActions('users', ['updateAuthUser']),
     ...mapActions('users', ['fetchAuthUser']),
    ...mapActions('snackbars', ['fetchSnackbarData']),
    displayProfileEditDialog() {
      this.initAuthUserEdit();
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
    //Todo Update処理をaxiosで実行するためにはどうすればいいか。
    updatePassword() {
      this.axios
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
    //Todo authUserEditにavatarを追加する

    initAuthUserEdit() {
      this.authUserEdit = this.authUser;
      // base64でencodeしてないとサーバー側でdecodeする際にerror
      Jimp.read(this.authUserEdit.avatar).then((image) => {
        image.getBase64(Jimp.MIME_PNG, (err, src) => {
          this.authUserEdit.avatar = src;
        });
      });
    },
  },
};
</script>
