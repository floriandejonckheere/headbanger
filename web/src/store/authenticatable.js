const initialState = {
  authenticatable: {
    id: null,
    name: null,
    email: null,
  },
};

const getters = {
  isAuthenticated(state) {
    return state.authenticatable.id !== null;
  },
};

const mutations = {
  signin(state, authenticatable) {
    const { id, name, email } = authenticatable;

    state.authenticatable = { id, name, email };
  },
  signout(state) {
    state.authenticatable = { id: null, name: null, email: null };
  },
};

const actions = {
  signin({ commit }, authenticatable) {
    commit('signin', authenticatable);
  },
  signout({ commit }) {
    commit('signout');
  },
};

export default {
  state: initialState,
  getters,
  mutations,
  actions,
};
