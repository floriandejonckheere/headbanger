<template>
  <div v-if="results && results.length === 0" class="uk-width-1-1">
    <div class="uk-alert-primary" uk-alert>
      <a class="uk-alert-close" uk-close></a>
      <p>No results. <u v-if="back"><a class="uk-link-text" @click="$router.go(-1)">Go back</a></u></p>
    </div>
  </div>
</template>

<script>
export default {
  name: 'NoResults',
  props: {
    results: {
      type: Array,
      default: () => [],
    },
    back: Boolean,
  },
};
</script>
