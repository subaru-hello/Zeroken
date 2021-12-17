<template>
  <transition name="modal">
    <div @click="closeCertificate" v-click-outside="closeCertificate">
      <div class="modal-mask">
        <div class="modal-certificatewrapper">
          <div class="modal-certificate-container" style="width: 400px; height: 400px">
            <div class="modal-body">
              <slot name="body">
                <p class="text-center outer-layer">下戸証明書</p>
                <div class="d-flex">
                  <img :src="nonAlcohol" width="100" height="100" />
                  <p class="text-center mt-5">
                    私にお酒を強要したら<br />
                    <span style="color: red">アルハラ</span><br />
                    で訴えます。
                  </p>
                  <br />
                </div>
                <p class="text-center">おすすめの酒ケジュール</p>
                <br />
                <div class="d-flex text-center justify-space-between">
                  <div>
                    <v-icon>mdi-glass-mug</v-icon>
                    <p>ビール一口</p>
                  </div>
                  <div>
                    <v-icon>mdi-cup</v-icon>
                    <p>水</p>
                  </div>
                  <div>
                    <v-icon>mdi-cup</v-icon>
                    <p>水</p>
                  </div>
                  <div>
                    <v-icon>mdi-cup</v-icon>
                    <p>水</p>
                  </div>
                </div>
              </slot>
            </div>

            <div class="modal-footer">
              <div class="d-flex text-center justify-space-between">
                <p>有効期限 {{ date }}</p>
                <v-btn
                  class="modal-default-button"
                  @click="closeCertificate"
                  v-click-outside="closeCertificate"
                >
                  納めました
                </v-btn>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </transition>
</template>

<script>
export default {
  props: {
    nonAlcoholImg: {
      type: String,
    },
    expirationDate: {
      type: String,
    },
  },
  data() {
    return {
      nonAlcohol: this.nonAlcoholImg,
      date: this.expirationDate,
    };
  },
  methods: {
    closeCertificate() {
      this.$emit('closeCertificate');
    },
  },
};
</script>

<style>
.modal-enter {
  opacity: 0;
}

.modal-leave-active {
  opacity: 0;
}

.modal-enter .modal-leave-active {
  -webkit-transform: scale(1.1);
  transform: scale(1.1);
}
.modal-mask {
  position: fixed;
  z-index: 8;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5);
  display: flex;
  align-items: center;
  justify-content: center;
  transition: opacity 0.3s ease;
}

.modal-wrapper {
  display: table-cell;
  vertical-align: middle;
}
.modal-certificate-container {
  width: 300px;
  margin: 0px auto;
  padding: 20px 30px;
  background-color: #fff;
  border-radius: 2px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.33);
  transition: all 0.3s ease;
  font-family: Helvetica, Arial, sans-serif;
}
.modal-certificate-wrapper {
  width: 300px;
  margin: 0px auto;
  padding: 20px 30px;
  /* background-image: url(../../src/img/woodtile.jpeg) ; */
  border-radius: 2px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.33);
  transition: all 0.3s ease;
  font-family: Helvetica, Arial, sans-serif;
}
.modal-body {
  margin: 20px 0;
}

.modal-default-button {
  float: right;
}
.outer-layer {
  padding: 0.5em 1em;
  margin: 2em 0;
  font-weight: bold;
  border: solid 3px #000; /*線*/
  border-radius: 10px; /*角の丸み*/
}
</style>
