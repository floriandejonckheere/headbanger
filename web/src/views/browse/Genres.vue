<template>
  <section class="uk-section">
    <div class="uk-container">
      <ul class="uk-breadcrumb uk-margin-small-bottom">
        <li><router-link to="/browse">Browse</router-link></li>
        <li><span>Genres</span></li>
      </ul>
      <h3 class="uk-margin-remove-top">Genres</h3>

      <Query :query="require('@/graphql/queries/genres/list.graphql')">
        <template slot="success" slot-scope="data">
          <div class="uk-grid-medium@m uk-grid-small@s" uk-grid>
            <div
              v-for="genre in data.genres"
              :key="genre.id"
              class="uk-width-1-2 uk-width-1-3@s uk-width-1-4@m uk-width-1-5@l"
            >
              <GenreCard :genre="genre" />
            </div>
          </div>
        </template>
      </Query>
    </div>
  </section>
</template>

<script>
import Query from '@/components/Query.vue';
import GenreCard from '@/components/cards/GenreCard.vue';

export default {
  name: 'Genres',
  components: {
    Query,
    GenreCard,
  },
};
</script>
