<template>
  <v-btn
    @click="clicked"
    x-large
    style="background-color: rgb(222, 184, 135); font-size: 20px"
    :disabled="isVisible"
  >
    <slot></slot>
    {{ buttonName }}
  </v-btn>
</template>
<script>
export default {
  props: {
    isVisible: {
      type: Boolean,
    },
    buttonName: {
      type: String,
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
