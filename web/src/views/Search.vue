<template>
  <section class="uk-section">
    <div class="uk-container">
      <ul class="uk-breadcrumb uk-margin-small-bottom">
        <li><span>Search</span></li>
      </ul>
      <div class="uk-margin-medium-bottom">
        <h3 class="uk-margin-remove-vertical">Find your favourite music</h3>
        <small>Search for artists, groups and releases</small>
      </div>

      <Search />
    </div>
  </section>
</template>

<script>
import Search from '@/components/search/Search.vue';

export default {
  name: 'Discover',
  components: {
    Search,
  },
};
</script>
