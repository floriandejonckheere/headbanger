<template>
  <router-link to="/">
    <ion-icon :name="`${icon}-outline`" />
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
        Artist: 'person',
        Group: 'people',
        Release: 'disc',
      }[this.result.__typename];
    },
  },
};
</script>
