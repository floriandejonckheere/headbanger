<template>
  <section class="uk-section">
    <div class="uk-container">
      <div class="uk-grid uk-child-width-1-3@s uk-flex-center">
        <div class="uk-card uk-card-small uk-padding-small uk-card-default uk-box-shadow-small uk-background-default">
          <div class="uk-card-header">
            <h3 class="uk-margin-remove-vertical">Sign in</h3>
            <small>Please sign in to continue</small>
          </div>
          <div class="uk-card-body">
            <form>
              <div class="uk-margin">
                <input class="uk-input uk-form-blank" type="email" placeholder="Email" required>
              </div>

              <div class="uk-margin">
                <input class="uk-input uk-form-blank" type="password" placeholder="Password" required>
              </div>
            </form>
          </div>
          <div class="uk-card-footer uk-flex uk-flex-column">
            <div class="uk-margin-small">
              <button class="uk-button uk-button-primary">Sign in</button>
            </div>
          </div>
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
