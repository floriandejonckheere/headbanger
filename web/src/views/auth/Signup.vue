<template>
  <ApolloMutation :mutation="require('@/graphql/mutations/auth/signup.graphql')" @done="onDone">
    <template v-slot="{ mutate, loading, error }">
      <section class="uk-section">
        <div class="uk-container">
          <div class="uk-grid uk-child-width-1-3@s uk-flex-center">
            <div class="uk-card uk-card-small uk-padding-small uk-card-default uk-box-shadow-small uk-background-default">
              <div class="uk-card-header">
                <h3 class="uk-margin-remove-vertical">Sign up</h3>
                <small>Sign up to enjoy personalized suggestions</small>
              </div>
              <div class="uk-card-body">
                <Error :error="error" />

                <form
                  id="form-signup"
                  @submit.prevent="mutate({ variables: { ...form } })"
                >
                  <div class="uk-margin">
                    <input class="uk-input uk-form-blank" type="text" placeholder="Name" v-model="form.name" required>
                  </div>

                  <div class="uk-margin">
                    <input class="uk-input uk-form-blank" type="email" placeholder="Email" v-model="form.email" required>
                  </div>

                  <div class="uk-margin">
                    <input class="uk-input uk-form-blank" type="password" minlength="6" placeholder="Password" v-model="form.password" required>
                  </div>

                  <div class="uk-margin">
                    <div class="uk-form-controls">
                      <select class="uk-select uk-form-blank" v-model="form.country" required>
                        <option value="" selected disabled>Country</option>
                        <option v-for="country in countries" v-bind:value="country.code" v-bind:key="country.code">
                          {{ country.name }}
                        </option>
                      </select>
                    </div>
                  </div>

                  <div class="uk-margin uk-flex">
                    <div><input class="uk-checkbox" type="checkbox" v-model="form.tos"></div>
                    <div class="uk-margin-small-left">
                      I have read and agree to the <router-link to="#">Terms of Service</router-link> and <router-link to="#">Privacy Policy</router-link>
                    </div>
                  </div>
                </form>
              </div>
              <div class="uk-card-footer uk-flex uk-flex-column">
                <div class="uk-margin-small">
                  <button
                    type="submit"
                    form="form-signup"
                    class="uk-button uk-button-primary"
                    :disabled="loading"
                  >
                    Sign up
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
import { mapMutations, mapGetters } from 'vuex';

import { countries } from 'countries-list';

import Error from '@/components/Error.vue';

import { onLogin } from '@/vue-apollo';

export default {
  name: 'Signup',
  components: {
    Error,
  },
  data() {
    const countriesWithCode = Object.entries(countries).map((struct) => ({ ...struct[1], code: struct[0] }));
    return {
      countries: countriesWithCode.sort((a, b) => (a.name.localeCompare(b.name))),
      form: {
        name: '',
        email: '',
        password: '',
        country: '',
        tos: false,
      },
    };
  },
  methods: {
    ...mapMutations(['signin']),
    onDone(result) {
      // Set state
      this.signin(result.data.userSignUp.authenticatable);

      // Set token in local storage
      onLogin(this.$apolloProvider.defaultClient, result.data.userSignUp.credentials.accessToken);

      // Redirect to homepage
      this.$router.push('/');
    },
  },
  computed: {
    ...mapGetters(['isAuthenticated']),
  },
  mounted() {
    console.log(this.isAuthenticated);
    if (this.isAuthenticated) this.$router.push('/');
  },
};
</script>
