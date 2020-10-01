const initialState = () => ({
  id: null,
  name: null,
  email: null,
});

const getters = {
  isAuthenticated(state) {
    return state.id !== null;
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
