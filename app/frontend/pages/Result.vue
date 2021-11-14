<template>
  <div>
    <div class="text-center" style="font-size: 50px">
      <p>あなたの酒テータス</p>
      <v-card>
        <h1
          class="centered"
          v-if="analyzes[analyzes.length - 1]['sake_strongness_types'] === 'strong'"
        >
          {{ $t('analyzes.sake_strongness_types.strong') }}
        </h1>
        <h1
          class="centered"
          v-else-if="analyzes[analyzes.length - 1]['sake_strongness_types'] === 'normal'"
        >
          { {{ $t('analyzes.sake_strongness_types.normal') }}
        </h1>
        <h1 class="centered" v-else>{{ $t('analyzes.sake_strongness_types.weak') }}</h1>

        <img :src="beerSrc" width="150" height="100" />
        <v-card-subtitle style="font-size: 26px">
          {{ $t(analyzes[analyzes.length - 1]['description']) }}のようですね。</v-card-subtitle
        >
        <p v-if="analyzes[analyzes.length - 1]['next_nomivation_types'] === 'flesh'">
          {{ $t('analyzes.next_nomivation_types.flesh') }} になりたいあなたへ
        </p>
        <p v-else-if="analyzes[analyzes.length - 1]['next_nomivation_types'] === 'tipsy'">
          {{ $t('analyzes.next_nomivation_types.tipsy') }} になりたいあなたへ
        </p>
        <p v-else>{{ $t('analyzes.next_nomivation_types.heavy_drunk') }} になりたいあなたへ</p>
      </v-card>
    </div>
    <v-btn
      lass="centered"
      :to="{ name: 'Analyze' }"
      style="color: bleck"
      text
      rounded
      plain
      x-large
    >
      もう一回酒ケジュールを作成する
    </v-btn>
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

  computed: {
    ...mapGetters('analyze', ['analyzes']),
    ...mapGetters('users', ['authUser']),
    currentUsersSakeStrongness() {
      const thisAnalyze = this.analyzes;
      const targetSakeStrongness = thisAnalyze[thisAnalyze.length - 1]['sake_strongness_types'];
      const SakeType =
        targetSakeStrongness === 'strong'
          ? '酒豪'
          : targetSakeStrongness === 'weak'
          ? '下戸'
          : '普通';
      return SakeType;
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
  mounted() {
    axios.get('/alcohols').then((alcoholResponse) => (this.alcohols = alcoholResponse.data));
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
