<template>
    <div>
      <div>
          <div>
            <label for= "user[nickname]">ニックネーム</label>
          <input
            id = "user[nickname]"
            v-model ="user.nickname"
            type="text"
          >
          </div>
          <div>
            <label for= "user[email]">メールアドレス</label>
          <input
            id = "user[email]"
            v-model ="user.email"
            type="email"
          >
          </div>
          <div>
            <label for= "user[password]">パスワード</label>
          <input
            id = "user[password]"
            v-model ="user.password"
            type="password"
          >
          </div>
          <div>
            <label for= "user[password_confirmation]">確認用</label>
          <input
            id = "user[password_confirmation]"
            v-model ="user.password_confirmation"
            type="password"
          >
          </div>
          <button @click="registerUser">
            登録する    
          </button>
      </div>
    </div>
</template>
<script>
    export default {
    data(){
        return {
            user: {
                nickname: '',
                email: '',
                password: '',
                password_confirmation: ''
                  }
              }
          },
          methods: {
              registerUser(){
                  this.$axios.post('users',{ user: this.user }) //userデータをpostしている。thisはvmインスタンスを指す。
                    .then(() => alert('新規登録に成功しました'))  //thenで$axios.postが成功した場合の処理を記述。
                    .catch((error) => console.log(error))  //errorが出たらcatchする。
              }
          }
      }
</script>
