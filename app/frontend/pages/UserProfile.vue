<template>
  <v-container fluid class="mt-4 pt-21" style="box-sizing: border-box; padding: 0">
    <v-row>
      <v-col>
        <v-row class="content-center">
          <v-col :color="$vuetify.theme.dark ? 'grey darken-3' : 'grey lighten-4'" flat tile>
            <v-sheet id="profile-sheet" class="text-center outer-layer" elevation="1">
              <h3 class="text-h6 font-weight-black">酒テータス</h3>
              <p class="text-center black--text" style="font-size: 30px">
                {{ currentAnalyze }}
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
                  <div>{{ currentAnalyze }}</div>
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
          過去の酒ケジュール
        </h3>
        <v-col
          v-for="(data, index) in dataAnalyze"
          :key="index"
          class="d-flex justify-space-between mb-6"
        >
          <v-col
            v-for="(specificData, index) in data"
            :key="index"
            class="justify-space-between mb-6 shuchedule"
            style="background-color: #fff"
          >
            <!-- 7日以前の診断 -->
            <!-- <div v-if="showShucheduleAll"> -->
            <!-- <div v-if="index === 0">{{ date(specificData.created_at) }}の診断です</div> -->
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
    ...mapGetters('analyze', ['analyzes']),
    currentAnalyze() {
      const thisAnalyze = this.analyzes;
      const targetAnalyze = thisAnalyze[thisAnalyze.length - 1];
      const targetAlcoholStrongness = targetAnalyze['alcohol_strongness'];
      function checkAlcoholStrongness(target) {
        if (target === 'strong') {
          return '酒豪';
        } else if (target === 'weak') {
          return '下戸';
        } else if (target === 'normal') {
          return '普通の人';
        } else if (target === 'normal_strong') {
          return 'やや酒豪';
        } else {
          return 'やや下戸';
        }
      }

      const result = checkAlcoholStrongness(targetAlcoholStrongness);
      return result;
    },

    sakeSrc() {
      return require('../src/img/default_profile.png');
    },
    beerSrc() {
      return require('../src/img/beer.svg');
    },
    userAnalyze() {
      const thisAnalyze = this.analyzes;

      const targetValues = this.alcohols;
      function createSake(targetAnalyze) {
        const shucheduleHash = [];

        for (let i = 0; i < targetAnalyze.length; i++) {
          const shucheduleAll = thisAnalyze[i]['shuchedule'];
          shucheduleHash.push(shucheduleAll);
        }
        return shucheduleHash;
      }

      //B: Aで取得したshucheduleの値を元に、alcohol配列からデータを取得している。this.alcohols[2]で配列にあるお酒のデータを取得することができる
      function createShuchedule(sake) {
        const alchol_case = [];

        for (let i = 0; i < sake.length; i++) {
          const arrayAnalyzeShuchedule = createSake(thisAnalyze); //先程取得したshucheduleの値を繰り返し処理で取得する。その後、contentsOfTargetの後ろにつける。
          //arrayAnalyzeShucheduleには[12,18]が入っているarrayAnalyzeShuchedule[i]をalcholsに入れる。
          const shucheduleAll = arrayAnalyzeShuchedule[i];
          //12,18を取り出した。
          const contentsOfTarget = Object.values(targetValues)[shucheduleAll];
          //  alcohol_12,alcohols_18を取り出すことができた。
          alchol_case.push(contentsOfTarget);
        }
        return alchol_case;
        //alcohol_12,alcohols_18が入っている。
      }
      const alcoholOrders = createShuchedule(createSake(thisAnalyze));
      return alcoholOrders;
    },
    dataAnalyze() {
      const thisAnalyze = this.analyzes;

      const targetValues = this.alcohols;
      function createSake(targetAnalyze) {
        const shucheduleHash = [];

        for (let i = 0; i < targetAnalyze.length; i++) {
          const shucheduleAll = thisAnalyze[i]['shuchedule'];
          shucheduleHash.push(shucheduleAll);
        }
        return shucheduleHash;
      }

      //B: Aで取得したshucheduleの値を元に、alcohol配列からデータを取得している。this.alcohols[2]で配列にあるお酒のデータを取得することができる
      function createShuchedule(sake) {
        const alchol_case = [];

        for (let i = 0; i < sake.length; i++) {
          const arrayAnalyzeShuchedule = createSake(thisAnalyze); //先程取得したshucheduleの値を繰り返し処理で取得する。その後、contentsOfTargetの後ろにつける。
          //arrayAnalyzeShucheduleには[12,18]が入っているarrayAnalyzeShuchedule[i]をalcholsに入れる。
          const shucheduleAll = arrayAnalyzeShuchedule[i];
          //12,18を取り出した。
          const contentsOfTarget = Object.values(targetValues)[shucheduleAll];
          //  alcohol_12,alcohols_18を取り出すことができた。
          alchol_case.push(contentsOfTarget);
        }
        return alchol_case;
        //alcohol_12,alcohols_18が入っている。
      }

      let a = createSake(thisAnalyze);
      let b = createShuchedule(a);
      function all() {
        let sake_case = {};
        for (let i = 0; i < b.length; i++) {
          let json_key = `alcohols_${i}`;
          sake_case[json_key] = b[i];
        }
        // debugger;
        return sake_case;
      }

      let c = all();
      return c;
    },
    contents() {
      const thisAnalyze = this.analyzes;

      const analyzeShuchedule = thisAnalyze[thisAnalyze.length - 1]['shuchedule'];

      const targetValues = this.alcohols;

      const contentsOfTarget = Object.values(targetValues)[analyzeShuchedule];

      return contentsOfTarget;
    },
  },
  mounted() {
    axios.get('/users').then((response) => (this.users = response.data));
  },
  created() {
    this.fetchAnalyzes();
    this.fetchAuthUser();
    axios.get('/alcohols').then((alcoholResponse) => (this.alcohols = alcoholResponse.data));
    // 決められた日を持ってくる
    const authUserData = {
      nickname: this.authUser.data.attributes.nickname,
      email: this.authUser.data.attributes.email,
      password: this.authUser.data.attributes.password,
      password_confirmation: this.authUser.data.attributes.password_confirmation,
      avatar: this.authUser.data.attributes.avatar,
    };
    this.authUserEdit = authUserData;
  },
  methods: {
    ...mapActions('users', ['updateAuthUser']),
    ...mapActions('users', ['fetchAuthUser']),
    ...mapActions('analyze', ['fetchAnalyzes']),
    ...mapActions('snackbar', ['fetchSnackbarData']),
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

      // const diffBetweenDate = dateTo.diff(dateFrom, 'day');
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
