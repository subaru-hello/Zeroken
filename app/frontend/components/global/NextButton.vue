<template>
  <v-btn @click="clicked" color="primary" x-large style="font-size: 30px" :disabled="isVisible">
    次へ
  </v-btn>
</template>
<script>
export default {
  props: {
    isVisible: {
      type: Boolean,
      required: true,
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
