<template>
  <v-container>
    <v-row justify="center" align-content="center">
      <v-col cols="12" xs="12" sm="12" md="12" lg="12">
        <h1 class="text-center" style="font-size: 50px">
          次の飲み会ではどのくらい酔う予定ですか？
        </h1>
      </v-col>
      <v-col justify="center" align-content="center">
        <img :src="imgSrc" width="150" height="100" />
        <p>酩酊</p>
      </v-col>
      <v-col justify="center" align-content="center">
        <img :src="imgSrc" width="150" height="100" />
        <p>ほろ酔い</p>
      </v-col>
      <v-col justify="center" align-content="center">
        <img :src="imgSrc" width="150" height="100" />
        <p>しっぽり</p>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
// import { alcohol  } from '../const/alcohol';
// import { alcoholable  } from '../const/alcoholable';
export default {
  name: 'SelectNomivation',
  data: function () {
    return {
      analyzes: [],
    };
  },
  created() {
    this.fetchAnalyzes();
  },
  methods: {
    fetchAnalyzes() {
      this.$axios
        .get('analyzes')
        .then((res) => (this.tasks = res.data))
        .catch((err) => console.log(err.status));
    },
  },
  computed: {
    imgSrc() {
      return require('../src/img/liquor.svg');
    },
  },
};
</script>
