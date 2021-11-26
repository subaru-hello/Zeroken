<template>
  <div>
    <v-footer style="background-color: rgb(222 184 135)">
      <v-row justify="center" no-gutters>
        <v-btn v-for="link in links" :key="link" color="white" text rounded class="my-2">
          {{ link }}
        </v-btn>
      </v-row>
    </v-footer>
  </div>
</template>
<script>
export default {
  name: 'TheFooter',
  data() {
    return {
      links: ['ZEROKENについて', '利用規約', 'お問い合わせ'],
    };
  },
};
</script>
