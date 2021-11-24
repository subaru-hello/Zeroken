<template>
  <v-container>
    <p>{{ test }}</p>
    <table>
      <th>ITEM</th>
      <th>VALUE</th>
      <tr v-for="(value, name) in userAll" :key="name">
        <td>
          {{ name }}
        </td>
        <td>
          {{ value.nickname }}
        </td>
      </tr>
    </table>
  </v-container>
</template>
<script>
import axios from '../plugins/axios';
// import { mapGetters } from 'vuex';
export default {
  data() {
    return {
      userAll: [],
      analyzeAll: [],
    };
  },
  computed: {
    test() {
      let orders = {
        first_orders: [
          {
            id: 10,
            name: '和み水',
            description:
              '日本酒のお供に飲む水。日本酒は他のお酒と違ってお湯割りやソーダ割りができない。',
            alcohol_percentage: 0.0,
            alcohol_amount: 350,
          },
          {
            id: 11,
            name: '氷',
            description:
              '炭酸系の酒を飲み終わった後の残骸。溶けると水になるため、お酒の濃度を薄めてくれる。お口が寂しい時は舐めよう。',
            alcohol_percentage: 0.0,
            alcohol_amount: 350,
          },
          {
            id: 1,
            name: 'ビール',
            description:
              '「醸造酒」の一つ。とりあえずビールでお馴染みのビール。乾杯、そしてキンキンに冷えたビールを流し込もう。',
            alcohol_percentage: 5.01,
            alcohol_amount: 350,
          },
          {
            id: 13,
            name: 'ウーロンハイ',
            description:
              '焼酎を烏龍茶で割ったお酒。あまり酔いたくないが、場の雰囲気的にお酒は口に運んでおいた方が無難だよなと判断した時に頼むことが多い。好き嫌いが分かれる。',
            alcohol_percentage: 5.03,
            alcohol_amount: 350,
          },
          {
            id: 14,
            name: '緑茶ハイ',
            description:
              '焼酎を緑茶で割ったお酒。炭酸が苦手な方におすすめ。これを頼む人は将来成功する人が多いと噂だ。',
            alcohol_percentage: 5.04,
            alcohol_amount: 350,
          },
          {
            id: 8,
            name: 'レモンサワー',
            description:
              '「混成酒」の一つ。某有名男性ダンスグループに飲まれているお酒。お店によって度数の変動が激しい。',
            alcohol_percentage: 5.05,
            alcohol_amount: 350,
          },
        ],
      };
      let first_order = orders['first_orders'];

      let numberSelected = [];
      for (let i = 0; i < 5; i++) {
        numberSelected.push(
          first_order[i]['alcohol_percentage'] * first_order[i]['alcohol_amount']
        );
      }
      let dd = numberSelected[3];
      return dd;
    },
  },
  created() {},
  mounted() {
    axios.get('/users').then((userResponse) => (this.userAll = userResponse.data));
    axios.get('/analyzes').then((analyzeResponse) => (this.analyzeAll = analyzeResponse.data));
  },
  methods: {},
};
</script>
