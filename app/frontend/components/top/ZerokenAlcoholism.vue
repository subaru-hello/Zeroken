<template>
  <div class="black--text about text-center">
    <transition-group tag="div" class="title">
      <span v-for="el in text" :key="el.id" class="item" v-text="el.text" />
    </transition-group>
  </div>
</template>

<script>
export default {
  props: {
    autoplay: Boolean,
  },
  data() {
    return {
      timer: null,
      index: 0,
      // オリジナルメッセージ
      original: [
        'ZEROKENは、あなたが１軒目で飲むお酒の順番を提供するアプリです。お酒の強さを診断する機能や、アルハラ防止機能を搭載しています。',
        'ZEROKENを使うことによって、1軒目では自分のペースでお酒を飲むことができます。お酒は楽しく、節度を持って飲みましょう。',
        '診断で出てきた酒ケジュールや下戸証明書はそのままTwitterで拡散したり、お守りとしてとっておくことができます。',
      ],
      // 分解したメッセージ
      messages: [],
      text: '',
    };
  },
  computed: {
    editor: {
      get() {
        return this.text.map((e) => e.text).join('');
      },
      set(text) {
        this.text = this.convText(text);
      },
    },
  },
  watch: {
    autoplay(val) {
      clearTimeout(this.timer);
      if (val) {
        this.ticker();
      }
    },
  },
  methods: {
    // デモ用のオートタイマー
    ticker() {
      this.timer = setTimeout(() => {
        if (this.autoplay) {
          this.index = this.index < this.messages.length - 1 ? this.index + 1 : 0;
          this.text = this.messages[this.index];
          this.ticker();
        }
      }, 4000);
    },
    // テキストを分解してオブジェクトに
    convText(text) {
      const alms = {};
      const result = text.split('').map((el) => {
        alms[el] = alms[el] ? ++alms[el] : 1;
        return { id: `${el}_${alms[el]}`, text: el };
      });
      return Object.freeze(result); // 監視しない
    },
  },
  created() {
    this.messages = this.original.map((el) => this.convText(el));
    this.text = this.messages[0];
    this.ticker();
  },
};
</script>

<style scoped>
.about {
  margin: 0, auto;
  display: flex;
  align-items: center;
  justify-content: center;
}
.title {
  font-size: 2rem;
}
.item {
  display: inline-block;
  min-width: 0.3em;
}
/* トランジション用スタイル */
.v-enter-active,
.v-leave-active,
.v-move {
  transition: all 1s;
}
.v-leave-active {
  position: absolute;
}
.v-enter,
.v-leave-to {
  opacity: 0;
  transform: translateY(-30px);
}
</style>
