<template>
  <div>
    <div class="text-center" style="font-size: 50px">
      <v-col>
        <p>あなたの酒テータス</p>
        <div
          class="centered"
          v-if="analyzes[analyzes.length - 1]['sake_strongness_types'] === 'strong'"
        >
          <v-row justify="center" align-content="center">
            <p>
              {{ $t('analyzes.sake_strongness_types.strong') }}
            </p>
          </v-row>
          <div class="d-flex" justify="center" align-content="center">
            <star-rating :rating="5" :show-rating="false" read-only class="mx-auto"></star-rating>
          </div>
          <v-row justify="center" align-content="center">
            <div class="d-flex">
              <img :src="beerSrc" width="150" height="100" />
            </div>
          </v-row>
        </div>

        <div
          class="centered"
          v-else-if="analyzes[analyzes.length - 1]['sake_strongness_types'] === 'normal'"
        >
          <v-row justify="center" align-content="center">
            <p>
              {{ $t('analyzes.sake_strongness_types.normal') }}
            </p>
          </v-row>

          <div class="d-flex" justify="center" align-content="center">
            <star-rating :rating="3" :show-rating="false" read-only class="mx-auto"></star-rating>
          </div>

          <v-row justify="center" align-content="center">
            <div class="d-flex">
              <img :src="beerSrc" width="150" height="100" />
            </div>
          </v-row>
        </div>
        <div class="centered" v-else>
          <v-row justify="center" align-content="center">
            <p>
              {{ $t('analyzes.sake_strongness_types.weak') }}
            </p>
          </v-row>
          <div class="d-flex" justify="center" align-content="center">
            <star-rating :rating="1" :show-rating="false" read-only class="mx-auto"></star-rating>
          </div>
          <v-row justify="center" align-content="center">
            <div class="d-flex">
              <img :src="beerSrc" width="150" height="100" />
            </div>
          </v-row>
        </div>

        <v-card-subtitle style="font-size: 26px">
          {{ analyzes[analyzes.length - 1]['description'] }}
        </v-card-subtitle>
      </v-col>
    </div>

    <v-layout>
      <v-col class="text-center mx-auto my-5 form" elevation="2" shaped id="form">
        <p v-if="analyzes[analyzes.length - 1]['next_nomivation_types'] === 'flesh'">
          <img :src="fleshSrc" width="150" height="100" />
        </p>
        <p v-else-if="analyzes[analyzes.length - 1]['next_nomivation_types'] === 'tipsy'">
          <img :src="tipsySrc" width="150" height="100" />
        </p>
        <p v-else>
          <img :src="meiteiSrc" width="150" height="100" />
        </p>
        <v-card-title style="width: 100%" class="headline justify-center">
          <h1 class="centered">酒ケジュール</h1>
        </v-card-title>
        <v-container v-if="analyzes[analyzes.length - 1]['sake_strongness_types'] === 'strong'">
          <v-row justify="center" align-content="center">
            <v-col
              cols="12"
              sm="3"
              class="d-flex"
              width="1000"
              v-for="data in contents"
              :key="data.id"
            >
              <v-card
                class="text-center mx-auto my-5 form"
                elevation="2"
                width="100%"
                shaped
                id="form"
              >
                <v-card-title style="width: 100%" class="headline justify-center">
                  {{ data.name }}
                </v-card-title>
                <v-row justify="center">
                  <!-- <v-img
                    :lazy-src="data.image_url"
                    :src="data.image_url"
                    max-height="150"
                    max-width="100"
                  > -->
                   <img :src="beerSrc" width="150" height="100" />
                    <!-- <template v-slot:placeholder>
                      <v-row class="fill-height ma-0" align="center" justify="center">
                        <v-progress-circular
                          indeterminate
                          color="grey lighten-5"
                        ></v-progress-circular>
                      </v-row>
                    </template>
                  </v-img> -->
                </v-row>

                <!-- <v-card-text>
                  {{ data.description }}
                </v-card-text> -->
                <v-row justify="center" align-content="center" class="d-flex">
                  <p>度数: {{ data.alcohol_percentage }}%</p>
                  <p>量: {{ data.alcohol_amount }}ml</p>
                </v-row>
              </v-card>
            </v-col>
          </v-row>
          <v-row justify="center" align-content="center">
            <p style="font-size: 50px">詳細</p>
            <v-col cols="12" class="d-flex" v-for="data in contents" :key="data.id">
              <v-card
                class="text-center mx-auto my-5 form"
                elevation="2"
                width="100%"
                shaped
                id="form"
              >
                <v-card-title style="width: 100%" class="headline justify-center">
                  {{ data.name }}
                </v-card-title>
               <v-row justify="center">
                  <!-- <v-img
                    :lazy-src="data.image_url"
                    :src="data.image_url"
                    max-height="150"
                    max-width="100"
                  > -->
                   <img :src="beerSrc" width="150" height="100" />
                    <!-- <template v-slot:placeholder>
                      <v-row class="fill-height ma-0" align="center" justify="center">
                        <v-progress-circular
                          indeterminate
                          color="grey lighten-5"
                        ></v-progress-circular>
                      </v-row>
                    </template>
                  </v-img> -->
                </v-row>

                <!-- <v-card-text>
                  {{ data.description }}
                </v-card-text> -->
                <v-row justify="center" align-content="center">
                  <p>度数: {{ data.alcohol_percentage }}%</p>
                  <p>量: {{ data.alcohol_amount }}ml</p>
                </v-row>
                <div>
                  {{ data.description }}
                </div>
              </v-card>
            </v-col>
          </v-row>
        </v-container>
        <v-container v-if="analyzes[analyzes.length - 1]['sake_strongness_types'] === 'normal'">
          <v-row justify="center" align-content="center">
            <v-col cols="12" sm="3" class="d-flex" v-for="data in contents" :key="data.id">
              <v-card
                class="text-center mx-auto my-5 form"
                elevation="2"
                width="100%"
                shaped
                id="form"
              >
                <v-card-title style="width: 100%" class="headline justify-center">
                  {{ data.name }}
                </v-card-title>
                <v-row justify="center">
                  <!-- <v-img
                    :lazy-src="data.image_url"
                    :src="data.image_url"
                    max-height="150"
                    max-width="100"
                  > -->
                   <img :src="beerSrc" width="150" height="100" />
                    <!-- <template v-slot:placeholder>
                      <v-row class="fill-height ma-0" align="center" justify="center">
                        <v-progress-circular
                          indeterminate
                          color="grey lighten-5"
                        ></v-progress-circular>
                      </v-row>
                    </template>
                  </v-img> -->
                </v-row>

                <!-- <v-card-text>
                  {{ data.description }}
                </v-card-text> -->
                <v-row justify="center" align-content="center" class="d-flex">
                  <p>度数: {{ data.alcohol_percentage }}%</p>
                  <p>量: {{ data.alcohol_amount }}ml</p>
                </v-row>
              </v-card>
            </v-col>
          </v-row>
          <v-row justify="center" align-content="center">
            <p style="font-size: 50px">詳細</p>
            <v-col cols="12" class="d-flex" v-for="data in contents" :key="data.id">
              <v-card
                class="text-center mx-auto my-5 form"
                elevation="2"
                width="100%"
                shaped
                id="form"
              >
                <v-card-title style="width: 100%" class="headline justify-center">
                  {{ data.name }}
                </v-card-title>
                <v-row justify="center">
                  <!-- <v-img
                    :lazy-src="data.image_url"
                    :src="data.image_url"
                    max-height="150"
                    max-width="100"
                  > -->
                   <img :src="beerSrc" width="150" height="100" />
                    <!-- <template v-slot:placeholder>
                      <v-row class="fill-height ma-0" align="center" justify="center">
                        <v-progress-circular
                          indeterminate
                          color="grey lighten-5"
                        ></v-progress-circular>
                      </v-row>
                    </template>
                  </v-img> -->
                </v-row>

                <!-- <v-card-text>
                  {{ data.description }}
                </v-card-text> -->
                <v-row justify="center" align-content="center">
                  <p>度数: {{ data.alcohol_percentage }}%</p>
                  <p>量: {{ data.alcohol_amount }}ml</p>
                </v-row>
                <div>
                  {{ data.description }}
                </div>
              </v-card>
            </v-col>
          </v-row>
        </v-container>
        <v-container v-if="analyzes[analyzes.length - 1]['sake_strongness_types'] === 'weak'">
          <v-row justify="center" align-content="center">
            <v-col cols="12" sm="3" class="d-flex" v-for="data in contents" :key="data.id">
              <v-card
                class="text-center mx-auto my-5 form"
                elevation="2"
                width="100%"
                shaped
                id="form"
              >
                <v-card-title style="width: 100%" class="headline justify-center">
                  {{ data.name }}
                </v-card-title>
                  <v-row justify="center">
                  <!-- <v-img
                    :lazy-src="data.image_url"
                    :src="data.image_url"
                    max-height="150"
                    max-width="100"
                  > -->
                   <img :src="beerSrc" width="150" height="100" />
                    <!-- <template v-slot:placeholder>
                      <v-row class="fill-height ma-0" align="center" justify="center">
                        <v-progress-circular
                          indeterminate
                          color="grey lighten-5"
                        ></v-progress-circular>
                      </v-row>
                    </template>
                  </v-img> -->
                </v-row>

                <!-- <v-card-text>
                  {{ data.description }}
                </v-card-text> -->
                <v-row justify="center" align-content="center">
                  <p>度数: {{ data.alcohol_percentage }}%</p>
                  <p>量: {{ data.alcohol_amount }}ml</p>
                </v-row>
              </v-card>
            </v-col>
          </v-row>
          <v-row justify="center" align-content="center">
            <p style="font-size: 50px">詳細</p>
            <v-col cols="12" class="d-flex" v-for="data in contents" :key="data.id">
              <v-card
                class="text-center mx-auto my-5 form"
                elevation="2"
                width="100%"
                shaped
                id="form"
              >
                <v-card-title style="width: 100%" class="headline justify-center">
                  {{ data.name }}
                </v-card-title>
               <v-row justify="center">
                  <!-- <v-img
                    :lazy-src="data.image_url"
                    :src="data.image_url"
                    max-height="150"
                    max-width="100"
                  > -->
                   <img :src="beerSrc" width="150" height="100" />
                    <!-- <template v-slot:placeholder>
                      <v-row class="fill-height ma-0" align="center" justify="center">
                        <v-progress-circular
                          indeterminate
                          color="grey lighten-5"
                        ></v-progress-circular>
                      </v-row>
                    </template>
                  </v-img> -->
                </v-row>

                <!-- <v-card-text>
                  {{ data.description }}
                </v-card-text> -->
                <v-row justify="center" align-content="center">
                  <p>度数: {{ data.alcohol_percentage }}%</p>
                  <p>量: {{ data.alcohol_amount }}ml</p>
                </v-row>
                <div>
                  {{ data.description }}
                </div>
              </v-card>
            </v-col>
          </v-row>
        </v-container>
      </v-col>
    </v-layout>

    <v-row justify="center" align-content="center">
      <v-btn
        lass="centered"
        :to="{ name: 'ZerokenTop' }"
        style="color: bleck"
        text
        rounded
        plain
        x-large
      >
        Topへ戻る
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
                <img
                  :src="imgSrc"
                  width="20"
                  height="20"
                  href="https://timeline.line.me/social-plugin/share?url=https://zeroken.herokuapp.com"
                  target="_blank"
                  rel="noopener noreferrer"
                />
              </v-list-item-action>
              <v-card-title>LINE</v-card-title>
            </v-list-item>
          </v-list>
        </v-card>
      </v-dialog>
    </v-row>
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
      shuche: '',
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
    testAnalyzes() {
      const thisAnalyze = this.analyzes;
      const targetShuchedule = thisAnalyze[thisAnalyze.length - 1];
      return targetShuchedule;
    },
    contents() {
      const thisAnalyze = this.analyzes;

      const analyzeShuchedule = thisAnalyze[thisAnalyze.length - 1]['shuchedule'];

      const targetValues = this.alcohols;

      const contentsOfTarget = Object.values(targetValues)[analyzeShuchedule];

      return contentsOfTarget;
    },
    currentUser() {
      const thisAnalyze = this.analyzes;
      const targetSakeStrongness = thisAnalyze[thisAnalyze.length - 1];
      return targetSakeStrongness;
    },
    imgSrc() {
      return require('../src/img/line.png');
    },
    sakeSrc() {
      return require('../src/img/sake.svg');
    },
    drinkSrc() {
      return require('../src/img/drink.svg');
    },
    ippaiSrc() {
      return require('../src/img/ippai_shuki.png');
    },
    sugusakeSrc() {
      return require('../src/img/sugusake_stamp.png');
    },
    sugumeiteiSrc() {
      return require('../src/img/sugumeitei_stamp.png');
    },
    beerSrc() {
      return require('../src/img/beer.svg');
    },
    meiteiSrc() {
      return require('../src/img/meitei_stamp.png');
    },
    tipsySrc() {
      return require('../src/img/tipsy_stamp.png');
    },
    fleshSrc() {
      return require('../src/img/flesh_stamp.png');
    },
  },
  mounted() {
    axios.get('/alcohols').then((alcoholResponse) => (this.alcohols = alcoholResponse.data));
    this.analyze = this.fetchAnalyzes;
  },
  updated() {},
  created() {
    this.fetchAnalyzes();
    this.fetchAuthUser();
  },
  methods: {
    ...mapActions('analyze', ['fetchAnalyzes']),
    ...mapActions('users', ['fetchAuthUser']),
  },
};
</script>

<style scoped></style>
