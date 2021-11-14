# ZEROKEN(ゼロケン)
### サービス概要

- お酒の強さを診断し、飲み会においてお酒を飲む順番（酒ケジュール）を提供してくれるアプリです。不本意なアルハラ（アルコールハラスメント)を無くします。あなたにとっての0軒目。

### **登場人物**

- 飲みニケーションがしたいが、アルハラはしたくない先輩、上司
- 飲みニケーションはしたいが、そこまでお酒が飲みたくない後輩、部下
- 仕方なく飲み会に参加しているが、飲み会の後にも勉強をしたいので悪酔いをしたくない20代男性

### **ユーザーが抱える問題**

- 飲み会の場は好きだが、ハメを外しすぎない程度の飲酒量で抑えたい。(部下、後輩)
- 飲み会の席でどのくらい相手に飲ませて良いのか心配。(上司、先輩)
- コロナ禍において、飲みニケーションの場が少なくなり、呑みに誘い辛くなった。

### **解決方法**

お酒の強い弱いを診断し、診断結果をもとに飲み会の席で飲むお酒の順番を提供します。

アプリの診断結果を上司(先輩)または部下(後輩)に共有することで、今回はどんな飲み会にしたいか共通認識として持つことができます。それにより、不本意なアルハラが減ることを想定しています。円滑で持続可能な飲みニケーションの場が増える世界にすることができます。

### **プロダクト**

- お酒の強さをアルコリズム(Alchol + Algorism)を使用して診断します。
- アルコリズムにはTAST(東大式ＡＬＤＨ２表現型スクリーニングテスト)というテストを使用します。

(参考文献:ＴＡＳＴ（東大式ＡＬＤＨ２表現型スクリーニングテスト) [https://perseus.blog.ss-blog.jp/2010-03-27](https://perseus.blog.ss-blog.jp/2010-03-27))

- 診断結果（上戸・中戸・下戸）を元に次回の飲み会で飲むお酒の順番を提供します。。
- また、その日の呑みべ（呑む + モチベーション）を選択できる画面を用意します。

    例）

    →「酩酊 or ほろ酔い」

- 診断結果が出た後、今日はどのくらい酔いたいかを二つの項目（酩酊、ほろ酔い）を選択してもらい、次回の飲み会で飲むお酒の順番（酒ケジュール）を提供します。

**酩酊を選んだ場合:** 

「あなたの酒ケジュール」

1st. ビール 2nd.  ウィスキー 3rd. ウィスキー 4th. 日本酒

**ほろ酔いを選んだ場合:**

「あなたの酒ケジュール」

1st. レモンサワー 2nd. コークハイ 3rd. ウーロンハイ 4th. 水

- どのくらい飲んだら酩酊 or ほろ酔いになるかを判断するロジックは、アサヒビールの出している下記表を使います。

(参考文献: アサヒビール [https://www.asahibeer.co.jp/csr/tekisei/health/images/health_3-3.png](https://www.asahibeer.co.jp/csr/tekisei/health/images/health_3-3.png))

### **マーケット**

- 部下（後輩）と円滑なコミュニケーションを取りたいが、不本意なアルハラは避けたい、呑み会を開催しようと思っている上司（先輩)
- 上司(先輩)と円滑な飲みニケーションを取りたいが、そこまでお酒を飲みたくない、飲み会に誘われている部下(後輩)

### **望む未来**

・円滑で健全な飲みニケーションができるようにする。

・部下や上司に使ってもらうことで、このアプリを言い訳に飲む量を調節することができ、不本意なアルハラが無くなる。

### 作成の背景

まず、現在陸上競技を行っていることから、アスリート関連か健康に関するプロダクトを作りたいと考えていました。

その背景で、今回お酒に関するアプリを作りたいと考えた理由は下記３つです。

1. 大学で部活動をしていた時に円滑な飲みニケーションの場が欲しかった。
2. 新卒で入った会社の先輩とどのくらいの距離感で飲めば良いかわからず、飲み会を楽しめなかった時があった。
3. timesで６つくらいポートフォリオの案を出した際に一番スタンプのつけ方が活発だった案がお酒に関するものだった。

### 意図せずアルハラをやっているかも？

下記のように、本人が意図しない形でアルハラが起きているかもしれません。相手がどう思うかでハラスメント認定されるかどうかが決まるので、このアプリを使ってアルハラを予防しましょう。

[https://i.gyazo.com/6c330e2338448ef9a739102308fcb947.png](https://i.gyazo.com/6c330e2338448ef9a739102308fcb947.png)

(参考文献: 公益社団法人アルコール健康医学協会)

### **画面遷移図**
https://www.figma.com/file/ydWLVuN6KiEXfVYLmAkwmo/Preliquo?node-id=0%3A1

### **ER図**
https://drive.google.com/file/d/1FECMOPGzu-3zVXrOmgrfh-DN0jGKao-X/view?usp=sharing
