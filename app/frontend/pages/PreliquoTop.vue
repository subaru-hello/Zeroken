<template>
  <div>
    <p>酒ジュールを提供します</p>
    <div v-if="!!authUser">ログインしています</div>
    <p>{{ authUser }}</p>
  </div>
</template>

<script>
import { mapActions, mapGetters } from 'vuex';
export default {
  name: 'PreliquoTop',
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
    ...mapActions('users', ['fetchAuthUser']),
  },
};
</script>
