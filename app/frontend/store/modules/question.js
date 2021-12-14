const DEFAULT_QUESTIONS = [
  {
    num: '1',
    title: '顔が赤くなる',
    answer: '未回答',
  },
  {
    num: '2',
    title: '顔以外が赤くなる',
    answer: '未回答',
  },
  {
    num: '3',
    title: 'かゆくなる',
    answer: '未回答',
  },
  {
    num: '4',
    title: 'めまいがする',
    answer: '未回答',
  },
  {
    num: '5',
    title: '眠くなる',
    answer: '未回答',
  },
  {
    num: '6',
    title: '不安になる',
    answer: '未回答',
  },
  {
    num: '7',
    title: '頭が痛くなる',
    answer: '未回答',
  },
  {
    num: '8',
    title: '頭の中が打つように感じる',
    answer: '未回答',
  },
  {
    num: '9',
    title: '汗をかく',
    answer: '未回答',
  },
  {
    num: '10',
    title: '心臓がドキドキする',
    answer: '未回答',
  },
  {
    num: '11',
    title: '吐き気がする',
    answer: '未回答',
  },
  {
    num: '12',
    title: '寒気がする',
    answer: '未回答',
  },
  {
    num: '13',
    title: '息が苦しくなる',
    answer: '未回答',
  },
];

const state = () => ({
  questions: DEFAULT_QUESTIONS,
});

const getters = {
  questions: (state) => state.questions,
};

const mutations = {
  updateAnswer(state, { indexNum, updAnswer }) {
    const index = state.questions.findIndex((question) => question.num === indexNum);
    state.questions[index].answer = updAnswer;
  },
  clearAnswers(state) {
    //値の参照渡しを行うために、DEFAULT_QUESTIONSをJSON形式に直した後、ハッシュ形式に戻しています。
    var copiedQuestions = JSON.parse(JSON.stringify(DEFAULT_QUESTIONS));
    state.questions = copiedQuestions;
  },

  setQuestions: (state, default_question) => (state.questions = default_question),
};
const actions = {
  fetchQuestions({ commit }) {
    const default_question = DEFAULT_QUESTIONS;
    commit('setQuestions', default_question);
    return default_question;
  },
};
export default {
  namespaced: true,
  state,
  getters,
  mutations,
  actions,
};
