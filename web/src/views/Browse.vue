<template>
  <section class="uk-section">
    <div class="uk-container">
      <ul class="uk-breadcrumb uk-margin-small-bottom">
        <li><span>Browse</span></li>
      </ul>
      <h3 class="uk-margin-remove-top">By genre</h3>

      <router-link :to="{ name: 'genres' }">See all</router-link>
    </div>
  </section>
</template>

<script>
export default {
  name: 'Browse',
};
</script>
