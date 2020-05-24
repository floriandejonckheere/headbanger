<template>
  <section class="uk-section">
    <div class="uk-container">
      <div class="uk-grid uk-child-width-1-3@s uk-flex-center">
        <div class="uk-card uk-card-small uk-padding-small uk-card-default uk-box-shadow-small uk-background-default">
          <div class="uk-card-header">
            <h3 class="uk-margin-remove-vertical">Sign up</h3>
            <small>Sign up to enjoy personalized suggestions</small>
          </div>
          <div class="uk-card-body">
            <form>
              <div class="uk-margin">
                <input class="uk-input uk-form-blank" type="text" placeholder="Name" required>
              </div>

              <div class="uk-margin">
                <input class="uk-input uk-form-blank" type="email" placeholder="Email" required>
              </div>

              <div class="uk-margin">
                <input class="uk-input uk-form-blank" type="password" placeholder="Password" required>
              </div>

              <div class="uk-margin">
                <div class="uk-form-controls">
                  <select class="uk-select uk-form-blank" id="form-stacked-select">
                    <option value="">Country</option>
                    <option v-for="(country, code) in countries" v-bind:value="code" v-bind:key="code">
                      {{ country.name }}
                    </option>
                  </select>
                </div>
              </div>

              <div class="uk-margin uk-flex">
                <div><input class="uk-checkbox" type="checkbox"></div>
                <div class="uk-margin-small-left">I have read and agree to the <router-link to="#">Terms of Service</router-link> and <router-link to="#">Privacy Policy</router-link></div>
              </div>
            </form>
          </div>
          <div class="uk-card-footer uk-flex uk-flex-column">
            <div class="uk-margin-small">
              <button class="uk-button uk-button-primary">Sign up</button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
import { countries } from 'countries-list';

export default {
  name: 'Home',
  data() {
    return {
      countries: Object.values(countries).sort((a, b) => (a.name.localeCompare(b.name))),
    };
  },
};
</script>
