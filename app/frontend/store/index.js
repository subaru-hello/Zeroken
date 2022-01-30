import Vue from 'vue';
import Vuex from 'vuex';
import users from './modules/users';
import tast_answer from './modules/tast_answer';
import analyze_result from './modules/analyze_result';
import snackbar from './modules/snackbar';
import question from './modules/question';

Vue.use(Vuex);

export default new Vuex.Store({
  modules: {
    users,
    snackbar,
    question,
    tast_answer,
    analyze_result,
  },
});
