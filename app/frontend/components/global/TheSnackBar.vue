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
export default{
    name: 'TheSnckBar',
    computed: {
        ...mapGetters('snackbar', ['snackbarData']),
        //snackbar.jsのgettersに描かれたsnackbarDataをmapGettersで呼び出している。
        isVisible:{
            get(){
                return this.snackbarData.isShow;
            },
            set(){
                return this.fetchSnackbarData({
                    msg: '',
                    color: '',
                    isShow: false,
                });

            },
        },
        snackbarIcon: function(){
            switch(this.snackbarData.color){
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
        //mapActionsでsnackbar.jsのfetchSnackBarDataを呼び出している
    logoutFunction() {
        //新しくlogoutFunctionを定義
      this.logoutUser().then((res) => {
        //user.jsにあるlogoutUserを呼び出す
        if (res) {
        //成功した場合
         this.$router.go({ path: this.$router.currentRoute.path });
        //一個前のページに戻る。$router.goでひとつ前に戻る役割を果たしている　
         this.fetchSnackbarData({
        //fetchSnackBarDataを呼び出している。
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
