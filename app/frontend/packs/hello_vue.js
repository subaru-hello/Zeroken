import Vue from 'vue';
import App from '../App';
import store from '../store/index';
import router from '../router';
import axiosInstance from '../plugins/axios';
import * as VeeValidate from '../plugins/vee-validate';
import dayjs from '../plugins/dayjs';
import vuetify from '../plugins/vuetify';
import VueI18n from 'vue-i18n';

Vue.use(VueI18n);

const i18n = new VueI18n({
  locale: 'ja', // ← ここを「en」に切り替えれば英語になる
  fallbackLocale: 'ja',
  messages: {
    ja: require('../components/locales/ja.json'),
  },
});

Vue.prototype.$axios = axiosInstance;
Vue.mixin(dayjs);
document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    router,
    i18n,
    vuetify,
    store,
    VeeValidate,
    render: (h) => h(App),
  }).$mount();

  document.body.appendChild(app.$el);

  console.log(app);
});

// The above code uses Vue without the compiler, which means you cannot
// use Vue to target elements in your existing html templates. You would
// need to always use single file components.
// To be able to target elements in your existing html/erb templates,
// comment out the above code and uncomment the below
// Add <%= javascript_pack_tag 'hello_vue' %> to your layout
// Then add this markup to your html template:
//
// <div id='hello'>
//   {{message}}
//   <app></app>
// </div>

// import Vue from 'vue/dist/vue.esm'
// import App from '../app.vue'
//
// document.addEventListener('DOMContentLoaded', () => {
//   const app = new Vue({
//     el: '#hello',
//     data: {
//       message: "Can you say hello?"
//     },
//     components: { App }
//   })
// })
//
//
//
// If the project is using turbolinks, install 'vue-turbolinks':
//
// yarn add vue-turbolinks
//
// Then uncomment the code block below:
//
// import TurbolinksAdapter from 'vue-turbolinks'
// import Vue from 'vue/dist/vue.esm'
// import App from '../app.vue'
//
// Vue.use(TurbolinksAdapter)
//
// document.addEventListener('turbolinks:load', () => {
//   const app = new Vue({
//     el: '#hello',
//     data: () => {
//       return {
//         message: "Can you say hello?"
//       }
//     },
//     components: { App }
//   })
// })
