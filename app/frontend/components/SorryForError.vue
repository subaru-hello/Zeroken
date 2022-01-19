<template>
  <v-dialog :value="dialog" max-width="630">
    <v-card>
      <v-card-title class="headline grey lighten-2 d-flex justify-center" >
      大変申し訳ありません。
      </v-card-title>
      <v-card-text class="text-no-wrap text-sm-h5 text-body-2 text-center pa-8">
        現在、診断にエラーが見つかった影響で、<br />
        サービスが使えない状況になっております。<br />
        復旧は1/25 10:00を予定しております。<br />
        本当に申し訳ありません。<br />
      </v-card-text>
      <v-card-actions class="d-flex justify-space-around pb-8">
        <v-btn style="color: white" class="deep-orange lighten-2" x-large :to="{ name: 'Phrases' }">
          用語集ページへ
        </v-btn>
        <v-btn style="background-color: rgb(0, 60, 80)" x-large @click.stop="$emit('close-dialog')">    <img :src="imgSrc" class="text-center" width="100" /> </v-btn>
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
  computed:{
     imgSrc() {
      return require('../src/img/zeroken-logo_4.png');
    },
  }
};
</script>
