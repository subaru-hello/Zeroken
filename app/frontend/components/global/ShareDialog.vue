<template>
  <v-dialog v-model="dialog" width="400">
    <template v-slot:activator="{ on }">
      <v-btn
        v-on="on"
        x-large
        class="white--text"
        style="background-color: rgb(0, 0, 0, 0.6); border-radius: 20%"
      >
        シェアする
      </v-btn>
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
            <v-icon color="#1da1f2"> mdi-twitter </v-icon>
          </v-list-item-action>
          <v-btn :href="sns.twitter" target="_blank">{{ Twitter }} </v-btn>
        </v-list-item>
      </v-list>
    </v-card>
  </v-dialog>
</template>
<script>
import { defineComponent } from '@vue/composition-api';

export default defineComponent({
  setup() {},
});
</script>
