<template>
  <Card v-bind:music="group">
    <template v-slot:title>
      <router-link to="#" class="uk-link-text">{{ group.name }}</router-link>
    </template>
    <template v-slot:description>
      <span v-for="(genre, index) in group.genres" v-bind:key="genre.id">
        <router-link :to="{ name: 'genre', params: { id: genre.id } }">{{ genre.description }}</router-link>
        <span v-if="index + 1 < group.genres.length"> / </span>
      </span>
      from {{ country }}
    </template>
  </Card>
</template>

<script>
import { countries } from 'countries-list';

import Card from './Card.vue';

export default {
  name: 'GroupCard',
  props: {
    group: Object,
  },
  computed: {
    country() {
      return countries[this.group.country].name;
    },
  },
  components: {
    Card,
  },
};
</script>
