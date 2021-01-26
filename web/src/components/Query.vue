<template>
  <ApolloQuery
    :query="query"
    :variables="variables"
    :skip="skip"
    @done="done"
    notifyOnNetworkStatusChange
  >
    <template slot-scope="{ result: { loading, error, data }, query }">
      loading = {{loading}};
      error = {{error}}
      data = {{data}}

      <Loading :loading="loading" />
      <Error :error="error" />

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
import Loading from '@/components/Loading.vue';
import Error from '@/components/Error.vue';

export default {
  name: 'Query',
  props: {
    query: Object,
    variables: Object,
    skip: Boolean,
    done: Function,
  },
  components: {
    Loading,
    Error,
  },
};
</script>
