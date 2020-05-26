<template>
  <section class="uk-section">
    <div class="uk-container">
      <h3>Releases</h3>

      <Query :query="require('@/graphql/queries/releases/list.graphql')">
        <template slot="success" slot-scope="data">
          <div class="uk-grid-medium@m uk-grid-small@s" uk-grid>
            <div
              v-for="release in data.releases"
              :key="release.id"
              class="uk-width-1-2 uk-width-1-3@s uk-width-1-4@m uk-width-1-5@l"
            >
              <Card :title="release.name" :description="release.groups[0].name" />
            </div>
          </div>
        </template>
      </Query>
    </div>
  </section>
</template>

<script>
import Query from '@/components/Query.vue';
import Card from '@/components/cards/Card.vue';

export default {
  name: 'Releases',
  components: {
    Query,
    Card,
  },
};
</script>
