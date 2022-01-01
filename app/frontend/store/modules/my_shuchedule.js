import axios from '../../plugins/axios';
const state = {
  my_shuchedules: [
    {
      user_id: '',
      succeed_shuchedule: '',
      succeed_alcohol_strongness: '',
    },
  ],
};
const getters = {
  myShuchedules: (state) => state.my_shuchedules,
};

const mutations = {
  setMyShuchedules: (state, my_shuchedules) => (state.my_shuchedules = my_shuchedules),

  addMyShuchedule: (state, my_shuchedule) => {
    const shucheduleArray = [];
    shucheduleArray.push(my_shuchedule.user_id);
    shucheduleArray.push(my_shuchedule.succeed_shuchedule);
    shucheduleArray.push(my_shuchedule.succeed_alcohol_strongness);
    state.my_shuchedules = shucheduleArray;
  },
  updateMyShuchedule: (state, updateMyShuchedule) => {
    const index = state.my_shuchedules.findIndex(
      (my_shuchedules) => my_shuchedules.id === updateMyShuchedule.id
    );
    if (index !== -1) {
      state.my_shuchedules.splice(index, 1, updateMyShuchedule);
    }
  },
};

const actions = {
  async fetchMyShuchedules({ commit }) {
    const response = await axios.get('my_shuchedules');
    commit('setMyShuchedules', response.data);
    return response.data;
  },
  async createMyShuchedule({ commit }, my_shuchedule) {
    try {
      const myShucheduleResponse = await axios.post('my_shuchedules', {
        my_shuchedule: my_shuchedule,
      });
      commit('addMyShuchedule', myShucheduleResponse.data);
      return myShucheduleResponse.data;
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
