<template>
  <div>
    <p>{{ Sake }}</p>
    <h1 class="text-center" style="font-size: 50px">
      あなたは
      <p class="text-center" style="font-size: 50px">
        {{ Sakenotuyosa }} <img :src="beerSrc" width="150" height="100" />
      </p>
      酩酊に向けた酒ケジュール
    </h1>
    <v-layout>
      <v-card class="text-center mx-auto my-5 form" elevation="2" shaped width="5000" id="form">
        <v-card-title style="width: 100%" class="headline justify-center">
          酒ケジュール
        </v-card-title>
        <v-container class="d-flex flex-row mb-6">
          <v-card class="text-center mx-auto my-5 form" elevation="2" shaped width="500" id="form">
            <v-card-title style="width: 100%" class="headline justify-center">
              1st.ビール
            </v-card-title>
            <img :src="beerSrc" width="150" height="100" />
          </v-card>
          <v-card class="text-center mx-auto my-5 form" elevation="2" shaped width="500" id="form">
            <v-card-title style="width: 100%" class="headline justify-center">
              2nd. 日本酒
            </v-card-title>
            <img :src="sakeSrc" width="150" height="100" />
          </v-card>
          <v-card class="text-center mx-auto my-5 form" elevation="2" shaped width="500" id="form">
            <v-card-title style="width: 100%" class="headline justify-center">
              3rd. ハイボール
            </v-card-title>

            <img :src="imgSrc" width="150" height="100" />
          </v-card>
          <v-card class="text-center mx-auto my-5 form" elevation="2" shaped width="500" id="form">
            <v-card-title style="width: 100%" class="headline justify-center">
              4th ハイボール
            </v-card-title>

            <img :src="imgSrc" width="150" height="100" />
          </v-card>
        </v-container>
      </v-card>
    </v-layout>
  </div>
</template>

<script>
import { mapActions, mapGetters } from 'vuex';
import axios from '../plugins/axios';
export default {
  data: function () {
    return {
      analyzes: [],
      users: [],
      errors: '',
    };
  },
  mounted() {
    axios.get('/users').then((userResponse) => (this.users = userResponse.data));
    axios.get('/analyzes').then((analyzeResponse) => (this.analyzes = analyzeResponse.data));
  },
  computed: {
    // ...mapGetters('analyze', ['analyzes']),
    ...mapGetters('users', ['authUser']),
    Sakenotuyosa() {
      const currentAnalyze = this.analyzes;
      const yourAnalyze = currentAnalyze[currentAnalyze.length - 1];
      if (yourAnalyze === 'weak') {
        return '下戸';
      } else if (yourAnalyze === 'normal') {
        return '普通';
      } else {
        return '酒豪';
      }
    },
    Sake() {
      const currentAnalyze = this.analyzes;
      //    if (currentAnalyze[currentAnalyze.length -1] === 'weak') {
      //   return '下戸';
      // } else if (currentAnalyze[currentAnalyze.length -1]=== 'normal') {
      //   return '普通';
      // } else {
      //   return '酒豪';
      // }
      return currentAnalyze[0];
    },
    imgSrc() {
      return require('../src/img/liquor.svg');
    },
    sakeSrc() {
      return require('../src/img/sake.svg');
    },
    drinkSrc() {
      return require('../src/img/drink.svg');
    },
    beerSrc() {
      return require('../src/img/beer.svg');
    },
  },
  created() {
    this.fetchAnalyzes();
    this.fetchAuthUser();
  },
  methods: {
    ...mapActions('analyze', ['fetchAnalyzes']),
    ...mapActions('analyze', ['createAnalyze']),
    ...mapActions('users', ['fetchAuthUser']),
  },
};
</script>

<style scoped></style>
