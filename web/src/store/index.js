import Vue from 'vue';
import Vuex from 'vuex';
import VuexPersist from 'vuex-persist';

import authenticatable from './authenticatable';

Vue.use(Vuex);

const vuexLocalStorage = new VuexPersist({
  key: 'vuex',
  storage: window.localStorage,
  // Function that passes the state and returns the state with only the objects you want to store.
  // reducer: (state) => state,
  // Function that passes a mutation and lets you decide if it should update the state in localStorage.
  // filter: (mutation) => true,
});

export default new Vuex.Store({
  plugins: [vuexLocalStorage.plugin],
  modules: {
    authenticatable,
  },
});
