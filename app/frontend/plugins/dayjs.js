import dayjs from 'dayjs';
import 'dayjs/locale/ja';
dayjs.locale('ja');

export default {
  methods: {
    $dateFormat(date) {
      return dayjs(date).format('YYYY年M月D日(dd)');
    },
  },
};
