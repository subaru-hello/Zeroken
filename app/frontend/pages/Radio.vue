<template>
  <v-row justify="center" align-content="center">
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
              class="text-center mx-auto my-5 form"
              elevation="2"
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
              <v-radio-group :id="'smallq' + question.num" mandatory row class="mx-16 px-9">
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
              <!-- </v-col> -->
              <p class="py-3" style="font-size: 16px">あなたの回答： {{ question.answer }}</p>
              <!-- <p v-if="radios != null "><span></span>ここ</p> -->
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
      <span></span>未回答の項目があります。
    </p>
  </v-row>
</template>

<script>
import axios from '../plugins/axios';
import { mapGetters, mapMutations, mapActions } from 'vuex';
export default {
  data() {
    return {
      alcohols: [],
    };
  },
  methods: {
    ...mapGetters('question', ['questions']),
    ...mapGetters('analyze', ['analyzes']),
    ...mapGetters('users', ['authUser']),
  },
};
</script>
