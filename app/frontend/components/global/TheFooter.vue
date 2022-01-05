<template>
  <div>
    <v-footer style="background-color: rgb(222 184 135)">
      <v-row justify="center" no-gutters>
        <v-btn
          v-for="(link, index) in links"
          :key="index"
          color="white"
          text
          rounded
          class="my-2"
          @click="getCreateUrl(link.url)"
          justify="center"
          align-content="center"
          target="_blank"
          rel="noopener noreferrer"
        >
          {{ link.name }}
        </v-btn>
      </v-row>
      <v-dialog v-model="dialog" scrollable max-width="80%">
        <v-card>
          <v-card-title>作成中です。</v-card-title>
          <v-divider></v-divider>
          <v-card-text
            >大変申し訳ありません。作者が二日酔いのため作成が遅れております。しばしお待ちください。。
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
      links: [
        { url: 'About', name: 'ZEROKENについて' },
        { url: 'Term', name: '利用規約' },
        { url: 'form', name: 'お問い合わせ' },
        { url: 'PrivacyPolicy', name: 'プライバシーポリシー' },
        { url: 'About', name: '©︎2021 ZEROKEN' },
      ],
    };
  },

  methods: {
    getCreateUrl(url) {
      if (url === 'form') {
        location.href =
          'https://docs.google.com/forms/d/e/1FAIpQLScURhhJBZqiyYYH_aHtugvtk18vzw67vACnACgqPQRayjqbDQ/viewform?usp=sf_link';
      } else if (url === 'About') {
        this.dialog = true;
      } else {
        this.$router.push({ name: `${url}` });
      }
    },
  },
};
</script>
<style scoped>
.v-footer {
  width: 100%;
  bottom: 0;
}
</style>
