<template>
  <v-container>
    <transition name="modal">
      <div @click="closeModal" v-click-outside="closeModal">
        <div class="modal-mask">
          <div class="modal-shuchedule-wrapper">
            <div class="modal-shuchedule-container" style="width: 400px; height: 400px">
              <div class="modal-body">
                <slot name="body">
                  <p class="text-center black--text outer-layer" style="white--text">
                    <img :src="motivationImg" width="50" height="50" />
                    <span class="mb-6">への 酒ケジュール</span>
                  </p>
                  <br />
                  <v-row justify="center" align-content="center">
                    <v-col
                      v-for="data in alcoholItems"
                      :key="data.id"
                      class="justify-space-between outer-layer"
                    >
                      <v-icon>{{
                        data.alcohol_percentage === 0 ? 'mdi-cup' : 'mdi-glass-mug'
                      }}</v-icon>
                      <p>
                        {{ data.name }}
                      </p>
                      <!-- </div>
                               <div> -->
                      <p>{{ data.alcohol_percentage }}%</p>
                      <p>{{ data.alcohol_amount }}ml</p>
                    </v-col>
                  </v-row>
                </slot>
              </div>

              <div class="modal-footer">
                <div class="d-flex text-center justify-space-between">
                  <!-- <p>有効期限 {{ date }}</p> -->
                  <v-btn class="modal-default-button" @click="closeModal"> 共有しました </v-btn>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </transition>
  </v-container>
</template>

<script>
export default {
  props: {
    alcoholDatas: {
      type: Object,
    },
    motivationImg: {
      type: String,
    },
  },
  data() {
    return {
      alcohols: '',
    };
  },
  methods: {
    closeModal() {
      this.$emit('closeModal');
    },
  },
  computed: {
    alcoholItems() {
      const targetAlcohols = (this.alcohols = this.alcoholDatas);
      return targetAlcohols;
    },
  },
};
</script>

<style>
p {
  margin-bottom: 0;
}
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
  vertical-align: middle;
}
.modal-shuchedule-container {
  width: 300px;
  margin: 0px auto;
  padding: 20px 30px;
  border-radius: 2px;
  transition: all 0.3s ease;
}
.modal-shuchedule-wrapper {
  margin: 0px auto;
  background: url(../../src/img/woodtile.jpeg) center center / cover no-repeat fixed;
  border-radius: 2px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.63);
  transition: all 0.3s ease;
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
