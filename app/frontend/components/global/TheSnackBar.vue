<template>
  <div>
    <v-snackbar
      v-model="isVisible"
      top
      absolute
      timeout="3000"
      :color="snackbarData.color"
      transition="scale-transition"
    >
      <v-icon>{{ snackbarIcon }}</v-icon>
      {{ snackbarData.msg }}
    </v-snackbar>
  </div>
</template>
<script>
import { mapGetters, mapActions } from 'vuex';
export default {
  name: 'TheSnckBar',
  computed: {
    ...mapGetters('snackbar', ['snackbarData']),
    isVisible: {
      get() {
        return this.snackbarData.isShow;
      },
      set() {
        return this.fetchSnackbarData({
          msg: '',
          color: '',
          isShow: false,
        });
      },
    },
    snackbarIcon: function () {
      switch (this.snackbarData.color) {
        case 'success':
          return 'mdi-check-circle-outline';
        case 'error':
          return 'mdi-information-outline';
        default:
          return '';
      }
    },
  },
  methods: {
    ...mapActions('user', ['logoutUser']),
    ...mapActions('snackbar', ['fetchSnackbarData']),
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
