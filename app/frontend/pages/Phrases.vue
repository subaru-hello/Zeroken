<template>
  <div>
    <v-container>
      <v-title> ZEROKEN 用語集 </v-title>
      <div d-flex>
        <h2>造語</h2>
        <h3>ZEOKEN</h3>
        <p>１軒目の前に使って欲しいという思いからZEROKEN。0軒目から由来している。</p>
        酒ケジュール 次の飲み会で飲むお酒の順番 酒テータス
        ユーザーのお酒の強さと過去の酒ケジュールを指す。 アルコリズム アルコールに関するアルゴリズム
        ゼロケン
        本アプリ名。一軒目に行く前に診断して欲しいという意味を込めて名付けた。0軒目から取ってゼロケン。
        飲みべーション 学生言葉。呑み会に向けたモチベーション(士気)を指す。
        「今飲みべ低いから今回の飲み渋いわ」
      </div>
      <div d-flex>
        <h3>酒ケジュール</h3>
        <p>「お酒の順番 + スケジュール」を掛け合わせた造語。</p>
      </div>
      <div d-flex>
        <h2>お酒の種類</h2>
        <h3>ZEOKEN</h3>
        <p></p>
        酒知識 TAST アルコール度数 アルコール体内血中濃度 純アルコール量 上戸、下戸 酒豪 和み水
        醸造酒 混合酒 蒸留酒 ファジーネーブル メガハイ メガ金麦 ジンバック
      </div>
      <div d-flex>
        <h2>その他</h2>
        <h3>ZEOKEN</h3>
        <p></p>
      </div>
      <v-row class="text-center d-flex justify-space-around">
        <v-col cols="3" sm="10" md="12" lg="12">
          <v-btn @click="dialog1 = true">酒(シュ)ケジュールとは</v-btn>
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
          <v-btn @click="dialog2 = true">飲みベーションとは</v-btn>
          <v-dialog v-model="dialog2" scrollable max-width="80%" transition="dialog-top-transition">
            <v-card>
              <v-card-title class="text-h5 grey lighten-2">飲みベーションとは</v-card-title>
              <v-divider></v-divider>
              <v-card-text>次の飲み会に向けたモチベーションを意味しています。</v-card-text>
              <v-card-text>「飲み + ステータス」の造語です。</v-card-text>
              <v-card-text>使用例 「飲みべ低いので今日は帰ります。。」</v-card-text>
            </v-card>
          </v-dialog>
          <v-btn @click="dialog3 = true">酒テータスとは</v-btn>
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
    };
  },
};
</script>

<style>
#izakaya {
  background: url(../src/img/beer.jpeg) center center / cover no-repeat fixed;
}
</style>
