<template>
  <section class="uk-section">
    <div class="uk-container">
      <ul class="uk-breadcrumb uk-margin-small-bottom">
        <li><span>Home</span></li>
      </ul>
      <div class="uk-margin-medium-bottom">
        <h3 class="uk-margin-remove-vertical">For you</h3>
        <small>A fresh batch of daily recommendations, made personally for you!</small>
      </div>

      <ApolloQuery :query="require('@/graphql/queries/recommendations/get.graphql')" notifyOnNetworkStatusChange>
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

          <div v-else-if="data.recommendations">
            <div class="uk-grid-medium@m uk-grid-small@s" uk-grid uk-height-match="target: .uk-card">
              <div
                v-for="recommendation in data.recommendations"
                :key="recommendation.recommended.id"
                class="uk-width-1-2 uk-width-1-3@s uk-width-1-4@m uk-width-1-5@l"
              >
                <MusicCard :music="recommendation.recommended" />
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
import MusicCard from '@/components/cards/MusicCard.vue';

export default {
  name: 'Home',
  components: {
    MusicCard,
  },
};
</script>
