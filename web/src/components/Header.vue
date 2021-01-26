<template>
  <header>
    <nav class="uk-background-default uk-box-shadow-small">
      <div class="uk-container">
        <div class="uk-navbar">
          <div class="uk-navbar-left">
            <router-link :to="{ name: 'home' }" class="uk-navbar-item uk-logo">
              Headbanger
            </router-link>
          </div>
          <div class="uk-navbar-center uk-visible@m">
            <SearchBar v-if="this.$route.name !== 'search'" />
          </div>
          <div class="uk-navbar-right">
            <ul class="uk-navbar-nav" uk-navbar="mode: click">
              <template v-if="isAuthenticated">
                <router-link :to="{ name: 'discover' }" v-slot="{ navigate }" custom><li @click="navigate" @keypress.enter="navigate"><a href="#">Discover</a></li></router-link>
                <router-link :to="{ name: 'browse' }" v-slot="{ navigate }" custom><li @click="navigate" @keypress.enter="navigate"><a href="#">Browse</a></li></router-link>
                <li>
                  <a href="#">
                    {{ authenticatable.name }}
                    <ios-arrow-down-icon class="uk-text-middle uk-padding-small" />
                  </a>
                  <div class="uk-navbar-dropdown uk-background-default uk-box-shadow-small" uk-toggle>
                    <ul class="uk-nav uk-navbar-dropdown-nav">
                      <router-link :to="{ name: 'account' }" v-slot="{ navigate }" custom><li @click="navigate" @keypress.enter="navigate"><a href="#">My account</a></li></router-link>
                      <li class="uk-nav-divider uk-margin-small"></li>
                      <router-link :to="{ name: 'signout' }" v-slot="{ navigate }" custom><li @click="navigate" @keypress.enter="navigate"><a href="#">Sign out</a></li></router-link>
                    </ul>
                  </div>
                </li>
              </template>
              <template v-else>
                <router-link :to="{ name: 'signup' }" v-slot="{ navigate }" custom><li @click="navigate" @keypress.enter="navigate"><a href="#">Signup</a></li></router-link>
                <router-link :to="{ name: 'signin' }" v-slot="{ navigate }" custom><li @click="navigate" @keypress.enter="navigate"><a href="#">Signin</a></li></router-link>
              </template>
            </ul>
          </div>
        </div>
      </div>
    </nav>
  </header>
</template>

<script>
import { mapGetters, mapState } from 'vuex';

import SearchBar from '@/components/search/SearchBar.vue';

export default {
  name: 'Header',
  components: {
    SearchBar,
  },
  computed: {
    ...mapGetters([
      'isAuthenticated',
    ]),
    ...mapState([
      'authenticatable',
    ]),
  },
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
