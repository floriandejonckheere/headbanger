const initialState = {
  authenticatable: {
    id: null,
    name: null,
    email: null,
  },
};

const getters = {
  authenticated(state) {
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
  signin(context, authenticatable) {
    context.commit('signin', authenticatable);
  },
  signout(context) {
    context.commit('signout');
  },
};

export default {
  state: initialState,
  getters,
  mutations,
  actions,
};
