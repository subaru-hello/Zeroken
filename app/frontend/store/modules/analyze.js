import axios from '../../plugins/axios';
const state = () => ({
  analyzes: {
    total_points: [],
    sake_strongness_types: [],
    next_nomivation_types: [],
  },
});
const getters = {
  analyzes: (state) => state.analyzes,
};

const mutations = {
  //gettersのstateとdataを変更できる唯一のメソッドsetterの役割
  //同期処理を司る
  setAnalyze(state, analyzes) {
    state.analyzes = {
      //①dataのtotal_pointsをcomputedで変化させる必要がある。sumResult= this.total_points
      total_points: analyzes.total_points,
      //②this.resistance_types = (sumResult < 0 ) ? 0 : (sumResult === 0) ? 1 : 2。これをリアクティブに算出し、resistance_typesに格納する。
      sake_strongness_types: analyzes.sake_strongness_types,
      //３つの写真の中から選択してもらう。ページ遷移する必要がない。
      //<tempalate v-if resistance_types === 0>のように、これを三つ作る。
      //３つの写真がisVisibleになるようにし、診断ボタンを押したらそこにポインターが移動するようにする。
      //写真を押したときに、drunk_typesの値が自動で選択されるようにする。
      next_nomivation_types: analyzes.next_nomivation_types,
      //
    };
  },
  addAnalyze: (state, analyze) => {
    const analyzeArray = [];
    analyzeArray.push(analyze.total_points);
    analyzeArray.push(analyze.sake_strongness_types);
    analyzeArray.push(analyze.next_nomivation_types);
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
    try {
      const responseAnalyze = await axios.get('analyzes');

      commit('setAnalyze', responseAnalyze.data);
      return responseAnalyze.data;
    } catch (err) {
      console.log(err);
      return nil;
    }
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
