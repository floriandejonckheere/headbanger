<template>
  <p>You are being signed out</p>
</template>

<script>
import { mapMutations } from 'vuex';

import { onLogout } from '@/vue-apollo';

export default {
  name: 'Signout',
  methods: {
    ...mapMutations(['signout']),
  },
  mounted() {
    // Set state
    this.signout();

    // Set token in local storage
    onLogout(this.$apolloProvider.defaultClient);

    // Redirect to sign in
    this.$router.push({ name: 'signin' });
  },
};
</script>
