<template>
  <v-card>
    <p class="text-h6 pt-8 px-8 text-center font-weight-black">
      <slot></slot>
      {{ registerTitle }}
    </p>
    <ValidationObserver v-slot="{ handleSubmit }">
      <v-card-text>
        <ValidationProvider
          v-slot="{ errors }"
          mode="blur"
          :rules="rules.nickname"
          name="ニックネーム"
        >
          <v-text-field
            id="user-nickname"
            type="text"
            label="ニックネーム"
            :value="nickname"
            :error-messages="errors"
            @input="$emit('update:nickname', $event)"
          />
        </ValidationProvider>
        <ValidationProvider
          v-slot="{ errors }"
          :rules="rules.email"
          mode="blur"
          name="メールアドレス"
        >
          <v-text-field
            id="user-email"
            type="email"
            label="メールアドレス"
            :value="email"
            :error-messages="errors"
            @input="$emit('update:email', $event)"
          />
        </ValidationProvider>
        <ValidationProvider
          v-slot="{ errors }"
          vid="password"
          name="パスワード"
          :rules="rules.password"
        >
          <v-text-field
            id="user-password"
            label="パスワード"
            :value="password"
            :error-messages="errors"
            :append-icon="showPassword ? 'mdi-eye' : 'mdi-eye-off'"
            :type="showPassword ? 'text' : 'password'"
            @click:append="handleShowPassword"
            @input="$emit('update:password', $event)"
          />
        </ValidationProvider>
        <ValidationProvider
          v-slot="{ errors }"
          :rules="rules.confirmation"
          name="パスワード(確認用)"
        >
          <v-text-field
            id="user-confirmation"
            :value="password_confirmation"
            :error-messages="errors"
            :append-icon="showPasswordConfirmation ? 'mdi-eye' : 'mdi-eye-off'"
            :type="showPasswordConfirmation ? 'text' : 'password'"
            label="パスワード(確認用)"
            @click:append="handleShowPasswordConfirmation"
            @input="$emit('update:password_confirmation', $event)"
          />
        </ValidationProvider>
      </v-card-text>
      <v-card-actions class="d-flex justify-center pb-8">
        <v-btn
          class="px-4"
          style="color: white"
          color="red accent-2"
          xLarge
          @click="handleSubmit(handleCreateUser)"
        >
          <v-icon class="mr-1">mdi-email</v-icon>
          メールアドレスで登録
        </v-btn>
      </v-card-actions>
    </ValidationObserver>
  </v-card>
</template>
<script>
export default {
  props: {
    nickname: {
      type: String,
      required: true,
      // default: '',
    },
    email: {
      type: String,
      required: true,
      // default: '',
    },
    password: {
      type: String,
      required: true,
      // default: '',
    },
    password_confirmation: {
      type: String,
      required: true,
      // default: '',
    },
    registerTitle: {
      type: String,
    },
  },
  data() {},
  data() {
    return {
      rules: {
        nickname: { required: true, isUnique: 'nickname', max: 10 },
        email: { required: true, email: true, isUnique: 'email', max: 50 },
        password: { required: true, min: 6, regex: /^[0-9a-zA-Z]+$/i },
        confirmation: { required: true, confirmed: 'password' },
      },
      showPassword: false,
      showPasswordConfirmation: false,
    };
  },
  methods: {
    handleShowPassword() {
      this.showPassword = !this.showPassword;
    },
    handleShowPasswordConfirmation() {
      this.showPasswordConfirmation = !this.showPasswordConfirmation;
    },
    handleCreateUser() {
      this.$emit('create-user');
    },
  },
};
</script>
