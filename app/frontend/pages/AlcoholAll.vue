<template>
  <v-container>
    <table>
      <th>name</th>
      <th>desctiption</th>
      <th>index</th>
      <tr v-for="(content, index) in contents" :key="content.id">
        <td>{{ index + 1 }}</td>
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
      return targetValues;
    },
  },
  created() {},
  mounted() {
    axios.get('/alcohols').then((alcoholResponse) => (this.alcoholAll = alcoholResponse.data));
  },
  methods: {},
};
</script>
