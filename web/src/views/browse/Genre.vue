<template>
  <ApolloQuery
    :query="require('../../graphql/queries/Genre.gql')"
    :variables="{ id }"
    notifyOnNetworkStatusChange
  >
    <template slot-scope="{ result: { loading, error, data } }">
      <section class="uk-section">
        <div class="uk-container">
          <ul class="uk-breadcrumb uk-margin-small-bottom">
            <li><router-link to="/browse">Browse</router-link></li>
            <li><router-link to="/browse/genres">Genres</router-link></li>
            <li><span v-text="data.genre.description" v-if="data"></span></li>
          </ul>
          <h3 class="uk-margin-remove-top" v-text="data.genre.description" v-if="data" />

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
                v-for="group in data.genre.groups"
                :key="group.id"
                class="uk-width-1-2 uk-width-1-3@s uk-width-1-4@m uk-width-1-5@l"
              >
                <GroupCard :group="group" />
              </div>
            </div>
          </div>

          <div v-else class="uk-width-1-1">
            <div class="uk-alert-primary" uk-alert>
              <a class="uk-alert-close" uk-close></a>
              <p>No results</p>
            </div>
          </div>
        </div>
      </section>
    </template>
  </ApolloQuery>
</template>

<script>
import GroupCard from '@/components/GroupCard.vue';

export default {
  name: 'Genre',
  props: {
    id: String,
  },
  components: {
    GroupCard,
  },
};
</script>
