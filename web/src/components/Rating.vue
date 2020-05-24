<template>
  <div>
    <ApolloMutation
      :mutation="require('@/graphql/mutations/music/rate.graphql')"
      class="form"
    >
      <template v-slot="{ mutate, loading, error }">
        <button
          v-if="error"
          class="uk-button uk-button-default demo"
          type="button"
          onclick="UIkit.notification({ message: error, status: 'danger' })"
        >Danger</button>

        <div
          class="uk-button uk-button-small hb-rating-button"
          v-bind:class="{ 'hb-rating-button-selected': (music.rating === 'like') }"
          :disabled="loading"
          @click="mutate({
            variables: {
              type: music.__typename,
              id: music.id,
              rating: (music.rating === 'like' ? null : 'like'),
            }
          })"
        >
          <ion-icon name="heart" size="small" class="uk-inline" />
        </div>
        <div
          class="uk-button uk-button-small hb-rating-button"
          v-bind:class="{ 'hb-rating-button-selected': (music.rating === 'dislike') }"
          :disabled="loading"
          @click="mutate({
            variables: {
              type: music.__typename,
              id: music.id,
              rating: (music.rating === 'dislike' ? null : 'dislike'),
            }
          })"
        >
          <ion-icon name="heart-dislike" size="small" class="uk-inline" />
        </div>
      </template>
    </ApolloMutation>
  </div>
</template>

<script>
export default {
  name: 'Rating',
  props: {
    music: Object,
  },
};
</script>

<style lang="scss">
  @import "~uikit/src/scss/variables.scss";

  .hb-rating-button {
    background: $global-muted-background;

    ion-icon { color: $global-muted-color; }

    &:hover {
      background: $global-danger-background;

      ion-icon { color: white; }
    }

    &:active,
    &:focus {
      background: darken($global-danger-background, 10%);

      ion-icon { color: white; }
    }
  }

  .hb-rating-button-selected {
    ion-icon { color: $global-danger-background; }
  }
</style>
