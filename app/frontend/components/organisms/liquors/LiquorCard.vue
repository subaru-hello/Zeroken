<template>
  <v-card :loading="loading" class="mx-auto my-12" maxWidth="374">
    <template slot="progress">
      <v-progress-linear color="deep-purple" height="10" indeterminate></v-progress-linear>
    </template>

    <v-img height="250" src="https://cdn.vuetifyjs.com/images/cards/cooking.png"></v-img>

    <v-card-title>{{ liquorName }}</v-card-title>

    <v-card-text>
      <v-row align="center" class="mx-0">
        <v-rating :value="4.5" color="amber" dense halfIncrements readonly size="14"></v-rating>

        <div class="grey--text ms-4">4.5 (413)</div>
      </v-row>

      <div class="my-4 text-subtitle-1">$ • Italian, Cafe</div>

      <div>
        Small plates, salads & sandwiches - an intimate setting with 12 indoor seats plus patio
        seating.
      </div>
    </v-card-text>
  </v-card>
</template>

<script>
export default {
  props: {
    liquorName: {
      type: String,
    },
  },
};
</script>
