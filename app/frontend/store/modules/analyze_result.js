import axios from '../../plugins/axios';
const state = {
  analyze_results: [
    {
      next_motivation: '',
      description: '',
      total_alcohol_amounts: '',
      alcohol_strongness: '',
      user_id: '',
    },
  ],
};
const getters = {
  analyze_results: (state) => state.analyze_results,
};

const mutations = {
  setAnalyzes: (state, analyze_results) => (state.analyze_results = analyze_results),

  addAnalyze: (state, analyze_result) => {
    const analyzeArray = [];
    analyzeArray.push(analyze_result.next_motivation);
    analyzeArray.push(analyze_result.weight);
    analyzeArray.push(analyze_result.user_id);
    state.analyze_results = analyzeArray;
  },
  updateAnalyze: (state, updateAnalyze) => {
    const index = state.analyze_results.findIndex((analyze) => analyze.id === updateAnalyze.id);
    if (index !== -1) {
      state.analyze_results.splice(index, 1, updateAnalyze);
    }
  },
};

const actions = {
  async fetchAnalyzes({ commit }) {
    const response = await axios.get('analyze_results');
    commit('setAnalyzes', response.data);
    return response.data;
  },
  async createAnalyze({ commit }, analyze_result) {
    try {
      const analyzeResponse = await axios.post('analyze_results', {
        analyze_result: analyze_result,
      });
      commit('addAnalyze', analyzeResponse.data);
      return analyzeResponse.data;
    } catch (err) {
      console.log(err);
      return nil;
    }
  },
  async updateAnalyze({ commit }, updateAnalyze) {
    const response = await axios.put(`analyze_results/${updatedAnalyze.id}`, updateAnalyze);
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
