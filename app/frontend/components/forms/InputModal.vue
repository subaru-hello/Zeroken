<template>
  <select :value="value" @change="$emit('input', $event.target.value)">
    <option v-for="(option, index) in options" :key="index" :selected="option === value">
      {{ option }}
    </option>
  </select>
</template>

<script>
export default {
  props: ['options', 'value'],
};
</script>
