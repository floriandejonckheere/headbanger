<template>
  <ApolloMutation :mutation="require('@/graphql/mutations/auth/signup.graphql')">
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
                <div class="uk-alert-danger" v-if="error" uk-alert><p>{{ error }}</p></div>

                <form
                  id="form-signup"
                  @submit="mutate({ variables: { ...form } })"
                >
                  <div class="uk-margin">
                    <input class="uk-input uk-form-blank" type="text" placeholder="Name" v-model="form.name" required>
                  </div>

                  <div class="uk-margin">
                    <input class="uk-input uk-form-blank" type="email" placeholder="Email" v-model="form.email" required>
                  </div>

                  <div class="uk-margin">
                    <input class="uk-input uk-form-blank" type="password" placeholder="Password" v-model="form.password" required>
                  </div>

                  <div class="uk-margin">
                    <div class="uk-form-controls">
                      <select class="uk-select uk-form-blank" v-model="form.country">
                        <option value="">Country</option>
                        <option v-for="(country, code) in countries" v-bind:value="code" v-bind:key="code">
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
import { countries } from 'countries-list';

export default {
  name: 'Home',
  data() {
    return {
      countries: Object.values(countries).sort((a, b) => (a.name.localeCompare(b.name))),
      form: {},
    };
  },
};
</script>
