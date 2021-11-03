import Vue from 'vue';
import Router from 'vue-router';

import Analyze from '../pages/Analyze';
import Sample from '../pages/Sample';
import SelectNomivation from '../pages/SelectNomivation';
import UserRegister from '../pages/UserRegister';
import PreliquoTop from '../pages/PreliquoTop';
import UserLogin from '../pages/UserLogin';
Vue.use(Router);

const router = new Router({
  mode: 'history',
  base: process.env.BASE_URL,
  routes: [
    {
      path: '/',
      component: PreliquoTop,
      name: 'PreliquoTop',
    },
    {
      path: '/login',
      component: UserLogin,
      name: 'UserLogin',
    },
    {
      path: '/register',
      component: UserRegister,
      name: 'UserRegister',
    },
    {
      path: '/analyze',
      component: Analyze,
      name: 'Analyze',
    },
    {
      path: '/nomivation',
      component: SelectNomivation,
      name: 'SelectNomivation',
    },
    {
      path: '/sample',
      component: Sample,
      name: 'Sample',
    },
  ],
});

export default router;
