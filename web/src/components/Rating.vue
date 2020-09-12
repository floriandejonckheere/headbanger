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
          <ios-heart-icon class="uk-text-middle" h="18px" w="18px" />
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
          <ios-heart-dislike-icon class="uk-text-middle" h="18px" w="18px" />
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
