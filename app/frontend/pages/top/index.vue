<template>
<v-app>
  <v-btn class="elevation='2'">
    <router-link to="/tasks" class="btn btn-dark mt-5">診断する</router-link>
  </v-btn>
  <v-btn class="elevation='2'">
    <router-link to="/register" class="btn btn-dark mt-5">ユーザー登録をする</router-link>
  </v-btn>
  </v-app>
</template>
<script>
export default {
  name: 'TopIndex',
};
</script>

<style scoped></style>
