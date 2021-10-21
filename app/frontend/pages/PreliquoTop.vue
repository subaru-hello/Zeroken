<template>
  <v-container style="max-width: 1030px; margin: 0 auto">
    <v-col>
      <v-row justify="center" align-content="center">
        <v-col cols="12" xs="12" sm="12" md="12" lg="12">
          <h1 class="text-center" style="font-size: 20px">アルハラを予防する</h1>
          <h1 class="text-center" style="font-size: 50px">Preliquo</h1>
        </v-col>
        <v-col v-for="item in items" :key="item.title" cols="12" xs="12" sm="8" md="4" lg="4">
          <v-card class="mx-auto" light>
            <v-card-text>
              <p class="text-center" style="font-size: 25px">
                {{ item.title }}
              </p>
              <!-- <hr>
            <v-img
              :src="item.img"
              width="100%"
              max-width="100%"
              class="white--text align-top"
              height="auto"
            /> -->
            </v-card-text>
          </v-card>
        </v-col>
      </v-row>
    </v-col>
  </v-container>
</template>

<script>
import { mapActions, mapGetters } from 'vuex';
export default {
  name: 'PreliquoTop',
  data() {
    return {
      items: [
        {
          title: '飲み会の前にお酒の強さを診断',
          //   img: require('@/assets/images/liquor.svg') ,
        },

        {
          title: '飲み会で飲むお酒の順番を提供',
          // img: require('@/assets/images/liquor.svg'),
        },
        {
          title: '不本意なアルハラを予防します',
          //  img: require('@/assets/images/liquor.svg'),
        },
      ],
    };
  },
  created() {
    this.fetchAuthUser();
  },
  computed: {
    ...mapGetters('users', ['authUser']),
  },
  methods: {
    ...mapActions('users', ['fetchAuthUser']),
  },
};
</script>
