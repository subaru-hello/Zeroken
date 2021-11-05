const state = {
  //置いておきたいデータを書き込む
  data: { msg: '', color: '', isShow: '' },
};
const getters = {
  //データにアクセスするための場所を提供する。snackbarDataという関数を用意
  snackbarData: (state) => state.data,
};
const mutations = {
  //gettersのstateとdataを変更できる唯一のメソッドsetterの役割
  setData(state, data) {
    state.data = { msg: data.msg, color: data.color, isShow: data.isShow };
  },
};
const actions = {
  //mutationの値を変更できる唯一のメソッド。
  //1引数commitに２引数のdataを渡すことでmutationの値を変更している。
  fetchSnackbarData({ commit }, data) {
    commit('setData', data);
  },
};

export default {
  namespaced: true,
  state,
  getters,
  mutations,
  actions,
};
