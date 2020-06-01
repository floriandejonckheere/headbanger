<template>
  <ApolloQuery
    :query="query"
    :variables="variables"
    :skip="skip"
    notifyOnNetworkStatusChange
  >
    <template slot-scope="{ result: { loading, error, data }, query }">
      loading = {{loading}};
      error = {{error}}
      data = {{data}}

      <div v-if="loading" class="uk-text-center">
        <div uk-spinner key="loading" />
      </div>

      <div v-if="error" class="uk-width-1-1">
        <div class="uk-alert-danger" uk-alert>
          <a class="uk-alert-close" uk-close></a>
          <p>An error occurred: {{ error.message }}</p>
        </div>
      </div>

      <div v-if="data">
        <slot name="success" v-bind="{ data, query }"></slot>
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
    variables: Object,
    skip: Boolean,
  },
};
</script>
