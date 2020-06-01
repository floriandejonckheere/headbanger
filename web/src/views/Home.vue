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
          <div class="uk-grid-medium@m uk-grid-small@s" uk-grid uk-height-match="target: .uk-card-body">
            <Loading :loading="loading" />
            <Error :error="error" />
            <NoResults
              :results="data && data.recommendations.edges"
              message="Hey there! Unfortunately we don't have any recommendations for you right now. Come back in a bit!"
            />

            <template v-if="data && data.recommendations.edges.length > 0">
              <div
                v-for="edge in data.recommendations.edges"
                :key="edge.node.id"
                class="uk-width-1-2 uk-width-1-3@s uk-width-1-4@m uk-width-1-5@l"
              >
                <MusicCard :music="edge.node.recommended" />
              </div>
            </template>
          </div>
        </template>
      </ApolloQuery>
    </div>
  </section>
</template>

<script>
import Loading from '@/components/Loading.vue';
import Error from '@/components/Error.vue';
import NoResults from '@/components/NoResults.vue';

import MusicCard from '@/components/cards/MusicCard.vue';

export default {
  name: 'Home',
  components: {
    Loading,
    Error,
    NoResults,
    MusicCard,
  },
};
</script>
