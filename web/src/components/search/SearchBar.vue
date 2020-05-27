<template>
  <div class="uk-inline">
    <div class="uk-inline">
      <span class="uk-form-icon uk-form-icon-flip" uk-icon="icon: search"></span>
      <input
        class="uk-input uk-form-blank"
        type="text"
        placeholder="Search music..."
        id="search"
        @input="debounceInput"
      >
    </div>

    <ApolloQuery
      :query="require('@/graphql/queries/music/search.graphql')"
      :variables="{ query }"
      :skip="query.length < 3"
      notifyOnNetworkStatusChange
    >
      <template slot-scope="{ result: { loading, error, data } }">
        <div
          uk-dropdown="mode: click; toggle: #search; animation: uk-animation-fade; duration: 100"
          class="uk-background-default uk-padding-small uk-box-shadow-small uk-width-1-1"
          id="search-dropdown"
        >
          <div v-if="loading" class="uk-text-center">
            <div uk-spinner key="loading" />
          </div>

          <div v-else-if="error" class="uk-text-danger">
            An error occurred: {{ error.message }}
          </div>

          <ul
            class="uk-nav uk-dropdown-nav uk-list-large uk-text-break"
            v-else-if="data && data.results.length !== 0"
          >
            <li v-for="result in data.results" v-bind:key="result.id">
              <SearchResult :result="result" />
            </li>
            <li>
              <router-link to="/" class="uk-link-text uk-text-primary uk-text-center">
                See all results
              </router-link>
            </li>
          </ul>

          <div v-else>
            No results.
          </div>
        </div>
      </template>
    </ApolloQuery>
  </div>
</template>

<script>
import debounce from 'debounce';

import SearchResult from './SearchResult.vue';

export default {
  name: 'SearchBar',
  data() {
    return {
      query: '',
    };
  },
  components: {
    SearchResult,
  },
  created() {
    this.debounceInput = debounce((e) => {
      this.query = e.target.value;
      UIkit.dropdown('#search-dropdown').show();
    }, 500);
  },
};
</script>
