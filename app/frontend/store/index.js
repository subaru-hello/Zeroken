import Vue from 'vue';
import Vuex from 'vuex';
import users from './modules/users';
import alcohol from './modules/alcohol';
import analyze from './modules/analyze';
import snackbar from './modules/snackbar';
import question from './modules/question';

Vue.use(Vuex);

export default new Vuex.Store({
  // eslint-disable-next-line no-undef
  // strict: process.env.NODE_ENV !== 'production',
  modules: {
    users,
    alcohol,
    snackbar,
    question,
    analyze,
  },
});
