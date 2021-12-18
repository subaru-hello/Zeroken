<template>
  <v-container>
    <div>
      <h3>お酒の強さ算出ロジック</h3>
      <v-btn @click="alcholismStrongness = !alcholismStrongness">見る</v-btn>
      <div id="strongness-logic" v-if="alcoholism">
        <div class="d-flex">
          <p>
            TASTという東大生が考案した、お酒の強さをはかる診断を使用しています。2013年にTwitterで拡散され、1.6万リツイートされるほどにバズりました。
          </p>
          <img :src="tastSrc" width="150" height="150" />
        </div>
        <div>
          <p>
            内容: 13項目からなる質問に３択で答えます。
            各項目にポイントがあり、ポイント合計が正の値だった場合は酒豪、0だったら普通、負の値だった場合は下戸という診断結果が出るようになっています。
            ZEROKENでは、より厳密に判断するために、「やや酒豪」「やや下戸」を追加しています。
          </p>
        </div>
      </div>
      <h3>酔い度合い算出ロジック</h3>
      <v-btn @click="alcoholismDrunkness = !alcoholismDrunkness">見る</v-btn>
      <div id="drunkness-logic" v-if="alcoholismDrunkness">
        <div class="d-flex">
          <p>
            厚生労働省が用意しているデータを参考にして「酔いたい状態になるまでに必要なお酒の量」を算出しています。
          </p>
          <img :src="drunknessSrc" width="150" height="150" />
        </div>
        <p>「酔い」というものは、血中アルコール濃度に応じて状態が変わってきます。</p>
        <p>
          ZEROKENでは、下記のような構成でアルコール血中濃度と、「しっぽり・ほろ酔い・酩酊」をそれぞれ紐づけています。
        </p>
      </div>
    </div>
  </v-container>
</template>
