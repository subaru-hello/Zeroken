import axios from '../plugins/axios';
const state = {
  analyzes: [
    {
      total_points: '',
      drunk_types: '',
      resistance_types: '',
    },
  ],
};

const getters = {
  analyzeData: (state) => state.analyzes,
};

const mutations = {
  //gettersのstateとdataを変更できる唯一のメソッドsetterの役割
  setAnalyze(state, analyzes) {
    state.analyzes = {
      total_points: analyzes.total_points,
      drunk_types: analyzes.drunk_types,
      resistance_types: analyzes.resistance_types,
    };
  },
  addAnalyze: (state, analyze) => {
    state.analyzes.push(analyze);
  },
};

const actions = {
  //mutationの値を変更できる唯一のメソッド。
  fetchAnalyzeData({ commit }, analyzes) {
    commit('setAnalyze', analyzes);
  },
  fetchAnalyzes({ commit }) {
    axios
      .get('analyzes')
      .then((res) => {
        commit('setAnalyze', res.data);
      })
      .catch((err) => console.log(err.response));
  },
  createAnalyze({ commit }, analyze) {
    return axios.post('analyzes', analyze).then((res) => {
      commit('addAnalyze', res.data);
    });
  },
};

export default {
  namespaced: true,
  state,
  getters,
  mutations,
  actions,
};
