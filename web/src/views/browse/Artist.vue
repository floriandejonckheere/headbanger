<template>
  <section class="uk-section">
    <div class="uk-container">
      <ApolloQuery
        :query="require('@/graphql/queries/artists/find.graphql')"
        :variables="{ id }"
        notifyOnNetworkStatusChange
      >
        <template slot-scope="{ result: { loading, error, data } }">
          <ul class="uk-breadcrumb uk-margin-small-bottom">
            <li><router-link to="/browse">Browse</router-link></li>
            <li><router-link to="/browse/artists">Artists</router-link></li>
            <li>
              {{ (data ? data.artist.name : 'Loading...')  }}
            </li>
          </ul>

          <div v-if="loading" class="uk-text-center">
            <div uk-spinner />
          </div>

          <div v-else-if="error" class="uk-width-1-1">
            <div class="uk-alert-danger" uk-alert>
              <a class="uk-alert-close" uk-close></a>
              <p>An error occurred: {{ error.message }}</p>
            </div>
          </div>

          <div v-if="data.artist">
            <div class="uk-cover-container uk-height-medium">
              <img src="https://ia601209.us.archive.org/25/items/mbid-a86017c0-09d9-4edd-81d3-767ac56ed3ff/mbid-a86017c0-09d9-4edd-81d3-767ac56ed3ff-14459102581.jpg" alt="" uk-cover>
              <div class="uk-overlay-primary uk-position-cover" />
              <h3 class="uk-overlay uk-position-bottom uk-light">
                {{ data.artist.name }}
              </h3>
            </div>

            <h3>Member of</h3>

            <div v-if="data.artist.groups.length !== 0">
              <div class="uk-grid-medium@m uk-grid-small@s" uk-grid>
                <div
                  v-for="group in data.artist.groups"
                  :key="group.id"
                  class="uk-width-1-2 uk-width-1-3@s uk-width-1-4@m uk-width-1-5@l"
                >
                  <GroupCard :group="group" />
                </div>
              </div>
            </div>
          </div>

          <div v-else class="uk-width-1-1">
            <div class="uk-alert-primary" uk-alert>
              <a class="uk-alert-close" uk-close></a>
              <p>No results. <u><a class="uk-link-text" @click="$router.go(-1)">Go back</a></u></p>
            </div>
          </div>
        </template>
      </ApolloQuery>
    </div>
  </section>
</template>

<script>
import GroupCard from '@/components/cards/GroupCard.vue';

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
