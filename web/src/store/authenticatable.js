const initialState = () => ({
  id: null,
  name: null,
  email: null,
});

const getters = {
  isAuthenticated(state) {
    return state.id !== null;
  },
  id(state) {
    return state.id;
  },
};

const mutations = {
  signin(state, authenticatable) {
    const { id, name, email } = authenticatable;

    state.id = id;
    state.name = name;
    state.email = email;
  },
  signout(state) {
    state.id = null;
    state.name = null;
    state.email = null;
  },
  update(state, authenticatable) {
    const { name, email } = authenticatable;

    state.name = name;
    state.email = email;
  },
};

const actions = {
  signin({ commit }, authenticatable) {
    commit('signin', authenticatable);
  },
  signout({ commit }) {
    commit('signout');
  },
  update({ commit }, authenticatable) {
    commit('signin', authenticatable);
  },
};

export default {
  state: initialState,
  getters,
  mutations,
  actions,
};
