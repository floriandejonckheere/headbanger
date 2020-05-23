<template>
  <Card :rating="release.rating">
    <template v-slot:title>
      <router-link to="#" class="uk-link-text">{{ release.name }}</router-link>
    </template>
    <template v-slot:description>
      By <router-link to="#">{{ description }}</router-link>
    </template>
  </Card>
</template>

<script>
import Card from './Card.vue';

export default {
  name: 'ReleaseCard',
  props: {
    release: Object,
  },
  computed: {
    description() {
      return this.release.artists[0].name;
    },
  },
  components: {
    Card,
  },
};
</script>
