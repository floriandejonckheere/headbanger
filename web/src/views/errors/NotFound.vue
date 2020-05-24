<template>
  <section class="uk-section">
    <div class="uk-container">
      <div class="uk-margin-medium-bottom">
        <h3 class="uk-margin-remove-vertical">Not found</h3>
        <small>Page not found.</small>
      </div>

      <div class="uk-width-1-1">
        <div class="uk-alert-primary" uk-alert>
          <a class="uk-alert-close" uk-close></a>
          <p>
            Uh oh! We couldn't find that.
            <u><a class="uk-link-text" @click="$router.go(-1)">Go back</a></u>
          </p>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
export default {
  name: 'Home',
};
</script>
