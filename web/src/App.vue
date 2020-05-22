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
import './App.scss';
import Header from '@/components/Header.vue';
import Footer from '@/components/Footer.vue';

export default {
  components: {
    Header,
    Footer,
  },
};
</script>
