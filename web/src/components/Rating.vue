<template>
  <div>
    <div
      class="uk-button uk-button-small hb-rating-button"
      v-bind:class="{ 'hb-rating-button-selected': (rating === 'like') }"
    >
      <ion-icon name="heart" size="small" class="uk-inline" />
    </div>
    <div
      class="uk-button uk-button-small hb-rating-button"
      v-bind:class="{ 'hb-rating-button-selected': (rating === 'dislike') }"
    >
      <ion-icon name="heart-dislike" size="small" class="uk-inline" />
    </div>
  </div>
</template>

<script>
export default {
  name: 'Rating',
  props: {
    rating: [String, null],
  },
};
</script>

<style lang="scss">
  @import "~uikit/src/scss/variables.scss";

  .hb-rating-button {
    background: $global-muted-background;

    ion-icon {
      color: $global-muted-color;
    }

    &:hover {
      background: $global-danger-background;

      ion-icon {
        color :white;
      }
    }
  }

  .hb-rating-button-selected {
    ion-icon {
      color: $global-danger-background;
    }
  }
</style>
