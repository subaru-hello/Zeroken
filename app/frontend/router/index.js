import Vue from 'vue';
import Router from 'vue-router';

import UserRegister from '../pages/UserRegister';
import PreliquoTop from '../pages/PreliquoTop';
import UserLogin from '../pages/UserLogin.vue';
Vue.use(Router);

const router = new Router({
  mode: 'history',
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
  ],
});

export default router;
