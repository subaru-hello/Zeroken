<template>
  <div class="phrases">
    <v-container>
      <h1 class="text-center title outer-layer" style="font-size: 25px">ZEROKEN 用語集</h1>
      <h2 class="title outer-layer">造語</h2>
      <div v-for="a in lists" :key="a.title" d-flex class="outer-layer">
        <h3>{{ a.title }}</h3>
        <p>{{ a.description }}</p>
      </div>
      <h2 class="title outer-layer">お酒の種類</h2>
      <div v-for="b in kinds" :key="b.name" d-flex class="outer-layer">
        <h3>{{ b.name }}</h3>
        <p>{{ b.description }}</p>
      </div>
      <h2 class="title outer-layer">酒知識</h2>
      <div v-for="c in knowledges" :key="c.title" d-flex class="outer-layer">
        <h3>{{ c.title }}</h3>
        <p>{{ c.description }}</p>
      </div>
      <v-row class="text-center d-flex justify-space-around">
        <v-col class="d-flex justify-space-between">
          <v-btn @click="dialog1 = true" style="width: 33%">酒ケジュールとは</v-btn>
          <v-dialog v-model="dialog1" scrollable max-width="80%" transition="dialog-top-transition">
            <v-card>
              <v-card-title class="text-h5 grey lighten-2">酒(シュ)ケジュールとは</v-card-title>
              <v-divider></v-divider>
              <v-card-text>次の飲み会でのむお酒の順番を意味しています。</v-card-text>
              <v-card-text>「お酒の順番 + スケジュール」の造語です。</v-card-text>
              <v-card-text
                >使用例
                「酒ケジュールによると次はノンアルを飲む予定になっているのでもうお酒は飲めません。。」</v-card-text
              >
            </v-card>
          </v-dialog>
          <v-btn @click="dialog2 = true" style="width: 33%">飲みベーションとは</v-btn>
          <v-dialog v-model="dialog2" scrollable max-width="80%" transition="dialog-top-transition">
            <v-card>
              <v-card-title class="text-h5 grey lighten-2">飲みベーションとは</v-card-title>
              <v-divider></v-divider>
              <v-card-text>次の飲み会に向けたモチベーションを意味しています。</v-card-text>
              <v-card-text>「飲み + ステータス」の造語です。</v-card-text>
              <v-card-text>使用例 「飲みべ低いので今日は帰ります。。」</v-card-text>
            </v-card>
          </v-dialog>
          <v-btn @click="dialog3 = true" style="width: 33%">酒テータスとは</v-btn>
          <v-dialog v-model="dialog3" scrollable max-width="80%" transition="dialog-top-transition">
            <v-card>
              <v-card-title class="text-h5 grey lighten-2">酒テータスとは</v-card-title>
              <v-divider></v-divider>
              <v-card-text
                >ユーザーのお酒の強さ、そして次の飲み会で飲むお酒の順番を表す状態になります。</v-card-text
              >
              <v-card-text>「お酒 + ステータス」の造語です。</v-card-text>
              <v-card-text
                >使用例: 「私の酒テータス下戸だから飲み会参加できないんです。。」</v-card-text
              >
            </v-card>
          </v-dialog>
        </v-col>
      </v-row>
    </v-container>
  </div>
</template>
<script>
export default {
  data() {
    return {
      dialog3: false,
      dialog1: false,
      dialog2: false,
      lists: [
        {
          title: 'ZEOKEN',
          description: '１軒目の前に使って欲しいという思いからZEROKEN。0軒目から由来している。',
          example: '',
        },
        {
          title: '酒ケジュール',
          description: '次の飲み会で飲むお酒の順番',
          example: '',
        },
        {
          title: 'アルコリズム',
          description: 'アルコールに関するアルゴリズム。アルコール ✖︎ アルゴリズムの略',
          example: '',
        },
        {
          title: '飲みべーション',
          description: '学生言葉。呑み会に向けたモチベーション(士気)を指す。',
          example: '「今飲みべ低いから今回の飲み渋いわ」',
        },
      ],
      knowledges: [
        {
          title: 'TAST',
          description: '',
          example: '',
        },
        {
          title: ' アルコール度数 ',
          description: '',
          example: '',
        },
        {
          title: ' アルコール体内血中濃度 ',
          description: '',
          example: '',
        },
        {
          title: ' 純アルコール量 ',
          description: '',
          example: '',
        },
        {
          title: '上戸',
          description: '',
          example: '',
        },
        {
          title: ' 下戸 ',
          description: '',
          example: '',
        },
        {
          title: ' 酒豪 ',
          description: '',
          example: '',
        },
        {
          title: ' 和み水',
          description: '',
          example: '',
        },
        {
          title: '  醸造酒 ',
          description: '',
          example: '',
        },
        {
          title: ' 混合酒  ',
          description: '',
          example: '',
        },
        {
          title: ' 蒸留酒  ',
          description: '',
          example: '',
        },
      ],
      kinds: [
        {
          name: 'ファジーネーブル',
          descripption: '',
        },
        {
          name: '  メガハイ ',
          descripption: '',
        },
        {
          name: 'メガ金麦 ',
          descripption: '',
        },
        {
          name: 'ジンバック',
          descripption: '',
        },
      ],
    };
  },
};
</script>

<style>
#izakaya {
  background: url(../src/img/beer.jpeg) center center / cover no-repeat fixed;
}
.phrases {
  /* margin-bottom: 20px; */
  background-color: rgba(255, 255, 255, 0.7);
}
.title {
  text-align: center;
}
.outer-layer {
  background: url(../src/img/woodtile.jpeg);
  padding: 0.5em 1em;
  margin: 2em 0;
  font-weight: bold;
  border: solid 3px #000; /*線*/
  border-radius: 10px; /*角の丸み*/
}
</style>
