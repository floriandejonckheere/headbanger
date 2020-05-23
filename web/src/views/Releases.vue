<template>
  <section class="uk-section">
    <div class="uk-container">
      <h3>Releases</h3>

      <ApolloQuery :query="require('@/graphql/queries/releases/list.graphql')" notifyOnNetworkStatusChange>
        <template slot-scope="{ result: { loading, error, data } }">
          <div v-if="loading" class="uk-text-center">
            <div uk-spinner />
          </div>

          <div v-else-if="error" class="uk-width-1-1">
            <div class="uk-alert-danger" uk-alert>
              <a class="uk-alert-close" uk-close></a>
              <p>An error occurred: {{ error.message }}</p>
            </div>
          </div>

          <div v-else-if="data">
            <div class="uk-grid-medium@m uk-grid-small@s" uk-grid>
              <div
                v-for="release in data.releases"
                :key="release.id"
                class="uk-width-1-2 uk-width-1-3@s uk-width-1-4@m uk-width-1-5@l"
              >
                <Card :title="release.name" :description="release.groups[0].name" />
              </div>
            </div>
          </div>

          <div v-else class="uk-width-1-1">
            <div class="uk-alert-primary" uk-alert>
              <a class="uk-alert-close" uk-close></a>
              <p>No results</p>
            </div>
          </div>
        </template>
      </ApolloQuery>
    </div>
  </section>
</template>

<script>
import Card from '@/components/cards/Card.vue';

export default {
  name: 'Releases',
  components: {
    Card,
  },
};
</script>
