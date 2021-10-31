<template>
  <table>
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
  </table>
</template>

<script>
import axios from '../plugins/axios';
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
  mounted() {
    axios.get('analyzes').then((response) => (this.analyze = response.data));
  },
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
  },
  methods: {
    createAnalyze: function () {
      axios
        .post('/api/v1/analyzes', this.analyze)
        .then((response) => {
          response.data;
        })
        .catch((error) => {
          console.error(error);
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
        });
    },
  },
};
</script>

<style scoped></style>
