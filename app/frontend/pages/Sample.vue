<template>
  <div>
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

    <!-- <table>
    <tbody>
      <tr>
        <th>TotalPoints</th>
        <th>次の飲み会への気分</th>
        <th>お酒の強さ</th>
      </tr>
      <tr v-for="a in analyze" :key="a.id">
        <td>{{ a.total_points }}</td>
        <td>{{ a.drunk_types }}</td>
        <td>{{ a.resistance_types }}</td>
        <td>{{ Sakenotuyosa }}</td>
        <td>{{ sumTotalPoints }}</td>
      </tr>
    </tbody>
  </table> -->
  </div>
</template>

<script>
import { mapActions } from 'vuex';
export default {
  data: function () {
    return {
      analyze: {
        total_points: '',
        drunk_types: '',
        resistance_types: '',
      },
      errors: '',
    };
  },
  mounted() {},
  computed: {
    Sakenotuyosa() {
      if (this.analyze.total_points > 0) {
        return '下戸';
      } else if (this.analyze.total_points === 0) {
        return '普通';
      } else {
        return '酒豪';
      }
    },
    sumTotalPoints() {
      return this.analyze.total_points;
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
  methods: {
    ...mapActions(['fetchAnalyze']),
    ...mapActions(['createAnalyze']),

    onSubmit(e) {
      e.preventDefault();
      this.createAnalyze(this.analyze);
    },
    // createAnalyze: function () {
    //   axios
    //     .post('/analyzes', this.analyze)
    //     .then((response) => {
    //       response.data;
    //     })
    //     .catch((error) => {
    //       console.error(error);
    //       if (error.response.data && error.response.data.errors) {
    //         this.errors = error.response.data.errors;
    //       }
    //     });
    // },
  },
  created() {
    this.fetchAnalyze;
  },
};
</script>

<style scoped></style>
