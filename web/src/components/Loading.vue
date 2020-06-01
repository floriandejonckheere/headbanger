<template>
  <div v-if="loading" class="uk-text-center uk-width-1-1">
    <div uk-spinner key="loading" />
  </div>
</template>

<script>
export default {
  name: 'NoResults',
  props: {
    loading: Boolean,
  },
};
</script>
