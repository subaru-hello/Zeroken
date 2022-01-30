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
  async updateAnalyze({ commit }, analyze_result) {
    try {
      const analyzeResponse = await axios.patch(`analyze_results/${analyze_result.id}`, {
        analyze_result: analyze_result,
      });
      commit('setAnalyzes', analyzeResponse.data);
      return analyzeResponse.data;
    } catch (err) {
      console.log(err);
      return nil;
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
