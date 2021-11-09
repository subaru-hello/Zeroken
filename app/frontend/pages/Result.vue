<template>
  <div>
    <!-- <p>{{ Sake}}</p>
    <p>{{ alcoholsData }}</p> -->
    <h1 class="text-center" style="font-size: 50px">
      あなたは
      <p class="text-center" style="font-size: 50px">
        {{ Sakenotuyosa.sake_strongness_types }} <img :src="beerSrc" width="150" height="100" />
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
              1st.{{ alcoholsData.name }}
            </v-card-title>
            <img :src="beerSrc" width="150" height="100" />
            <v-card-text>{{ alcoholsData.description }}</v-card-text>
          </v-card>
          <v-card class="text-center mx-auto my-5 form" elevation="2" shaped width="500" id="form">
            <v-card-title style="width: 100%" class="headline justify-center">
              2nd.{{ alcoholsD.name }}
            </v-card-title>
            <img :src="sakeSrc" width="150" height="100" />
            <v-card-text>{{ alcoholsD.description }}</v-card-text>
          </v-card>
          <v-card class="text-center mx-auto my-5 form" elevation="2" shaped width="500" id="form">
            <v-card-title style="width: 100%" class="headline justify-center">
              3rd. {{ alcoholsDa.name }}
            </v-card-title>

            <img :src="imgSrc" width="150" height="100" />
            <v-card-text>{{ alcoholsDa.description }}</v-card-text>
          </v-card>
          <v-card class="text-center mx-auto my-5 form" elevation="2" shaped width="500" id="form">
            <v-card-title style="width: 100%" class="headline justify-center">
              4th {{ alcoholsDat.name }}
            </v-card-title>

            <img :src="imgSrc" width="150" height="100" />
            <v-card-text>{{ alcoholsDat.description }}</v-card-text>
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
      alcohols: [],
      analyzes: [],
      users: [],
      errors: '',
    };
  },
  mounted() {
    axios.get('/users').then((userResponse) => (this.users = userResponse.data));
    axios.get('/alcohols').then((alcoholResponse) => (this.alcohols = alcoholResponse.data));
    axios.get('/analyzes').then((analyzeResponse) => (this.analyzes = analyzeResponse.data));
  },
  computed: {
    // ...mapGetters('analyze', ['analyzes']),
    ...mapGetters('users', ['authUser']),
    alcoholsData() {
      const alcoholList = this.alcohols;
      return alcoholList[0];
    },
    alcoholsDat() {
      const alcoholList = this.alcohols;
      return alcoholList[1];
    },
    alcoholsDa() {
      const alcoholList = this.alcohols;
      return alcoholList[2];
    },
    alcoholsD() {
      const alcoholList = this.alcohols;
      return alcoholList[2];
    },
    Sakenotuyosa() {
      const currentAnalyze = this.analyzes;
      const yourAnalyze = currentAnalyze[currentAnalyze.length - 1];
      // if (yourAnalyze === 'weak') {
      //   return '下戸';
      // } else if (yourAnalyze === 'normal') {
      //   return '普通';
      // } else {
      //   return '酒豪';
      // }
      return yourAnalyze;
    },
    //Todo
    //JSONの取得ができていない。sake_strongness_typesの状態に応じて描画内容を変える。
    Sake() {
      const currentAnalyze = this.analyzes[0];
      // const yourAnalyze = currentAnalyze["sake_strongness_types"];
      //    if (currentAnalyze[currentAnalyze.length -1] === 'flesh') {
      //   return 'しっぽり';
      // } else if (currentAnalyze[currentAnalyze.length -1]=== 'tipsy') {
      //   return 'ほろ酔い';
      // } else {
      //   return '酩酊';
      // }
      return currentAnalyze;
      // return yourAnalyze;
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
    this.fetchAuthUser();
  },
  methods: {
    ...mapActions('analyze', ['createAnalyze']),
    ...mapActions('users', ['fetchAuthUser']),
  },
};
</script>

<style scoped></style>
