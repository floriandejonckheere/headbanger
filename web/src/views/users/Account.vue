<template>
  <section class="uk-section">
    <div class="uk-container">
      <h3 class="uk-margin-remove-top">My account</h3>

      <div class="uk-grid uk-child-width-1-3@s uk-flex-column">
        <ApolloMutation :mutation="require('@/graphql/mutations/users/update.graphql')">
          <template v-slot="{ mutate, loading, error }">
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
            </form>
            <button
              type="submit"
              form="form-signup"
              class="uk-button uk-button-primary"
              :disabled="loading"
            >
              Update
            </button>
          </template>
        </ApolloMutation>
      </div>
    </div>
  </section>
</template>

<script>
import Error from '@/components/Error.vue';

export default {
  name: 'Account',
  components: {
    Error,
  },
  data() {
    return {
      form: {
        name: '',
        email: '',
        password: '',
        country: '',
      },
    };
  },
};
</script>
