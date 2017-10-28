import {
  buildApi,
  get,
} from 'redux-bees'

import Config from 'config'

const apiEndpoints = {
  /* Artists */
  getArtists:   { method: get,      path: '/artists' },
  getArtist:    { method: get,      path: '/artists/:id' },

  /* Groups */
  getGroups:   { method: get,      path: '/groups' },
  getGroup:    { method: get,      path: '/groups/:id' },

  /* Releases */
  getReleases:   { method: get,      path: '/releases' },
  getRelease:    { method: get,      path: '/releases/:id' },

  /* Genres */
  getGenres:    { method: get,      path: '/genres' },
  getGenre:     { method: get,      path: '/genres/:id' },
};

const config = {
  baseUrl: Config.API_URL
}

export default buildApi(apiEndpoints, config)
