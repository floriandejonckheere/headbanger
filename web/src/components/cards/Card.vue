<template>
  <div class="uk-card uk-card-default uk-box-shadow-small uk-background-default">
    <div class="uk-card-media-top">
      <div class="uk-inline uk-visible-toggle uk-animation-toggle">
        <img src="https://ia601209.us.archive.org/25/items/mbid-a86017c0-09d9-4edd-81d3-767ac56ed3ff/mbid-a86017c0-09d9-4edd-81d3-767ac56ed3ff-14459102581_thumb500.jpg" alt="">
        <div class="uk-overlay-primary uk-position-cover uk-invisible-hover uk-animation-fade uk-animation-fast">
          <span class="uk-position-center">
            <a href="#">
              <ion-icon name="play-outline" style="font-size: 2rem;" />
            </a>
          </span>
        </div>
      </div>
    </div>
    <div class="uk-card-body uk-text-left uk-padding-small">
      <div class="uk-text-bold uk-text-break">
        <slot name="title"></slot>
      </div>
      <div class="uk-text-small">
        <slot name="description"></slot>
      </div>

      <div class="uk-text-right uk-margin-small-top">
        <Rating v-bind:rating="null" />
      </div>
    </div>
  </div>
</template>

<script>
import Rating from '@/components/Rating.vue';

export default {
  name: 'Card',
  components: {
    Rating,
  },
};
</script>
