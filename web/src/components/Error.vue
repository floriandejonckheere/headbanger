<template>
  <div v-if="error" class="uk-width-1-1">
    <div class="uk-alert-danger" uk-alert>
      <a class="uk-alert-close" uk-close></a>
      <div v-if="error.graphQLErrors && error.graphQLErrors.length > 0">
        <p class="uk-margin-remove-bottom" v-for="(message, i) in error.graphQLErrors.flatMap(e => e.extensions.detailed_errors || e.message)" v-bind:key="i">
          {{ message }}
        </p>
      </div>
      <p v-else>An error occurred: {{ error.message }}</p>
    </div>
  </div>

</template>

<script>
export default {
  name: 'Error',
  props: {
    error: [Object, Error],
  },
  data() {
    return {};
  },
};
</script>
