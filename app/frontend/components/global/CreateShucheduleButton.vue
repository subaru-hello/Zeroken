<template>
  <v-btn
    @click="clicked"
    x-large
    style="background-color: rgb(222, 184, 135); font-size: 20px"
    :disabled="isVisible"
  >
    酒ケジュールを作成する
  </v-btn>
</template>
<script>
export default {
  props: {
    isVisible: {
      type: Boolean,
    },
  },
  data() {
    return {};
  },
  methods: {
    clicked() {
      return this.$emit('click-response');
    },
  },
};
</script>
