import axios from '../../plugins/axios';
import router from '../../router/index';
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
  loginUser({ commit }, user) {
    axios
      .post('sessions', user) //createアクション実行
      .then((res) => {
        commit('setAuthUser', res.data);
        router.push({ name: 'PreliquoTop' });
        alert('ログインに成功しました');
      })
      .catch((err) => console.log(err));
  },
  logoutUser({ commit }) {
    axios
      .delete('sessions') //destroyアクション実行
      .then(() => {
        commit('setAuthUser', null);
        alert('ログアウトしました');
      })
      .catch(() => alert('ログアウトに失敗しました'));
  },
  async fetchAuthUser({ commit, state }) {
    if (state.authUser) return state.authUser;
    const userResponse = await axios.get('users/tell_on');
    // if (!userResponse) return null;
    commit('setAuthUser', userResponse.data);
    return userResponse.data;
  },
};

export default {
  namespaced: true,
  state,
  getters,
  mutations,
  actions,
};
