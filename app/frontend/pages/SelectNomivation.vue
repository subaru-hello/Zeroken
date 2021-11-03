<template>
  <v-container>
    <v-row justify="center" align-content="center">
      <v-col cols="12" xs="12" sm="12" md="12" lg="12">
        <table>
          <tbody>
            <tr>
              <th>あなたのお酒の強さ</th>
            </tr>
            <tr>
              <td>{{ Sakenotuyosa }}</td>
            </tr>
          </tbody>
        </table>
        <h1 class="text-center" style="font-size: 50px">
          次の飲み会ではどのくらい酔う予定ですか？
        </h1>
      </v-col>
      <router-link class="router-link" :to="{ name: 'Sample' }">
        <v-col justify="center" class="nomivation" align-content="center">
          <p style="font-size: 32px; text-decoration: none; text-color: black">酩酊</p>
          <img :src="imgSrc" width="150" height="100" />
        </v-col>
      </router-link>
      <router-link class="router-link" :to="{ name: 'Sample' }">
        <v-col justify="center" class="nomivation" align-content="center">
          <p style="font-size: 32px; text-decoration: none; text-color: black">ほろ酔い</p>
          <img :src="sakeSrc" width="150" height="100" />
        </v-col>
      </router-link>
      <router-link class="router-link" :to="{ name: 'Sample' }">
        <v-col justify="center" class="nomivation" align-content="center">
          <p style="font-size: 32px; text-decoration: none; text-color: black">しっぽり</p>
          <img :src="drinkSrc" width="150" height="100" />
        </v-col>
      </router-link>
    </v-row>
  </v-container>
</template>

<script>
import { mapGetters, mapActions } from 'vuex';
export default {
  name: 'SelectNomivation',
  data: function () {
    return {};
  },
  methods: {
    Sakenotuyosa() {
      const yourSakeStrongness = this.analyzes.total_points;
      if (yourSakeStrongness > 0) {
        return '下戸';
      } else if (yourSakeStrongness === 0) {
        return '普通';
      } else {
        return '酒豪';
      }
    },
  },
  computed: {
    ...mapActions('analyze', ['fetchAnalyzes']),
    ...mapGetters('analyze', ['analyzes']),
    imgSrc() {
      return require('../src/img/liquor.svg');
    },
    sakeSrc() {
      return require('../src/img/sake.svg');
    },
    drinkSrc() {
      return require('../src/img/drink.svg');
    },
  },
  created() {
    this.fetchAnalyzes;
  },
};
</script>
<style scoped>
a:link {
  font-weight: bold;
  color: black;
  text-decoration: none;
}
</style>
