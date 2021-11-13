<template>
  <div id="profile-form" class="container w-50 text-center">
    <v-container fluid>
      <v-row>
        <v-col cols="12" sm="6">
          <v-row class="d-flex justify-center">
            <v-col cols="12" sm="8" class="pt-16">
              <v-sheet id="profile-sheet" class="py-6 px-10 text-center" elevation="1">
                <h3 class="text-h6 font-weight-black mb-8">マイプロフィール</h3>
                <v-avatar class="or-avatar mb-5" size="200">
                  <img :src="user.avatar" />
                </v-avatar>
                <div class="text-left mb-6">
                  <div>
                    <h3 class="text-subtitle-1 font-weight-black">ニックネーム</h3>
                    <div>{{ user.nickname }}</div>
                  </div>
                  <v-divider class="mb-6" />
                  <div>
                    <h3 class="text-subtitle-1 font-weight-black">メールアドレス</h3>
                    <div>{{ user.email }}</div>
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
            </v-col>
          </v-row>
        </v-col>
      </v-row>
      <div>{{ whuAreYou }}</div>
    </v-container>
    <div class="h3 mb-3">プロフィール</div>
    <ValidationObserver v-slot="{ handleSubmit }">
      <div class="form-group text-left">
        <ValidationProvider v-slot="{ errors }" rules="required">
          <label for="name">ユーザー名</label>
          <input
            id="name"
            v-model="user.name"
            name="ユーザー名"
            type="text"
            class="form-control"
            placeholder="username"
          />
          <span class="text-danger">{{ errors[0] }}</span>
        </ValidationProvider>
      </div>
      <div class="form-group text-left">
        <!-- eslint-disable vue/no-unused-vars -->
        <ValidationProvider
          v-slot="{ errors }"
          ref="provider"
          name="プロフィール画像"
          rules="image"
        >
          <label for="avatar" class="d-block">プロフィール画像</label>
          <img :src="user.avatar" class="my-3" width="150px" />
          <v-file-input
            id="avatar"
            type="file"
            accept="image/png,image/jpeg"
            class="form-control-file"
            @change="handleChange"
          ></v-file-input>
          <span class="text-danger">{{ errors[0] }}</span>
        </ValidationProvider>
      </div>
      <button type="submit" class="btn btn-primary" @click="handleSubmit(update)">更新</button>
    </ValidationObserver>
  </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex';

export default {
  name: 'ProfileIndex',
  data() {
    return {
      user: {
        nickname: '',
        avatar: '',
      },
      uploadAvatar: '',
    };
  },
  computed: {
    ...mapGetters('users', ['authUser']),
  },
  created() {
    this.user = Object.assign({}, this.authUser);
  },
  methods: {
    ...mapActions('users', ['updateAuthUser']), // 選択された画像をdataに保存する。
    async handleChange(event) {
      const { valid } = await this.$refs.provider.validate(event);
      if (valid) this.uploadAvatar = event.target.file[0];
    }, // textなどの単純なデータと違い画像などのバイナリーファイルは
    // FormDataを使わなければサーバーに送ることができない。
    update() {
      const formData = new FormData();
      formData.append('user[nickname]', this.user.nickname);
      if (this.uploadAvatar) formData.append('user[avatar]', this.uploadAvatar);

      try {
        this.updateAuthUser(formData);
        this.$router.push({ name: 'PreliquoTop' });
      } catch (error) {
        console.log(error);
      }
    },
  },
};
</script>

<style scoped></style>
