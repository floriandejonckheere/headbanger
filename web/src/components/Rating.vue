<template>
  <ApolloMutation
    :mutation="require('@/graphql/mutations/music/rate.graphql')"
    class="form"
  >
    <template v-slot="{ mutate, loading, error }">
      <span v-if="error">{{ error }}</span>

      <div class="uk-flex uk-flex-between uk-flex-bottom">
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
          Like
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
          Dislike
        </div>
      </div>
    </template>
  </ApolloMutation>
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
    color: $global-muted-color;

    &:hover {
      background: $global-danger-background;
      color: white;
    }

    &:active,
    &:focus {
      background: darken($global-danger-background, 10%);
      color: white;
    }
  }

  .hb-rating-button-selected {
    color: $global-danger-background;

    &:hover {
      color: white;
    }
  }
</style>
