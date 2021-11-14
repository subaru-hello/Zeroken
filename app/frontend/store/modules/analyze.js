import axios from '../../plugins/axios';
const state = {
  analyzes: {
    total_points: '',
    sake_strongness_types: '',
    next_nomivation_types: '',
    description: '',
  },
};
const getters = {
  analyzes: (state) => state.analyzes,
};

const mutations = {
  setAnalyzes: (state, analyzes) => (state.analyzes = analyzes),

  addAnalyze: (state, analyze) => {
    const analyzeArray = [];
    analyzeArray.push(analyze.total_points);
    analyzeArray.push(analyze.sake_strongness_types);
    analyzeArray.push(analyze.next_nomivation_types);
    analyzeArray.push(analyze.description);
    state.analyzes = analyzeArray;
  },
  updateAnalyze: (state, updAnalyze) => {
    const index = state.analyzes.findIndex((analyze) => analyze.id === updAnalyze.id);
    if (index !== -1) {
      state.analyzes.splice(index, 1, updAnalyze);
    }
  },
};

const actions = {
  async fetchAnalyzes({ commit }) {
    const response = await axios.get('analyzes');
    commit('setAnalyzes', response.data);
    return response.data;
  },
  async createAnalyze({ commit }, analyze) {
    try {
      const analyzeResponse = await axios.post('analyzes', { analyze: analyze });
      commit('addAnalyze', analyzeResponse.data);
      return analyzeResponse.data;
    } catch (err) {
      console.log(err);
      return nil;
    }
  },
  async updateAnalyze({ commit }, updAnalyze) {
    const response = await axios.put(`analyzes/${updAnalyze.id}`, updAnalyze);
    commit('updateAnalyze', response.data);
  },
};

export default {
  namespaced: true,
  state,
  getters,
  mutations,
  actions,
};
