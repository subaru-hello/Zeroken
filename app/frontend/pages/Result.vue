<template>
  <div>
    <v-layout>
      <v-card class="text-center mx-auto my-5 form" elevation="2" shaped width="5000" id="form">
        <p v-if="analyzes[analyzes.length - 1]['next_nomivation_types'] === 'flesh'">
          {{ $t('analyzes.next_nomivation_types.flesh') }} になりたいあなたに向けた
        </p>
        <p v-else-if="analyzes[analyzes.length - 1]['next_nomivation_types'] === 'tipsy'">
          {{ $t('analyzes.next_nomivation_types.tipsy') }} になりたいあなたに向けた
        </p>
        <p v-else>
          {{ $t('analyzes.next_nomivation_types.heavy_drunk') }} になりたいあなたに向けた
        </p>

        <v-card-title style="width: 100%" class="headline justify-center">
          <h1 class="centered">酒ケジュール</h1>
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
    <div class="text-center" style="font-size: 50px">
      <v-card>
        <p>あなたの酒テータス</p>
        <div
          class="centered"
          v-if="analyzes[analyzes.length - 1]['sake_strongness_types'] === 'strong'"
        >
          <v-row justify="center" align-content="center">
            <star-rating :rating="4" :show-rating="false" read-only class="mx-auto"></star-rating>
          </v-row>
          <h1>
            {{ $t('analyzes.sake_strongness_types.strong') }}
          </h1>
          <p>GG型</p>
        </div>

        <div
          class="centered"
          v-else-if="analyzes[analyzes.length - 1]['sake_strongness_types'] === 'normal'"
        >
          <v-row justify="center" align-content="center">
            <star-rating :rating="3" :show-rating="false" read-only class="mx-auto"></star-rating>
          </v-row>
          <h1>
            {{ $t('analyzes.sake_strongness_types.normal') }}
          </h1>

          <p>AG型</p>
        </div>
        <div class="centered" v-else>
          <v-row justify="center" align-content="center">
            <star-rating :rating="2" :show-rating="false" read-only class="mx-auto"></star-rating>
          </v-row>
          <h1>
            {{ $t('analyzes.sake_strongness_types.weak') }}
          </h1>
          <p>GG型</p>
        </div>

        <img :src="beerSrc" width="150" height="100" />
        <v-card-subtitle style="font-size: 26px">
          {{ analyzes[analyzes.length - 1]['description'] }}
        </v-card-subtitle>

        <v-row justify="center" align-content="center">
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
          <v-dialog v-model="dialog" width="400">
            <template v-slot:activator="{ on }">
              <v-icon v-on="on"> mdi-share-variant </v-icon>
            </template>
            <v-card>
              <v-card-title>
                <span class="text-h6 font-weight-bold">Share</span>
                <v-spacer></v-spacer>
                <v-btn class="mx-0" icon @click="dialog = false">
                  <v-icon>mdi-close-circle-outline</v-icon>
                </v-btn>
              </v-card-title>
              <v-list>
                <v-list-item>
                  <v-list-item-action>
                    <v-icon color="indigo"> mdi-facebook </v-icon>
                  </v-list-item-action>
                  <v-card-title>Facebook</v-card-title>
                </v-list-item>
                <v-list-item>
                  <v-list-item-action>
                    <v-icon color="cyan"> mdi-twitter </v-icon>
                  </v-list-item-action>
                  <v-card-title>Twitter</v-card-title>
                </v-list-item>
                <v-list-item>
                  <v-list-item-action>
                    <v-icon>mdi-email</v-icon>
                  </v-list-item-action>
                  <v-card-title>Email</v-card-title>
                </v-list-item>
              </v-list>
            </v-card>
          </v-dialog>
        </v-row>
      </v-card>
    </div>

    <!-- <v-btn class="justify-center"> 結果を保存する</v-btn> -->
  </div>
</template>

<script>
import { mapActions, mapGetters } from 'vuex';
import StarRating from 'vue-star-rating';
import axios from '../plugins/axios';
export default {
  components: {
    StarRating,
  },
  data: function () {
    return {
      alcohols: [],
      analyze: [],
      users: [],
      errors: '',
      dialog: false,
      rating: [],
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
