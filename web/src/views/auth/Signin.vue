<template>
  <ApolloMutation :mutation="require('@/graphql/mutations/auth/signin.graphql')" @done="onDone">
    <template v-slot="{ mutate, loading, error }">
      <section class="uk-section">
        <div class="uk-container">
          <div class="uk-grid uk-child-width-1-3@s uk-flex-center">
            <div class="uk-card uk-card-small uk-padding-small uk-card-default uk-box-shadow-small uk-background-default">
              <div class="uk-card-header">
                <h3 class="uk-margin-remove-vertical">Sign in</h3>
                <small>Please sign in to continue</small>
              </div>
              <div class="uk-card-body">
                <Error :error="error" />

                <form
                  id="form-signin"
                  @submit.prevent="mutate({ variables: { ...form } })"
                >
                  <div class="uk-margin">
                    <input class="uk-input uk-form-blank" type="email" placeholder="Email" v-model="form.email" required>
                  </div>

                  <div class="uk-margin">
                    <input class="uk-input uk-form-blank" type="password" placeholder="Password" v-model="form.password" required>
                  </div>
                </form>
              </div>
              <div class="uk-card-footer uk-flex uk-flex-column">
                <div class="uk-margin-small">
                  <button
                    type="submit"
                    form="form-signin"
                    class="uk-button uk-button-primary"
                    :disabled="loading"
                  >
                    Sign in
                  </button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>
    </template>
  </ApolloMutation>
</template>

<script>
import { mapMutations } from 'vuex';

import Error from '@/components/Error.vue';

import { onLogin } from '@/vue-apollo';

export default {
  name: 'Signin',
  components: {
    Error,
  },
  data() {
    return {
      form: {
        email: '',
        password: '',
      },
    };
  },
  methods: {
    ...mapMutations(['signin']),
    onDone(result) {
      // Set state
      this.signin(result.data.userLogin.authenticatable);

      // Set token in local storage
      onLogin(this.$apolloProvider.defaultClient, result.data.userLogin.credentials.accessToken);

      // Redirect to homepage
      this.$router.push('/');
    },
  },
  mounted() {
    if (this.$store.getters.isAuthenticated) this.$router.push('/');
  },
};
</script>
