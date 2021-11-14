import axios from '../../plugins/axios';
const state = () => ({
  alcohols: {
    name: [],
    alcohol_percentage: [],
    alcohol_amount: [],
    pure_alcohol_intake: [],
    description: [],
  },
});
const getters = {
  alcohols: (state) => state.alcohols,
};

const mutations = {
  setAlcohols: (state, alcohols) => (state.alcohols = alcohols),
};

const actions = {
  async fetchAlcohols({ commit }) {
    const response = await axios.get('alcohols');
    commit('setAlcohols', response.data);
    return response.data;
  },
};

export default {
  namespaced: true,
  state,
  getters,
  mutations,
  actions,
};
