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
                class="uk-input uk-form-blank hb-header-search hb-header-search"
                type="text"
                placeholder="Search music...">
            </div>
          </div>
          <div class="uk-navbar-right">
            <ul class="uk-navbar-nav">
              <li class="uk-active"><a href="#">Home</a></li>
              <li><a href="#">Discover</a></li>
              <li><a href="#">Explore</a></li>
            </ul>
          </div>
        </div>
      </div>
    </nav>
  </header>
</template>

<script>
import './Header.scss';

export default {
  name: 'Header',
};
</script>
