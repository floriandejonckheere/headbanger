<template>
  <div id="app">
    <Header />

    <main>
      <router-view/>
    </main>

    <Footer />
  </div>
</template>

<script>
import Header from '@/components/Header.vue';
import Footer from '@/components/Footer.vue';

export default {
  components: {
    Header,
    Footer,
  },
};
</script>

<style lang="scss">
  @import "~uikit/src/scss/variables.scss";

  html,
  body {
    height: 100%;
  }

  #app {
    font-family: Poppins, Avenir, Helvetica, Arial, sans-serif;
    font-weight: 300;
    background: $global-muted-background;

    min-height: 100%;

    display: flex;
    flex-direction: column;

    main {
      flex-grow: 1;
    }
  }
</style>
