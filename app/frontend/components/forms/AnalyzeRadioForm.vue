<template>
  <v-row justify="center" align-content="center">
    <h2 class="ma-5 white--text rounded bold" style="background: rgba(51, 112, 121, 0.4)">
      お酒を飲んでいる時の状態を選択してください(13項目)
    </h2>
    <v-col
      v-for="question in questions"
      :key="question.num"
      cols="12"
      xs="12"
      sm="12"
      md="12"
      lg="12"
    >
      <v-layout justify-center>
        <v-card-title>
          <v-container>
            <v-card
              class="text-center mx-auto my-5 form rounded"
              style="border-radius: 50%"
              elevation="24"
              shaped
              width="500"
              id="form"
            >
              <v-card-title
                style="width: 100% white-space:pre-wrap;"
                class="headline justify-center"
                :id="'bigq' + question.num"
              >
                Q{{ question.num }}.
                {{ question.title }}
              </v-card-title>
              <v-radio-group :id="'smallq' + question.num" row class="mx-16 px-9">
                <v-radio
                  class="mx-auto justify-center"
                  fab
                  light
                  :ripple="{ center: false, class: 'gray--text' }"
                  @click="
                    clickScroll($event);
                    countAnswer(question.num, 1);
                  "
                  label="1: いつも"
                ></v-radio>
                <v-radio
                  class="mx-auto justify-center"
                  fab
                  light
                  :ripple="{ center: false, class: 'gray--text' }"
                  @click="
                    clickScroll($event);
                    countAnswer(question.num, 2);
                  "
                  label="2: 時々"
                ></v-radio>
                <v-radio
                  class="mx-auto justify-center"
                  fab
                  light
                  :ripple="{ center: false, class: 'gray--text' }"
                  @click="
                    clickScroll($event);
                    countAnswer(question.num, 3);
                  "
                  label="3: 全くない"
                ></v-radio>
              </v-radio-group>
              <p v-if="question.answer === '未回答'">
                <strong class="red--text accent-3">未回答です！</strong>
              </p>
              <p class="py-3" style="font-size: 16px">あなたの回答： {{ question.answer }}</p>
            </v-card>
          </v-container>
        </v-card-title>
      </v-layout>
    </v-col>
    <p class="Page-Btn">
      <v-btn fab dark small color="primary" @click="scrollTop()">
        <v-icon>mdi-arrow-up-thick</v-icon>
      </v-btn>
    </p>
    <p
      v-if="isVisible"
      class="text-center red--text text--lightn-3 my-5 mb-5"
      outlined
      tile
      height="150"
    >
      <span style="background-color: white"></span>未回答の項目があります。
    </p>
  </v-row>
</template>
<script>
export default {
  props: {
    num: {
      type: Number,
      required: true,
    },
    title: {
      type: String,
      required: true,
    },
    answer: {
      type: String,
    },
  },
};
</script>
