<template>
  <div>
    <ArtistCard :artist="music" v-if="music.__typename === 'Artist'" />
    <GroupCard :group="music" v-else-if="music.__typename === 'Group'" />
    <ReleaseCard :release="music" v-else-if="music.__typename === 'Release'" />
    <strong v-else>Error</strong>
  </div>
</template>

<script>
import ArtistCard from '@/components/cards/ArtistCard.vue';
import GroupCard from '@/components/cards/GroupCard.vue';
import ReleaseCard from '@/components/cards/ReleaseCard.vue';

export default {
  name: 'MusicCard',
  props: {
    music: Object,
  },
  components: {
    ArtistCard,
    GroupCard,
    ReleaseCard,
  },
};
</script>
