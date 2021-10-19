<template>
     <div>
         <p>酒ジュールを提供します</p>
         <div v-if="!!authUser">
             ログインしています</div>
         <v-btn color="error" @click="logoutUser">ログアウト</v-btn>
         <p>{{ authUser }}</p>
     </div>
</template>  


<script>
import { mapActions, mapGetters } from 'vuex';
export default {
  data() {
    return {};
  },
  created() {
    this.fetchAuthUser();
  },
  computed: {
    ...mapGetters('users', ['authUser']),
  },
  methods: {
    ...mapActions('users', ['fetchAuthUser', 'logoutUser']),
  },
};
</script>
