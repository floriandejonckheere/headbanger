<template>
  <div class="uk-card uk-card-default uk-box-shadow-small uk-background-default">
    <router-link :to="{ path: 'genre', params: { id: genre.id } }">
      <div class="uk-inline-clip uk-transition-toggle">
        <img
          class="uk-transition-scale-up uk-transition-opaque"
          src="https://ia601209.us.archive.org/25/items/mbid-a86017c0-09d9-4edd-81d3-767ac56ed3ff/mbid-a86017c0-09d9-4edd-81d3-767ac56ed3ff-14459102581_thumb500.jpg" alt=""
        >
        <div class="uk-overlay-primary uk-position-cover"></div>
        <div class="uk-overlay uk-position-bottom uk-light">
          <h5 class="uk-link" v-text="genre.description"></h5>
      </div>
    </div>
    </router-link>
  </div>
</template>

<script>
export default {
  name: 'GenreCard',
  props: {
    genre: Object,
  },
};
</script>
