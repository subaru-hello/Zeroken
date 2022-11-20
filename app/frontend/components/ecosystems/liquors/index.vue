<template>
  <v-container class="grey lighten-5">
    <v-row
      :justify="space-between"
    >
      <v-col
        v-for="num_col in 6"
        :key= num_col
        md="4"
      >
      <LiquorCard 
        liquorName='ビール'
      />
      </v-col>
    </v-row>
  </v-container>
</template>
<script>

import LiquorCard from '../.././organisms/liquors/LiquorCard';
export default {
  components: {
  LiquorCard,
    }
  }
</script>

