const state = () => ({
  questions: [
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
  ],
});

const getters = {
  questions: (state) => state.questions,
};

const mutations = {
  updateAnswer(state, { indexNum, answerState }) {
    const index = state.questions.findIndex((question) => question.num === indexNum);
    //配列内の指定されたテスト関数を満たす最初の要素の位置を返す
    state.questions[index].answer = answerState;
  },
};
export default {
  namespaced: true,
  state,
  getters,
  mutations,
};
