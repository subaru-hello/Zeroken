<template>
  <v-dialog :value="isShow" width="650px" @click:outside="closeDialog">
    <v-sheet id="profile-edit-form" class="pa-10">
      <div class="text-center mb-5">
        <v-avatar class="or-avatar mb-5" size="200">
          <img :src="sakeSrc" width="150" height="100" />
        </v-avatar>
      </div>
      <!-- <div>
          <v-btn @click="actionInputFile">プロフィール画像を変更</v-btn>
        </div>
      
      <ValidationProvider
        ref="fileForm"
        v-slot="{ errors }"
        name="プロフィール画像"
        mode="change"
        :rules="formRules.avatar"
      >
        <v-file-input
          id="user-avatar"
          style="display: none"
          accept="image/jpg, image/jpeg, image/png, image/gif"
          @change="handleAvatarChange"
        />
        <v-alert :value="fileErrorDisplayed" type="error" dense outlined :icon="false">
          {{ errors[0] }}
        </v-alert>
      </ValidationProvider> -->
      <ValidationObserver v-slot="{ handleSubmit }" class="pb-6" tag="div" ref="inputText">
        <ValidationProvider
          v-slot="{ errors }"
          name="ニックネーム"
          mode="blur"
          :rules="formRules.nickname"
        >
          <v-text-field
            id="user-nickname"
            label="ニックネーム"
            type="text"
            :error-messages="errors"
            :value="nickname"
            @input="$emit('update:nickname', $event)"
          />
        </ValidationProvider>
        <ValidationProvider
          v-slot="{ errors }"
          name="メールアドレス"
          mode="blur"
          :rules="formRules.email"
        >
          <v-text-field
            id="user-email"
            class="mb-6"
            label="メールアドレス"
            type="email"
            :error-messages="errors"
            :value="email"
            @input="$emit('update:email', $event)"
          />
        </ValidationProvider>
        <div class="d-flex justify-center">
          <v-btn
            class="mx-4"
            x-large
            style="color: white"
            color="red accent-2"
            @click="handleSubmit(handleUpdateProfiles())"
          >
            更新する
          </v-btn>
          <v-btn class="mx-4" xLarge @click="closeDialog">戻る</v-btn>
        </div>
      </ValidationObserver>
      <p class="text-body2 text-center">
        パスワードを変更する場合は
        <a @click="changeDialog"> こちら </a>
      </p>
    </v-sheet>
  </v-dialog>
</template>

<script>
import axios from '../../plugins/axios';
export default {
  props: {
    id: {
      type: Number,
      //   required: true,
    },
    nickname: {
      type: String,
      //   required: true,
    },
    email: {
      type: String,
      //   required: true,
    },
    avatar: {
      type: String,
      //   required: true,
    },
    isShow: {
      type: Boolean,
    },
  },
  data() {
    return {
      formRules: {
        nickname: { isUnique: ['nickname', this.id], max: 10 },
        email: { email: true, isUnique: ['email', this.id], max: 50 },
        avatar: { size: 10000, ext: ['jpg', 'jpeg', 'png', 'gif'] },
      },
      fileErrorDisplayed: false,
    };
  },
  computed: {
    sakeSrc() {
      return require('../../src/img/default_profile.png');
    },
  },
  methods: {
    handleUpdateProfiles() {
      this.$emit('updateProfiles');
    },
    actionInputFile() {
      document.querySelector('#user-avatar').click();
    },
    handleUpdateProfile() {
      this.hideErrorMessage();
      this.$emit('updateProfile');
    },
    changeDialog() {
      this.hideErrorMessage();
      this.$emit('changeDialog');
    },
    closeDialog() {
      this.hideErrorMessage();
      this.$emit('closeDialog');
    },
    hideErrorMessage() {
      this.$refs.inputText.reset();
      this.fileErrorDisplayed = false;
    },
  },
};
</script>
