<template>
  <v-app id="app">
    <TheHeader />
    <v-main class="mt-12 izakaya">
      <TheSnackBar />
      <router-view />
    </v-main>
    <TheFooter />
  </v-app>
</template>
<script>
import TheFooter from './components/global/TheFooter';
import TheHeader from './components/global/TheHeader';
import TheSnackBar from './components/global/TheSnackBar';
export default {
  components: {
    TheHeader,
    TheFooter,
    TheSnackBar,
  },
};
</script>

<style>
.izakaya {
  background: url(./src/img/beer.jpeg) center center / cover no-repeat fixed;
}

.router-link {
  text-decoration: none;
}
.or-avatar {
  border: solid;
}
</style>
