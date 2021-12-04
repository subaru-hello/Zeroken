<template>
  <v-container fluid>
    <!-- <div v-for="(analyze, index) in userAnalyze" :key="index">
      <p v-for="(nestedAnalyze, index) in analyze" :key="index">
        {{ nestedAnalyze.created_at }}
      </p>
    </div> -->
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
              <!-- <v-btn class="mb-6" x-large @click.stop="displayProfileEditDialog">
                <v-icon class="mr-1">mdi-account-cog</v-icon>
                編集する
              </v-btn>
              <p class="text-body2">
                パスワードを変更する場合は
                <a @click.stop="displayPasswordEditDialog"> こちら </a>
              </p> -->
            </v-sheet>

            <!-- <Calender /> -->
            <div style="margin-left: 10%">
              <h3 class="text-h6 font-weight-black mb-8 mx-auto text-center">過去の酒ケジュール</h3>

              <v-date-picker
                v-model="date2"
                :events="arrayEvents"
                full-width
                @click.stop="dialog = true"
              ></v-date-picker>

              <div justify="center" align-content="center">
                <v-col
                  cols="12"
                  sm="3"
                  v-for="(data, index) in dataAnalyze"
                  :key="index"
                  class="d-flex justify-space-between mb-6"
                >
                
                  <p>酒ケジュール</p>
                  <v-col
                    cols="12"
                    v-for="(specificData, index) in data"
                    :key="index"
                    class="d-flex justify-space-between mb-6"
                  >
                    <div>
                      <v-card class="text-center mx-auto my-5 form" elevation="2" shaped id="form">
                        {{ date(specificData.created_at) }}

                        <v-card-title style="width: 100%" class="headline justify-center">
                          {{ specificData.name }}
                        </v-card-title>
                        <v-row justify="center">
                          <img :src="beerSrc" width="150" height="100" />
                          <v-row justify="center" align-content="center">
                            <p>度数: {{ specificData.alcohol_percentage }}%</p>
                            <p>量: {{ specificData.alcohol_amount }} ml</p>
                          </v-row>
                        </v-row>
                      </v-card>
                    </div>
                  </v-col>
                </v-col>
              </div>
              <!-- </v-row> -->
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
  </v-container>
</template>

<script>
import { mapActions, mapGetters } from 'vuex';
import axios from '../plugins/axios';
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
    // this.dataArray  = this.copyAnalyze()
    //:events = "arrayEvents"になっている。1~6までの数字を配列内に代入している
    this.arrayEvents = [...Array(6)].map(() => {
      // const targetData = this.analyzes
      const day = Math.floor(Math.random() * 30);
      const d = new Date();
      d.setDate(day);
      // debugger
      return d.toISOString().substr(0, 10);
    });
  },
  created() {
    this.fetchAnalyzes();
    this.fetchAuthUser();

    axios.get('/alcohols').then((alcoholResponse) => (this.alcohols = alcoholResponse.data));

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
    ...mapActions('analyze', ['fetchAnalyzes']),
    ...mapActions('snackbar', ['fetchSnackbarData']),
    date(date) {
      return this.$dateFormat(date);
    },

    functionEvents(date) {
      const [, , day] = date.split('-');
      if ([12, 17, 28].includes(parseInt(day, 10))) return true;
      if ([1, 19, 22].includes(parseInt(day, 10))) return ['red', '#00f'];
      return false;
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
