<template>
  <ApolloQuery
    :query="query"
    notifyOnNetworkStatusChange
  >
    <template slot-scope="{ result: { loading, error, data } }">
      <div v-if="loading" class="uk-text-center">
        <div uk-spinner key="loading" />
      </div>

      <div v-else-if="error" class="uk-width-1-1">
        <div class="uk-alert-danger" uk-alert>
          <a class="uk-alert-close" uk-close></a>
          <p>An error occurred: {{ error.message }}</p>
        </div>
      </div>

      <div v-else-if="data">
        <slot name="success" v-bind="data"></slot>
      </div>

      <div v-else class="uk-width-1-1">
        <div class="uk-alert-primary" uk-alert>
          <a class="uk-alert-close" uk-close></a>
          <p>No results. <u><a class="uk-link-text" @click="$router.go(-1)">Go back</a></u></p>
        </div>
      </div>
    </template>
  </ApolloQuery>

</template>

<script>
export default {
  name: 'Query',
  props: {
    query: Object,
  },
};
</script>
