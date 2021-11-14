import axios from '../../plugins/axios';
const state = {
  authUser: null,
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
      //axiosを通して非同期post。data内のuserをuserに入れてstore/module/index.jsのpost通信をしている。
      commit('setAuthUser', userResponse.data);
      //mutationのsetAuthUserにコミットしている。axiosのレスポンスデータをsetAuthUserに渡している。
      return userResponse.data;
      //userResponse.dataを取得している。
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
    const userResponse = await axios.get('users/tell_on');
    if (!userResponse) return null;
    commit('setAuthUser', userResponse.data);
    return userResponse.data;
  },

  async updateAuthUser({ commit }, authUser) {
    try {
      const res = await axios.patch('profile', authUser);

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
