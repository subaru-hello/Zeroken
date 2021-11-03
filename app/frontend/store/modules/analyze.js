import axios from '../../plugins/axios';
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
      resistance_types: analyzes.resistance_types,
      //３つの写真の中から選択してもらう。ページ遷移する必要がない。
      //<tempalate v-if resistance_types === 0>のように、これを三つ作る。
      //３つの写真がisVisibleになるようにし、診断ボタンを押したらそこにポインターが移動するようにする。
      //写真を押したときに、drunk_typesの値が自動で選択されるようにする。
      drunk_types: analyzes.drunk_types,
      //
    };
  },
  addAnalyze: (state, analyze) => {
    state.analyzes.push(analyze);
  },
  updateAnalyze: (state, updAnalyze) => {
    const index = state.analyzes.findIndex((analyze) => analyze.id === updAnalyze.id);
    if (index !== -1) {
      state.analyzes.splice(index, 1, updAnalyze);
    }
  },
};

const actions = {
  //mutationの値を変更できる唯一のメソッド。
  //非同期処理を司る
  fetchAnalyzeData({ commit }, analyzes) {
    commit('setAnalyze', analyzes);
  },
  async fetchAnalyzes({ commit }) {
    //analyzeをsetする
    const responseAnalyze = axios
      .get('analyzes')

      .then((res) => {
        commit('setAnalyze', res.data);
      })
      .catch((err) => console.log(err.response));
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
