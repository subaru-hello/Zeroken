<template>
  <div>
    <v-footer style="background-color: rgb(222 184 135)">
      <v-row justify="center" no-gutters>
        <v-btn v-for="link in links" 
        :key="link"
        color="white" 
        text rounded class="my-2"  
        justify="center"
        align-content="center"
        @click="dialog = true">
          {{ link }}
        </v-btn>
      </v-row>
          <v-dialog v-model="dialog" scrollable max-width="80%">
            <v-card>
              <v-card-title>作成中です。</v-card-title>
              <v-divider></v-divider>
              <v-card-text>大変申し訳ありません。作者が二日酔いのため作成が遅れております。しばしお待ちください。。
              </v-card-text>
            </v-card>
          </v-dialog>
    </v-footer>
  </div>
</template>
<script>
export default {
  name: 'TheFooter',
  data() {
    return {
      dialog: false,
      links: ['ZEROKENについて', '利用規約', 'お問い合わせ'],
    };
  },
};
</script>
