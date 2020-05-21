<template>
  <header>
    <nav class="uk-navbar-container">
      <div class="uk-container">
        <div class="uk-navbar">
          <div class="uk-navbar-left">
            <router-link to="/" class="uk-navbar-item uk-logo">
              Headbanger
            </router-link>
          </div>
          <div class="uk-navbar-center">
            <ul class="uk-navbar-nav">
              <li class="uk-active"><a href="#">Home</a></li>
              <li><a href="#">Discover</a></li>
              <li><a href="#">Explore</a></li>
            </ul>
          </div>
          <div class="uk-navbar-right">
            <div>
              <a class="uk-navbar-toggle" uk-search-icon href="#"></a>
              <div class="uk-drop" uk-drop="mode: click; pos: left-center; offset: 0">
                <form class="uk-search uk-search-navbar uk-width-1-1">
                  <input class="uk-search-input" type="search" placeholder="Search for images"
                         autofocus>
                </form>
              </div>
            </div>
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
