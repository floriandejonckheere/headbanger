<template>
  <div v-if="error" class="uk-width-1-1">
    <div class="uk-alert-danger" uk-alert>
      <a class="uk-alert-close" uk-close></a>
      <p>An error occurred: {{ error.message }}</p>
    </div>
  </div>

</template>

<script>
export default {
  name: 'Error',
  props: {
    error: Object,
  },
};
</script>
