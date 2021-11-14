<template>
  <v-dialog :value="dialog" max-width="630">
    <v-card>
      <v-card-title class="headline grey lighten-2 d-flex justify-center">
        <span style="color: #d32f2f">ZEROKEN</span>へようこそ
      </v-card-title>
      <v-card-text class="text-no-wrap text-sm-h5 text-body-2 text-center pa-8">
        ゼロケンへ登録してくれてありがとう！<br />
        さっそく「酒ケジュール」を作っちゃおう！
      </v-card-text>
      <v-card-actions class="d-flex justify-space-around pb-8">
        <v-btn style="color: white" class="deep-orange lighten-2" x-large :to="{ name: 'Analyze' }">
          酒ジュール診断ページへ
        </v-btn>
        <v-btn x-large @click.stop="$emit('close-dialog')"> あとで </v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>

<script>
export default {
  props: {
    dialog: {
      type: Boolean,
    },
  },
};
</script>
