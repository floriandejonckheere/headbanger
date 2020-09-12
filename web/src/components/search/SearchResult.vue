<template>
  <router-link to="/">
    <component :is="icon" />
    <span class="uk-padding-small">
      {{ result.name }}
      <small class="uk-text-muted">{{ result.__typename.toLowerCase() }}</small>
    </span>
  </router-link>
</template>

<script>
export default {
  name: 'SearchResult',
  props: {
    result: Object,
  },
  computed: {
    icon() {
      return {
        Artist: 'ios-person-icon',
        Group: 'ios-people-icon',
        Release: 'ios-disc-icon',
      }[this.result.__typename];
    },
  },
};
</script>
