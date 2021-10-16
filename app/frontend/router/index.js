import Vue from 'vue';
import Router from 'vue-router';

import UserRegister from '../pages/UserRegister'
import TopIndex from '../pages/top/index';
import TaskIndex from '../pages/task/index';

Vue.use(Router);

const router = new Router({
  mode: 'history',
  routes: [
    {
      path: '/',
      component: TopIndex,
      name: 'TopIndex',
    },
    {
      path: '/tasks',
      component: TaskIndex,
      name: 'TaskIndex',
    },
    {
      path: '/register',
      component: UserRegister,
      name: 'UserRegister',
    },
  ],
});

export default router;
