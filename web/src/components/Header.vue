<template>
  <header>
    <nav class="uk-navbar-container uk-navbar-transparent uk-background-default uk-box-shadow-small">
      <div class="uk-container">
        <div class="uk-navbar">
          <div class="uk-navbar-left">
            <router-link to="/" class="uk-navbar-item uk-logo">
              Headbanger
            </router-link>
          </div>
          <div class="uk-navbar-center">
            <div class="uk-inline">
              <span class="uk-form-icon uk-form-icon-flip" uk-icon="icon: search"></span>
              <input
                class="uk-input uk-form-blank"
                type="text"
                placeholder="Search music...">
            </div>
          </div>
          <div class="uk-navbar-right">
            <ul class="uk-navbar-nav">
              <router-link to="/discover" tag="li"><a href="#">Discover</a></router-link>
              <router-link to="/browse" tag="li"><a href="#">Browse</a></router-link>
            </ul>
          </div>
        </div>
      </div>
    </nav>
  </header>
</template>

<script>
export default {
  name: 'Header',
};
</script>

<style lang="scss">
  @import "~styles/theme/variables";

  .uk-logo {
    font-family: 'Pacifico', sans-serif;
    font-size: 1.8em;
    color: $global-link-color;

    &:hover,
    &:focus {
      color: $global-link-hover-color;
    }
  }

  // Force default font
  .uk-navbar-nav > li > a {
   font-family: Poppins, Avenir, Helvetica, Arial, sans-serif;
   font-weight: 400;
  }
</style>
