import Vue from 'vue';
import Vuex from 'vuex';
import users from './modules/users';
import my_shuchedule from './modules/my_shuchedule';
import analyze from './modules/analyze';
import snackbar from './modules/snackbar';
import question from './modules/question';

Vue.use(Vuex);

export default new Vuex.Store({
  modules: {
    users,
    snackbar,
    question,
    my_shuchedule,
    analyze,
  },
});
