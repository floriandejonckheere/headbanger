<template>
  <section class="uk-section">
    <div class="uk-container">
      <ul class="uk-breadcrumb uk-margin-small-bottom">
        <li><router-link to="/browse">Browse</router-link></li>
        <li><span>Genres</span></li>
      </ul>
      <h3 class="uk-margin-remove-top">Genres</h3>

      <ApolloQuery :query="require('../../graphql/queries/Genres.gql')" notifyOnNetworkStatusChange>
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

          <div v-else-if="data.genres.length !== 0">
            <div class="uk-grid-medium@m uk-grid-small@s" uk-grid>
              <div
                v-for="genre in data.genres"
                :key="genre.id"
                class="uk-width-1-2 uk-width-1-3@s uk-width-1-4@m uk-width-1-5@l"
              >
                <GenreCard :genre="genre" />
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
import GenreCard from '@/components/GenreCard.vue';

export default {
  name: 'Genres',
  components: {
    GenreCard,
  },
};
</script>
