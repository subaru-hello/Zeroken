<template>
  <v-app id="app">
    <TheHeader />
    <v-main>
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
/* @media screen and (min-width: 650px) {
  .br-pc {
    display: block;
  }
  .br-sp {
    display: none;
  }
}
@media screen and (max-width: 650px) {
  .br-pc {
    display: none;
  }
  .br-sp {
    display: block;
  }
} */
.router-link {
  text-decoration: none;
}
.or-avatar {
  border: solid;
}
</style>
