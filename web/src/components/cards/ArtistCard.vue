<template>
  <Card v-bind:music="artist">
    <template v-slot:title>
      <router-link to="#" class="uk-link-text">{{ title }}</router-link>
    </template>
    <template v-slot:description>
      {{ description }}
    </template>
  </Card>
</template>

<script>
import { countries } from 'countries-list';

import Card from './Card.vue';

export default {
  name: 'ArtistCard',
  props: {
    artist: Object,
  },
  computed: {
    title() {
      return this.artist.name;
    },
    description() {
      return `Artist from ${countries[this.artist.country].name}`;
    },
  },
  components: {
    Card,
  },
};
</script>
