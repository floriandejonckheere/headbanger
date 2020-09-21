<template>
  <div v-if="error" class="uk-width-1-1">
    <div class="uk-alert-danger" uk-alert>
      <a class="uk-alert-close" uk-close></a>
      <div v-if="error.graphQLErrors">
        <p class="uk-margin-remove-bottom" v-for="(message, i) in error.graphQLErrors.flatMap(e => e.extensions.detailed_errors)" v-bind:key="i">
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
};
</script>
