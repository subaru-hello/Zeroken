<template>
  <v-container fluid class="mt-4 pt-21" style="box-sizing: border-box; padding: 0">
    <v-row>
      <v-col>
        <v-row class="content-center">
          <v-col :color="$vuetify.theme.dark ? 'grey darken-3' : 'grey lighten-4'" flat tile>
            <v-sheet id="profile-sheet" class="text-center outer-layer" elevation="1">
              <h3 class="text-h6 font-weight-black">酒テータス</h3>
              <p class="text-center black--text" style="font-size: 30px">
                {{ userAlcoholStrongness }}
              </p>
              <v-avatar class="or-avatar" size="200">
                <img :src="sakeSrc" width="150" height="100" />
              </v-avatar>
              <div class="text-center">
                <div>
                  <h3 class="text-subtitle-1 font-weight-black">ニックネーム</h3>
                  <div>{{ authUser.data.attributes.nickname }}</div>
                </div>
                <v-divider />
                <div>
                  <h3 class="text-subtitle-1 font-weight-black">メールアドレス</h3>
                  <div>{{ authUser.data.attributes.email }}</div>
                </div>
                <div>
                  <h3 class="text-subtitle-1 font-weight-black">酒の強さ</h3>
                  <div>{{ userAlcoholStrongness }}</div>
                </div>
                <v-divider />
              </div>
              <div v-if="authUser.data.attributes.role === 'member'">
                <v-btn class="mb-6" x-large @click.stop="displayProfileEditDialog">
                  <v-icon class="mr-1">mdi-account-cog</v-icon>
                  編集する
                </v-btn>
                <p class="text-body2">
                  パスワードを変更する場合は
                  <a @click.stop="displayPasswordEditDialog"> こちら </a>
                </p>
              </div>
            </v-sheet>

            <!-- <Calender /> -->
            <!-- プロフィール編集フォーム -->
            <ProfileEditForm
              v-if="editProfileActed"
              v-bind.sync="authUserEdit"
              :isShow.sync="editProfileDialogDisplayed"
              @updateProfiles="updateProfile"
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
        <!-- <v-col>
          <div>My 酒ケジュール</div>
        </v-col> -->
      </v-col>

      <!-- 表、カウントして出す。 -->

      <!-- :events="arrayEvents" -->
      <!-- <v-date-picker v-model="date2" @click.stop="dialog = true"></v-date-picker> -->
      <div justify="center" align-content="center">
        <h3
          class="text-h6 font-weight-black mb-8 text-center outer-layer"
          style="background-color: rgb(255, 255, 255, 0.7)"
        >
          My 酒ケジュール
          <!-- この欄はツイッター共有することができる -->
          <!-- お気に入りにしたものをここに表示させる -->
        </h3>
        <v-col class="d-flex justify-space-between mb-6 shuchedule">
          <v-card
            v-for="(item, index) in shucheduleData"
            :key="index"
            class="text-center mx-auto my-5 form outer-layer"
            elevation="2"
            shaped
            id="form"
            :disabled="showShucheduleAll"
          >
            <v-card-title style="width: 100%" class="headline justify-center">
              <v-icon>{{ item.alcohol_percentage === 0 ? 'mdi-cup' : 'mdi-glass-mug' }}</v-icon>
              {{ item.name }}
            </v-card-title>
            <v-row justify="center">
              <v-row justify="center" align-content="center">
                <p>度数: {{ item.alcohol_percentage }}%</p>
                <p>量: {{ item.alcohol_amount }} ml</p>
              </v-row>
            </v-row>
          </v-card>
        </v-col>
      </div>
      <div justify="center" align-content="center">
        <h3
          class="text-h6 font-weight-black mb-8 text-center outer-layer"
          style="background-color: rgb(255, 255, 255, 0.7)"
        >
          過去の酒ケジュール
        </h3>
        <v-col
          v-for="(specificData, index) in shucheduleData"
          :key="index"
          class="justify-space-between mb-6 shuchedule"
          style="background-color: #fff"
        >
          <div
            class="text-center mx-auto my-5 form outer-layer"
            elevation="2"
            shaped
            id="form"
            :disabled="showShucheduleAll"
          >
            <!-- １の時だけ表示する -->
            <!-- {{ date(specificData.created_at) }}の診断です
{{index}} -->
            <v-card-title style="width: 100%" class="headline justify-center">
              <v-icon>{{
                specificData.alcohol_percentage === 0 ? 'mdi-cup' : 'mdi-glass-mug'
              }}</v-icon>
              {{ specificData.name }}
            </v-card-title>
            <v-row justify="center">
              <v-row justify="center" align-content="center">
                <p>度数: {{ specificData.alcohol_percentage }}%</p>
                <p>量: {{ specificData.alcohol_amount }} ml</p>
              </v-row>
            </v-row>
          </div>
        </v-col>
        <!-- <ZerokenButton
          button-name="気分だけ選択"
          class="mb-8 text-center"
          style="background-color: rgb(222, 184, 135)"
          x-large
          @click-response="toOnlyMotivation()"
        >
        </ZerokenButton> -->
      </div>
    </v-row>
  </v-container>
</template>

<script>
import { mapActions, mapGetters } from 'vuex';
import axios from '../plugins/axios';
// import dayjs from '../plugins/dayjs';
import ProfileEditForm from '../components/forms/ProfileEditForm.vue';
import PasswordEditForm from '../components/forms/PasswordEditForm.vue';
export default {
  components: {
    ProfileEditForm,
    PasswordEditForm,
  },
  data() {
    return {
      users: [],
      dataArray: null,
      dialog: false,
      arrayEvents: null,
      analyzeData: {},
      alcoholStrongness: '',
      guestShucheduleList: {},
      alcohols: [],
      date2: new Date(Date.now() - new Date().getTimezoneOffset() * 60000)
        .toISOString()
        .substr(0, 10),
      authUserEdit: {},
      password: '',
      showShucheduleAll: false,
      showPastShuchedule: false,
      showRecentShuchedule: false,
      password_confirmation: '',
      editProfileActed: false,
      editPasswordActed: false,
      editProfileDialogDisplayed: false,
      editPasswordDialogDisplayed: false,
    };
  },
  computed: {
    ...mapGetters('users', ['authUser']),
    ...mapGetters('analyze_result', ['analyze_results']),

    userAlcoholStrongness() {
      console.log(this.alcoholStrongness);
      return this.alcoholStrongness;
    },

    sakeSrc() {
      return require('../src/img/default_profile.png');
    },
    beerSrc() {
      return require('../src/img/beer.svg');
    },
    shucheduleData() {
      //ユーザーが作成した過去のお酒の順番を取得
      return this.alcohols;
    },
    dataAnalyze() {
      //過去に作成したお酒の順番を取得
      return this.alcohols;
    },
    contents() {},
  },
  mounted() {
    // axios.get('/users').then((response) => (this.users = response.data));
  },
  async created() {
    const targetAnalyzeResponse = await this.fetchAnalyzes();
    const targetAnalyzeData = await (this.analyzeData = targetAnalyzeResponse[0]);
    const targetUserResponse = await this.fetchAuthUser();
    const targetUserData = await (this.authUserEdit = targetUserResponse['data']['attributes']);
    axios.get('/alcohols').then((alcoholResponse) => (this.alcohols = alcoholResponse.data));
    targetAnalyzeData;
    this.currentAnalyze();
    targetUserData;
    console.log('targetUserResponse');
    console.log(targetUserResponse);
  },
  methods: {
    ...mapActions('users', ['updateAuthUser']),
    ...mapActions('users', ['fetchAuthUser']),
    ...mapActions('analyze_result', ['fetchAnalyzes']),
    ...mapActions('snackbar', ['fetchSnackbarData']),
    currentAnalyze() {
      //酒豪かどうかを判定
      const targetAlcoholData = this.analyzeData;
      const targetAlcoholStrongness = targetAlcoholData['alcohol_strongness'];
      function checkAlcoholStrongness(target) {
        if (target === 'strong') {
          return '酒豪';
        } else if (target === 'normal_strong') {
          return 'やや酒豪';
        } else if (target === 'normal') {
          return '普通の人';
        } else if (target === 'weak_normal') {
          return 'やや下戸';
        } else if (target === 'weak') {
          return '下戸';
        } else {
          return '未知数';
        }
      }

      const result = checkAlcoholStrongness(targetAlcoholStrongness);
      this.alcoholStrongness = result;
    },
    date(date) {
      return this.$dateFormat(date);
    },
    toOnlyMotivation() {
      this.$router.push({ name: 'SelectNomivation' });
    },
    checkDate(date) {
      const now = new Date();
      const dateTo = now;
      const dateFrom = new Date(date);
      const diffBetweenDate = dateTo - dateFrom;
      return diffBetweenDate;
    },
    isVisiblePastShuchedule() {
      this.isVisibleRecentShuchedule = false;
      this.showPastShuchedule = !this.showPastShuchedule;
    },
    isVisibleRecentShuchedule() {
      this.isVisiblePastShuchedule = false;
      this.showRecentShuchedule = !this.showRecentShuchedule;
    },
    displayProfileEditDialog() {
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
      const updateProfile = {
        nickname: this.authUserEdit['nickname'],
        email: this.authUserEdit['email'],
      };
      let promise = new Promise((resolve, reject) => {
        resolve(this.updateAuthUser(updateProfile));
        reject();
        promise.then((user) => {
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
      });
      return promise;
    },
    updatePassword() {
      axios
        .patch(`profiles/password`, {
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
    async updateProfiles() {
      const updateData = {
        nickname: this.authUserEdit.nickname,
        email: this.authUserEdit.email,
      };
      const updateUserData = await this.updateAuthUser(updateData)
        .then(() => {
          this.handleShowEditProfile();
          this.fetchSnackbarData({
            msg: 'プロフィールを更新しました',
            color: 'success',
            isShow: true,
          });

          this.$router.push({ name: 'UserProfile' });
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
<style scoped>
#izakaya {
  background: url(../src/img/beer.jpeg) center center / cover no-repeat fixed;
  box-sizing: border-box;
}
.content-center {
  display: flex;
  align-items: center;
  justify-content: center;
}
.shuchedule {
  background: url(../src/img/woodtile.jpeg) center center / cover no-repeat fixed;
  box-sizing: border-box;
}
.outer-layer {
  /* padding: 0.5em 1em;
  margin: 2em 0; */
  font-weight: bold;
  border: solid 3px #000; /*線*/
  border-radius: 10px; /*角の丸み*/
}
.row {
  display: contents;
}
.col {
  padding: 0;
  box-sizing: border-box;
}
</style>
