import axios from '../../plugins/axios';
const state = {
  tast_answers: [
    {
      face_flush: '',
      other_than_face_flush: '',
      itchy: '',
      dizy: '',
      drowsy: '',
      anxiety: '',
      headache: '',
      throbbing_headache: '',
      sweating: '',
      heartbeating: '',
      nauseous: '',
      chill: '',
      breathless: '',
      weight: '',
      next_motivation: '',
    },
  ],
};
const getters = {
  tast_answers: (state) => state.tast_answers,
};

const mutations = {
  setTastAnswers: (state, tast_answers) => (state.tast_answers = tast_answers),

  addTastAnswer: (state, tast_answer) => {
    //{selected_choices_1のように入っている}
    tastAnswerArray =[]
    for (const [key, value] of Object.entries(tast_answer)) {
      tastAnswerArray.push(value);
    }
    state.tast_answers = tastAnswerArray;
  },
};

const actions = {
  async fetchTastAnswers({ commit }) {
    const response = await axios.get('tast_answers');
    commit('setTastAnswers', response.data);
    return response.data;
  },
  async createTastAnswer({ commit }, tast_answer) {
    try {
      const TastAnswerResponse = await axios.post('tast_answers', {
        tast_answer: tast_answer,
      });
      commit('addTastAnswer', TastAnswerResponse.data);
      return TastAnswerResponse.data;
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
