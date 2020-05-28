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

      <Query :query="require('@/graphql/queries/recommendations/get.graphql')">
        <template slot="success" slot-scope="{ data }">
          <div class="uk-grid-medium@m uk-grid-small@s" uk-grid uk-height-match="target: .uk-card-body">
            <div
              v-for="edge in data.recommendations.edges"
              :key="edge.node.id"
              class="uk-width-1-2 uk-width-1-3@s uk-width-1-4@m uk-width-1-5@l"
            >
              <MusicCard :music="edge.node.recommended" />
            </div>
          </div>
        </template>
      </Query>
    </div>
  </section>
</template>

<script>
import Query from '@/components/Query.vue';
import MusicCard from '@/components/cards/MusicCard.vue';

export default {
  name: 'Home',
  components: {
    Query,
    MusicCard,
  },
};
</script>
