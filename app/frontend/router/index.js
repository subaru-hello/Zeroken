import Vue from 'vue';
import Router from 'vue-router';

import Analyze from '../pages/Analyze'
import UserRegister from '../pages/UserRegister';
import PreliquoTop from '../pages/PreliquoTop';
import UserLogin from '../pages/UserLogin';
Vue.use(Router);

const router = new Router({
  mode: 'history',
  routes: [
    {
      path: '/api',
      component: PreliquoTop,
      alias: '/',
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
   
  ],
});

export default router;
