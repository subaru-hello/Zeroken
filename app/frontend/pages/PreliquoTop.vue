<template>
     <div>
         <p>酒ジュールを提供します</p>
         <p v-if="!!authUser">ログインしています</p>
    </div>
</template>  

 <script>
    import { mapGetters } from 'vuex';
    export default {
        data(){
            return {};
        },
        computed: {
            ...mapGetters('users', ['authUser']),
        },
    };
  </script>