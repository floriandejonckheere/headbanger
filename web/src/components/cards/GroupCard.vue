<template>
  <Card
    :title="group.name"
    :description="group.name"
  />
</template>

<script>
import Card from './Card.vue';

export default {
  name: 'GroupCard',
  props: {
    group: Object,
  },
  components: {
    Card,
  },
};
</script>
