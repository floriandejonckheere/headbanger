<template>
  <div>
    <div class="uk-margin-large uk-inline">
      <span class="uk-form-icon uk-form-icon-flip" uk-icon="icon: search"></span>
      <input
        class="uk-input uk-form-blank uk-form-width-large"
        type="text"
        placeholder="Search music..."
        ref="search"
        @input="debounceInput"
      >
    </div>

    <ApolloQuery
      :query="require('@/graphql/queries/music/search.graphql')"
      :variables="{
        query,
        first: 10,
      }"
      :skip="query.length < 3"
      notifyOnNetworkStatusChange
    >
      <template slot-scope="{ result: { loading, error, data }, query: gqlQuery }">
        <div class="uk-grid-medium@m uk-grid-small@s" uk-grid uk-height-match="target: .uk-card-body">
          <Loading :loading="loading" />
          <Error :error="error" />
          <NoResults :results="data && data.results.edges" />

          <template v-if="data && data.results.edges.length > 0">
            <div
              v-for="edge in data.results.edges"
              :key="edge.node.id"
              class="uk-width-1-2 uk-width-1-3@s uk-width-1-4@m uk-width-1-5@l"
            >
              <MusicCard :music="edge.node" />
            </div>
          </template>
        </div>

        <div class="uk-margin">
          <infinite-loading @infinite="() => loadMore(query, gqlQuery, data)">
            <div slot="spinner" class="uk-spinner" />
          </infinite-loading>
        </div>
      </template>
    </ApolloQuery>
  </div>
</template>

<script>
import debounce from 'debounce';

import Loading from '@/components/Loading.vue';
import Error from '@/components/Error.vue';
import NoResults from '@/components/NoResults.vue';

import MusicCard from '@/components/cards/MusicCard.vue';

export default {
  name: 'Search',
  data() {
    return {
      query: '',
    };
  },
  mounted() {
    this.query = this.$route.query.query;
    this.$refs.search.value = this.query;
  },
  methods: {
    loadMore(query, gqlQuery, data) {
      console.log('fetching');

      if (!data || !data.results.pageInfo.hasNextPage) return;

      gqlQuery.fetchMore({
        variables: {
          query,
          after: data.results.pageInfo.endCursor,
        },
        updateQuery: (prevResult, { fetchMoreResult }) => {
          console.log(fetchMoreResult.results);
          const newEdges = fetchMoreResult.results.edges;
          const { pageInfo } = fetchMoreResult.results;

          if (newEdges.length === 0) return prevResult;

          return {
            results: {
              __typename: prevResult.results.__typename,
              edges: [...prevResult.results.edges, ...newEdges],
              pageInfo,
            },
          };
        },
      });
    },
  },
  components: {
    Loading,
    Error,
    NoResults,
    MusicCard,
  },
  created() {
    this.debounceInput = debounce((e) => {
      this.query = e.target.value;
    }, 500);
  },
};
</script>
