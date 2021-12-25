import dayjs from 'dayjs';
import 'dayjs/locale/ja';
dayjs.locale('ja');

export default {
  methods: {
    $dateFormat(date) {
      return dayjs(date).format('YYYY年M月D日H時mm分(dd)');
    },
    $dateSevenDaysAgo(date) {
      return dayjs(date).subtract(7, 'days');
    },
  },
};
