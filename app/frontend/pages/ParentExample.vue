<template>
  <div>
    <!-- <p>Message is: {{ message }}</p>
      <input v-model="message"  
      @inputoo="onInputChild"
      placeholder="edit me"> -->

    <!-- <ChildForm :mesage="message" @inputoo="onInputChild" /> -->
    <!-- <ChildForm v-model="message" />  -->
    <!-- v-modelを使うと子コンポーネントのプロパティで使う名前が強制的にvalueになってしまう -->
    <div>
      <div v-for="(car, index) in cars" :key="index">
        <input type="radio" name="car_selection" v-model="favorite_car" :value="car.value" />{{
          car.label
        }}
      </div>
      <div>
        {{ favorite_car }}
      </div>
      <div>
        <h1>Hello from App.vue</h1>
        <p>parent_num: {{ parentNum }}</p>
        <input v-model="parentNum" placeholder="edit me" />
        <ChildForm :name="parentNum" />

        <!-- <InputModal 
    v-model="message"  name="message" type="text" placeholder="メッセージを入力してください" 
    /> -->
        <InputModal :options="cars" v-model="car" />
        <BaseRadio
          :options="cars"
          name="car_selection"
          :value="favorite_car"
          @input="favorite_car = $event"
        />

        <!-- @で受け取ってvalueで子に渡している。 -->
        <!-- v-model="message"として記述することもできる。 -->
        <!-- <ChildForm  @enlarge-text="postFontSize += $event"> -->
      </div>
    </div>
  </div>
</template>
<script>
import ChildForm from '../components/forms/ChildForm.vue';
import InputModal from '../components/forms/InputModal.vue';
import BaseRadio from '../components/forms/BaseRadio.vue';
export default {
  name: 'ParentExample',
  components: {
    ChildForm,
    InputModal,
    BaseRadio,
  },
  data() {
    return {
      favorite_car: '',
      cars: [
        { label: 'volvo', value: 'volvo' },
        { label: 'saab', value: 'saab' },
        { label: 'mercedes', value: 'mercedes' },
        { label: 'audi', value: 'audi' },
      ],
      message: '',
      lord_num: 100,
      douteki_num: 0,
      parentNum: 100,
      car: 'audi',
    };
  },
  computed: {
    reflectedNum(e) {
      this.parent_num += e;
    },
  },
  methods: {
    oneup(e) {
      this.currentPont += e;
    },
    onInputChild(e) {
      this.message = e;
    },
  },
  messageLog() {
    console.log('parent');
  },
};
</script>
