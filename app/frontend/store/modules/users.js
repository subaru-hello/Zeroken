import axios from '../../plugins/axios';
const state = {
  authUser: '',
};

const getters = {
  authUser: (state) => state.authUser,
};

const mutations = {
  setAuthUser(state, user) {
    state.authUser = user;
  },
};

const actions = {
  async registerUser({ commit }, user) {
    try {
      const userResponse = await axios.post('users', { user: user });
      commit('setAuthUser', userResponse.data);
      return userResponse.data;
    } catch (err) {
      console.log(err);
      return nil;
    }
  },
  async loginUser({ commit }, user) {
    try {
      const userResponse = await axios.post('sessions', user); //createアクション実行
      commit('setAuthUser', userResponse.data);
      return userResponse.data;
    } catch (err) {
      console.log(err);
      return null;
    }
  },
  async loginGuestUser({ commit }, user) {
    try {
      const userResponse = await axios.post('guest_login', user); //createアクション実行
      commit('setAuthUser', userResponse.data);
      return userResponse.data;
    } catch (err) {
      console.log(err);
      return null;
    }
  },
  async logoutUser({ commit }) {
    try {
      const res = await axios.delete('sessions'); //destroyアクション実行
      commit('setAuthUser', null);
      return res;
    } catch (err) {
      console.log(err);
      return null;
    }
  },
  async fetchAuthUser({ commit, state }) {
    if (state.authUser) return state.authUser;
    const userResponse = await axios.get('users/me');
    if (!userResponse) return null;
    commit('setAuthUser', userResponse.data);
    return userResponse.data;
  },

  async updateAuthUser({ commit }, user) {
    try {
      const res = await axios.patch(`users/${user.id}`, { user: user });
      commit('setAuthUser', res.data);
      return res.data;
    } catch (err) {
      console.log(err);
      return null;
    }
  },
};

export default {
  namespaced: true,
  state,
  getters,
  mutations,
  actions,
};
