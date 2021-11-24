<template>
  <v-container>
    <table>
      <th>name</th>
      <th>desctiption</th>
      <tr v-for="content in contents" :key="content.id">
        <td>
          <p>{{ content.name }}</p>
        </td>
        <td>
          <p>{{ content.description }}</p>
        </td>
      </tr>
    </table>
  </v-container>
</template>
<script>
import axios from '../plugins/axios';
export default {
  data() {
    return {
      alcoholAll: [],
    };
  },
  computed: {
    contents() {
      let targetValues = this.alcoholAll;
      let contentsOfTarget = Object.values(targetValues)[0];
      return contentsOfTarget;
    },
  },
  created() {},
  mounted() {
    axios.get('/alcohols').then((alcoholResponse) => (this.alcoholAll = alcoholResponse.data));
  },
  methods: {},
};
</script>
