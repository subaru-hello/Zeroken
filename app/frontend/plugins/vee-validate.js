import Vue from 'vue';
import axios from './axios';
import {
  ValidationObserver,
  ValidationProvider,
  extend,
  localize,
  setInteractionMode,
} from 'vee-validate';
import ja from 'vee-validate/dist/locale/ja.json';
import {
  required,
  email,
  min,
  max,
  regex,
  confirmed,
  ext,
  size,
  image,
} from 'vee-validate/dist/rules';

localize('ja', ja);
setInteractionMode('blur', () => {
  return { on: ['blur'] };
});
setInteractionMode('change', () => {
  return { on: ['change'] };
});

Vue.component('ValidationProvider', ValidationProvider);
Vue.component('ValidationObserver', ValidationObserver);
extend('required', required);
extend('email', {
  ...email,
  message: '有効なメールアドレスではありません',
});
extend('min', min);
extend('max', max);
extend('regex', regex);
extend('confirmed', confirmed);
extend('ext', {
  ...ext,
  message: '有効なファイル形式はではありません',
});
extend('size', {
  ...size,
  message: 'サイズは10MB以内でなければなりません',
});

extend('image', {
  ...image,
  message: '{_field_}は画像形式で入力してください',
});
extend('isUnique', {
  params: ['column', 'user_id'],
  async validate(value, { column, user_id }) {
    const response = await axios.get('validations/unique', {
      params: {
        [column]: value,
        id: user_id,
      },
    });
    if (response.data != 'exist') {
      return true;
    } else {
      return '{_value_}は既に使われています';
    }
  },
});
