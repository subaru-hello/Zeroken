<template>
  <div v-if="isVisibleRegisterModal">
    <div class="modal-over">
      <v-card class="modal">
        <UserRegisterForm v-bind.sync="user" @create-user="registerFunction" />
        <h6>ユーザー登録をするとこんないいことが</h6>
      </v-card>
      <div @click="closeCertificate" class="close">閉じる</div>
    </div>
  </div>
</template>
<script>
import { mapActions } from 'vuex';
import UserRegisterForm from '../forms/UserRegisterForm.vue';
export default {
  props: {
    isVisibleRegisterModal: {
      type: Boolean,
    },
  },
  components: {
    UserRegisterForm,
  },
  data() {
    return {
      user: {
        nickname: '',
        email: '',
        password: '',
        password_confirmation: '',
      },
    };
  },
  methods: {
    ...mapActions('users', ['registerUser']),
    ...mapActions('snackbar', ['fetchSnackbarData']),
    registerFunction() {
      this.registerUser(this.user).then((user) => {
        if (user) {
          this.fetchSnackbarData({
            msg: '新規登録に成功しました',
            color: 'success',
            isShow: true,
          });
          this.$router.push({ name: 'ZerokenTop' });
        } else {
          this.fetchSnackbarData({
            msg: '新規登録に失敗しました',
            color: 'error',
            isShow: true,
          });
        }
      });
    },
    ChildButton() {
      this.$emit('register-response');
    },
    closeCertificate() {
      this.isVisibleRegisterModal = !this.isVisibleRegisterModal;
    },
  },
};
</script>
<style scoped>
.modal-over {
  position: fixed;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  display: flex;
  justify-content: center;

  background-color: #000000da;
}

.modal {
  text-align: center;
  background-color: white;
  height: 500px;
  width: 500px;
  z-index: 1;
  margin-top: 10%;
  padding: 60px 0;
  border-radius: 20px;
}
.close {
  margin: 10% 0 0 16px;
  cursor: pointer;
}

.close-img {
  width: 25px;
}

.check {
  width: 150px;
}

h6 {
  font-weight: 500;
  font-size: 28px;
  margin: 20px 0;
}

p {
  font-size: 16px;
  margin: 20px 0;
}

button {
  background-color: #ac003e;
  width: 150px;
  height: 40px;
  color: white;
  font-size: 14px;
  border-radius: 16px;
  margin-top: 50px;
}
</style>
