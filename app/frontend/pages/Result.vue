<template>
  <div>
    <div class="text-center" style="font-size: 50px">
      <p>あなたの酒テータス</p>
      <v-card>
        酒の強さ:
        <v-card-title class="mx-auto" style="font-size: 50px">
          {{ analyzes[analyzes.length - 1]['sake_strongness_types'] }}
          <img :src="beerSrc" width="150" height="100" />
        </v-card-title>
        <v-card-subtitle style="font-size: 26px">
          {{ analyzes[analyzes.length - 1]['description'] }}のようです。</v-card-subtitle
        >
      </v-card>
      <p>{{ analyzes[analyzes.length - 1]['next_nomivation_types'] }} になりたいあなたへ</p>
    </div>
    <!-- <v-btn class="justify-center"> 結果を保存する</v-btn> -->
    <v-layout>
      <v-card class="text-center mx-auto my-5 form" elevation="2" shaped width="5000" id="form">
        <v-card-title style="width: 100%" class="headline justify-center">
          酒ケジュール
        </v-card-title>
        <v-container
          class="d-flex flex-row mb-6"
          v-if="analyzes[analyzes.length - 1]['sake_strongness_types'] === 'strong'"
        >
          <v-card
            class="text-center mx-auto my-5 form"
            elevation="2"
            shaped
            width="500"
            id="form"
            v-for="data in alcohols"
            :key="data.id"
          >
            <v-card-title style="width: 100%" class="headline justify-center">
              {{ data[3].name }}　
            </v-card-title>
            <img :src="beerSrc" width="150" height="100" />
            <v-card-text>
              {{ data[3].description }}
            </v-card-text>
          </v-card>
        </v-container>
        <v-container
          class="d-flex flex-row mb-6"
          v-if="analyzes[analyzes.length - 1]['sake_strongness_types'] === 'normal'"
        >
          <v-card
            class="text-center mx-auto my-5 form"
            elevation="2"
            shaped
            width="500"
            id="form"
            v-for="data in alcohols"
            :key="data.id"
          >
            <v-card-title style="width: 100%" class="headline justify-center">
              {{ data[1].name }}　
            </v-card-title>
            <img :src="beerSrc" width="150" height="100" />
            <v-card-text>
              {{ data[1].description }}
            </v-card-text>
          </v-card>
        </v-container>
        <v-container
          class="d-flex flex-row mb-6"
          v-if="analyzes[analyzes.length - 1]['sake_strongness_types'] === 'weak'"
        >
          <v-card
            class="text-center mx-auto my-5 form"
            elevation="2"
            shaped
            width="500"
            id="form"
            v-for="data in alcohols"
            :key="data.id"
          >
            <v-card-title style="width: 100%" class="headline justify-center">
              {{ data[0].name }}　
            </v-card-title>
            <img :src="beerSrc" width="150" height="100" />
            <v-card-text>
              {{ data[0].description }}
            </v-card-text>
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
      analyze: [],
      users: [],
      errors: '',
    };
  },
  mounted() {
    axios.get('/alcohols').then((alcoholResponse) => (this.alcohols = alcoholResponse.data));
  },
  computed: {
    ...mapGetters('analyze', ['analyzes']),
    ...mapGetters('users', ['authUser']),
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
  updated() {},
  created() {
    this.fetchAnalyzes();
    this.fetchAuthUser();
    this.analyze = this.fetchAnalyzes;
  },
  methods: {
    ...mapActions('analyze', ['fetchAnalyzes']),
    ...mapActions('users', ['fetchAuthUser']),
  },
};
</script>

<style scoped></style>
