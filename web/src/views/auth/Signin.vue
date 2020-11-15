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
                    <input class="uk-input uk-form-blank" type="email" name="email" id="email" placeholder="Email" v-model="form.email" required>
                  </div>

                  <div class="uk-margin">
                    <input class="uk-input uk-form-blank" type="password" name="password" id="password" placeholder="Password" v-model="form.password" required>
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
                  <router-link
                    :to="{ name: 'signup' }"
                    class="uk-button uk-button-text uk-margin-small-top uk-float-right"
                  >
                    Sign up
                  </router-link>
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
import { mapMutations, mapGetters } from 'vuex';

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
      const {
        uid,
        accessToken: token,
        client,
      } = result.data.userLogin.credentials;
      onLogin(this.$apolloProvider.defaultClient, { uid, token, client });

      // Redirect to homepage
      this.$router.push('/');
    },
  },
  computed: {
    ...mapGetters(['isAuthenticated']),
  },
  mounted() {
    if (this.isAuthenticated) this.$router.push('/');
  },
};
</script>
