<template>
  <div class="phrases">
    <v-container>
      <h1 class="text-center title outer-layer" style="font-size: 40px">ZEROKEN 用語集</h1>
      <h2 class="title outer-layer-title">造語</h2>
      <div v-for="a in lists" :key="a.title" d-flex class="outer-layer">
        <h3>{{ a.title }}</h3>
        <p>{{ a.description }}</p>
      </div>
      <h2 class="title outer-layer-title">お酒の種類</h2>
      <div v-for="b in kinds" :key="b.name" d-flex class="outer-layer">
        <h3>{{ b.name }}</h3>
        <p>{{ b.description }}</p>
      </div>
      <h2 class="title outer-layer-title">酒知識</h2>
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
          title: 'ZEROKEN',
          description: '１軒目の前に使って欲しいという思いからZEROKEN。0軒目から由来している。',
          example: '今度の飲み会ではお酒をあまり飲みたくないな。ZEROKENを使って飲む量を診断してみるか',
        },
        {
          title: '酒ケジュール',
          description: '次の飲み会で飲むお酒の順番',
          example: '酒ケジュール通りに飲みたいから今日はあまり飲めないです。',
        },
        {
          title: 'アルコリズム',
          description: 'アルコールに関するアルゴリズム。アルコール ✖︎ アルゴリズムの略',
          example: '',
        },
        {
          title: '飲みべーション',
          description: '学生言葉。呑み会に向けたモチベーション(士気)を指す。飲みべと略す事が多い。',
          example: '「今飲みべ低いから今回の飲み渋いわ」',
        },
      ],
      knowledges: [
        {
          title: 'TAST',
          description: '東大式ALDH2スクリーニングテストの頭文字を取ったもの。13個の質問に回答するだけでお酒の強さが分かる。東大生が作った。2013年にTwitterで流行ったそう。',
          example: '',
        },
        {
          title: ' アルコール度数 ',
          description: '飲料に対する温度15度の時において原容量百分中に含有するエチルアルコールの容量を指す。%や度を使って表す。',
          example: '',
        },
        {
          title: ' アルコール体内血中濃度 ',
          description: '飲酒して消化管から吸収されたアルコールが血中に移行した状態の濃度で、酔いの程度を決める。血中濃度(%)が「0.02～0.04：爽快期」「0.05～0.10：ほろ酔い期」「0.11～0.15：酩酊初期」「0.16～0.30：酩酊極期」「0.31～0.40：泥酔期」「0.41～：昏睡期」というのが血中濃度と酔いの程度の目安。',
          example: '',
        },
        {
          title: ' 純アルコール量 ',
          description: '酒のラベルには、中に含まれるアルコールの度数が書かれています。 この度数は、体積パーセント(%)を意味します。 度数5または5%のビールとは、100ミリリッター(mL)に、純アルコールが5mL含まれているビールということです。',
          example: '',
        },
        {
          title: '上戸',
          description: '酒を好む人。 また、酒が好きでたくさん飲める人。 酒飲み',
          example: '',
        },
        {
          title: ' 下戸 ',
          description: '体質的に酒やアルコール飲料を飲めない人のこと',
          example: '私は下戸です。これ以上お酒を強要したら訴えますよ。',
        },
        {
          title: ' 酒豪 ',
          description: 'アルコール飲料（酒）を大量に飲むことが出来、さらにこれで酔態をさらさない者の俗称',
          example: '',
        },
        {
          title: ' 和み水',
          description: '日本酒を飲みながら飲む水のこと。洋酒だとチェイサーと呼ばれたりもする。',
          example: '',
        },
        {
          title: '醸造酒',
          description: '穀類や果実などを発酵させて作るお酒。日本酒、ビール、ワインなどが該当する',
          example: '',
        },
        {
          title: '混合酒',
          description: '既製の酒に糖分，アルコール，果実，香味料あるいは薬料などを加えて造った再製酒。 最も代表的なものに日本の梅酒，ヨーロッパのリキュールなどがある',
          example: '',
        },
        {
          title: '蒸留酒',
          description: '醸造酒を蒸留して作った酒。焼酎、ウォッカ、ブランデー、ウィスキー、スピリッツなどが該当する。',
          example: '',
        },
      ],
      kinds: [
        {
          name: 'ファジーネーブル',
          description: 'リキュールベースの甘いカクテル。「桃なのかオレンジなのかわからない曖昧な味」や「桃の産毛」という意味がある。',
        },
        {
          name: 'メガハイ',
          descripption: 'ハイボールのメガサイズ。某焼き鳥チェーンに行くと頼む事ができる。コスパ良く飲みたい方におすすめ。',
        },
        {
          name: 'メガ金麦',
          descripption: '金麦のメガサイズ。SUNTORYの提供する金麦が700ml入っている。',
        },
        {
          name: 'ジンバック',
          descripption: 'ジンをジンジャエールで割ったライム風味のお酒。甘味と酸味がいい塩梅で配合されている。コスパ良く酔いたい時におすすめ。',
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
.outer-layer-title {
  background-color: rgb(0,0,0,0.6);
  color: white;
  padding: 0.5em 1em;
  margin: 2em 0;
  font-weight: bold;
  border: solid 3px #000; /*線*/
  border-radius: 10px; /*角の丸み*/
}
</style>
