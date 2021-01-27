<template>
  <section class="uk-section">
    <div class="uk-container">
      <h3 class="uk-margin-remove-top">My account</h3>

      <div class="uk-grid uk-child-width-1-1 uk-child-width-1-2@m uk-child-width-1-3@l uk-flex-column">
        <Query :query="require('@/graphql/queries/users/find.graphql')" :variables="{ id }" :result="onResult" />

        <div v-for="error in errors" :key="error.message">
          <Error :error="error" />
        </div>

        <ApolloMutation :mutation="require('@/graphql/mutations/users/update.graphql')" @done="onDone">
          <template v-slot="{ mutate, loading, error }">
            <Error :error="error" />

            <form
              id="form-signup"
              @submit.prevent="mutate({ variables: { ...form, id } })"
            >
              <div class="uk-margin">
                <input class="uk-input uk-form-blank" type="text" placeholder="Name" v-model="form.name" required>
              </div>

              <div class="uk-margin">
                <input class="uk-input uk-form-blank" type="email" placeholder="Email" v-model="form.email" required>
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

              <div class="uk-margin">
                <input class="uk-input uk-form-blank" type="password" placeholder="Password" v-model="form.password" required>
              </div>
            </form>
            <button
              type="submit"
              form="form-signup"
              class="uk-button uk-button-primary"
              :disabled="loading"
            >
              Save
            </button>
          </template>
        </ApolloMutation>
      </div>
    </div>
  </section>
</template>

<script>
import { mapMutations, mapGetters } from 'vuex';

import Error from '@/components/Error.vue';
import Query from '@/components/Query.vue';

import { sortedCountriesWithCode } from '@/lib/countries';

export default {
  name: 'Account',
  components: {
    Error,
    Query,
  },
  computed: {
    ...mapGetters(['id']),
  },
  data() {
    return {
      countries: sortedCountriesWithCode,
      errors: [],
      form: {
        name: '',
        email: '',
        country: '',
        password: '',
      },
    };
  },
  methods: {
    ...mapMutations(['update']),
    onResult(result) {
      if (result.data === undefined) return;

      this.form.name = result.data.user.name;
      this.form.email = result.data.user.email;
      this.form.country = result.data.user.country;
    },
    onDone(result) {
      const { user, errors } = result.data.updateUser;

      if (errors !== null) {
        this.errors = errors;
      } else {
        // Update user info in store
        this.update(user);

        // Redirect to homepage
        this.$router.push('/');
      }
    },
  },
};
</script>
