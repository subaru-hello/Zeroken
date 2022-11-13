import Vue from 'vue';
import Router from 'vue-router';
import store from '../store/index';
import Analyze from '../pages/Analyze';
import Result from '../pages/Result';
import UserProfile from '../pages/UserProfile.vue';
import UserRegister from '../pages/UserRegister';
import ZerokenTop from '../pages/ZerokenTop';
import UserLogin from '../pages/UserLogin';
import Phrases from '../pages/Phrases';
import Term from '../pages/Term';
import PrivacyPolicy from '../pages/PrivacyPolicy';
import LiquorsIndex from '../components/ecosystems/liquors/index';
Vue.use(Router);

const router = new Router({
  mode: 'history',
  base: process.env.BASE_URL,
  routes: [
    {
      path: '/',
      component: ZerokenTop,
      name: 'ZerokenTop',
    },
    {
      path: '/liquors',
      component: LiquorsIndex,
      name: 'LiquorsIndex',
    },
    {
      path: '/term',
      component: Term,
      name: 'Term',
    },
    {
      path: '/policy',
      component: PrivacyPolicy,
      name: 'PrivacyPolicy',
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
      meta: { requireAuth: true },
    },
    {
      path: '/phrases',
      component: Phrases,
      name: 'Phrases',
    },
    {
      path: '/profile',
      component: UserProfile,
      name: 'UserProfile',
      meta: { requireAuth: true },
      props: true,
    },
    {
      path: '/result',
      component: Result,
      name: 'Result',
      meta: { requireAuth: true },
    },
  ],
  scrollBehavior(to, from, savedPosition) {
    if (savedPosition) {
      return savedPosition;
    } else {
      return { x: 0, y: 0 };
    }
  },
});

router.beforeEach((to, from, next) => {
  if (to.matched.some((record) => record.meta.requireAuth)) {
    store.dispatch('users/fetchAuthUser').then((authUser) => {
      if (!authUser) {
        next({ name: 'UserLogin' });
      } else {
        next();
      }
    });
  } else {
    next();
  }
});

export default router;
