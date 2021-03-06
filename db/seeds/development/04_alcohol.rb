Alcohol.seed(
    {
        name: 'ビール',
        alcohol_percentage: 5.00,
        capacity_per_glass: 350,
        alcohol_amount: 1750,
        description: '「醸造酒」の一つ。とりあえずビールでお馴染みのビール。乾杯、そしてキンキンに冷えたビールを流し込もう。',
        image: File.open('db/fixtures/images/beer.png')
    },
    {
        name: 'ビール(一口)',
        alcohol_percentage: 5.00,
        capacity_per_glass: 10,
        alcohol_amount: 50,
        description: '「醸造酒」の一つ。とりあえずビールの風潮で頼んだはいいがビールがそこまで好きではないあなたへのジャストサイズ。',
        image: File.open('db/fixtures/images/jokki_beer.jpg')
    },
    {
        name: 'ザ・プレミアムモルツ',
        alcohol_percentage: 5.00,
        capacity_per_glass: 350,
        alcohol_amount: 1750,
        description: '「醸造酒」の一つ。きめ細やかな泡。乾杯、そしてキンキンに冷えたビールを流し込もう。',
        image: File.open('db/fixtures/images/premol.jpg')
    },
   {
        name: "赤ワイン",
        alcohol_percentage: 12.00,
        capacity_per_glass: 120,
        alcohol_amount: 1440,
        description: "「醸造酒」の一つ。ヨーロッパで嗜まれている赤葡萄仕立てのお酒。洋風の店に置いてあることが多い、大人の味。肉によく合う。",
        image: File.open('db/fixtures/images/wine_bottle.jpg')
    },
   {
        name: "白ワイン",
        alcohol_percentage: 12.00,
        capacity_per_glass: 120,
        alcohol_amount: 1440,
        description: "「醸造酒」の一つ。ヨーロッパで嗜まれている白葡萄仕立てのお酒。洋風の店に置いてあることが多い、大人の味。魚によく合う。",
        image: File.open('db/fixtures/images/wine_bottle.jpg')
    },
    {
        name: "ジンソーダ",
        alcohol_percentage: 6.00,
        capacity_per_glass: 350,
        alcohol_amount: 2100,
        description: "ジンをソーダで割ったライム風味のお酒。爽やかなライムの香りが特徴。炭酸のシュワシュワと爽快な味わいが特徴。",
        image: File.open('db/fixtures/images/jin_tonic.png')
    },
    {
        name: "ジントニック",
        alcohol_percentage: 5.00,
        capacity_per_glass: 350,
        alcohol_amount: 1750,
        description: "ジンを水で割ったライム風味のお酒。爽やかなライムの香りが特徴。コスパ良く酔いたい時におすすめ。",
        image: File.open('db/fixtures/images/jin_tonic.png')
    },
    {
        name: "ジンバック",
        alcohol_percentage: 5.00,
        capacity_per_glass: 350,
        alcohol_amount: 1750,
        description: "ジンをジンジャエールで割ったライム風味のお酒。甘味と酸味がいい塩梅で配合されている。コスパ良く酔いたい時におすすめ。",
        image: File.open('db/fixtures/images/jin_tonic.png')
    },
    {
        name: "ハイボール",
        alcohol_percentage: 8.00,
        capacity_per_glass: 350,
        alcohol_amount: 2800,
        description: "ウィスキーをソーダ水で割ったお酒。ダイエット中だけど酒は飲みたいという方が好んで飲む。食事の邪魔をしないシンプルな味わい。",
        image: File.open('db/fixtures/images/highball.png')

    },
    {
        name: "ウーロンハイ",
        alcohol_percentage: 3.00,
        capacity_per_glass: 350,
        alcohol_amount: 1050,
        description: "焼酎を烏龍茶で割ったお酒。あまり酔いたくないが、場の雰囲気的にお酒は口に運んでおいた方が無難だよなと判断した時に頼むことが多い。好き嫌いが分かれる。",
        image: File.open('db/fixtures/images/highball.png')
    },
    {
        name: "緑茶ハイ",
        alcohol_percentage: 3.00,
        capacity_per_glass: 350,
        alcohol_amount: 1050,
        description: "焼酎を緑茶で割ったお酒。炭酸が苦手な方におすすめ。これを頼む人は将来成功する人が多いと噂だ。",
        image: File.open('db/fixtures/images/highball.png')
    },
    {
        name: "コークハイ",
        alcohol_percentage: 5.00,
        capacity_per_glass: 350,
        alcohol_amount: 1750,
        description: "ウィスキーをコーラで割ったお酒。美味しく酔いたい時に頼むことが多い。悪酔いに注意が必要だ。",
        image: File.open('db/fixtures/images/highball.png')
    },
    {
        name: "ジンジャーハイ",
        alcohol_percentage: 5.00,
        capacity_per_glass: 350,
        alcohol_amount: 1750,
        description: "ウィスキーをジンジャーエールで割ったお酒。美味しく酔いたい時に頼むことが多い。ウィスキー割界においてコークハイと二大巨頭を張っている。",
        image: File.open('db/fixtures/images/highball.png')
    },
    {
        name: "メガハイボール",
        alcohol_percentage: 7.00,
        capacity_per_glass: 700,
        alcohol_amount: 4900,
        description: "ウィスキーをソーダ水で割ったお酒。ダイエット中だけど酒は飲みたいという方が好んで飲む。コーラやジンジャーエールで割って楽しむことができる。食事の邪魔をしないシンプルな味わい。",
        image: File.open('db/fixtures/images/taru.png')
    },
    {
        name: "ウィスキー(ストレート)",
        alcohol_percentage: 40.00,
        capacity_per_glass: 30,
        alcohol_amount: 1200,
        description: "「蒸留酒」の一つ。ダンディーな雰囲気が漂う大人の飲み物。ウィスキーがお好きでしょ。",
        image: File.open('db/fixtures/images/big_wiskey.png')
    },
    {
        name: "ウィスキー(水割り)",
        alcohol_percentage: 10.00,
        capacity_per_glass: 100,
        alcohol_amount: 1000,
        description: "「蒸留酒」の一つ。ダンディーな雰囲気が漂う大人の飲み物。食事の邪魔をしないシンプルな味わい。",
        image: File.open('db/fixtures/images/wine_bottle.jpg')
    },
    {
        name: "ウィスキー(ロック)",
        alcohol_percentage: 40.00,
        capacity_per_glass: 30,
        alcohol_amount: 1200,
        description: "「蒸留酒」の一つ。ダンディーな雰囲気が漂う大人の飲み物。指で氷を回す方も中にはいる。",
        image: File.open('db/fixtures/images/big_wiskey.png')
    },
    {
        name: "日本酒(冷酒）",
        alcohol_percentage: 15.00,
        capacity_per_glass: 180,
        alcohol_amount: 2700,
        description: "「醸造酒」の一つ。日本発祥のお酒で、海外ではsakeとして楽しまれている。米を発酵させて作ったお酒。",
        image: File.open('db/fixtures/images/nihonshu_in_masu.jpg')
    },
    {
        name: "日本酒(熱燗)",
        alcohol_percentage: 15.00,
        capacity_per_glass: 180,
        alcohol_amount: 2700,
        description: "「醸造酒」の一つ。日本発祥のお酒で、海外ではsakeとして楽しまれている。温めることで米の味わいが一層強まる。",
        image: File.open('db/fixtures/images/sake.svg')
    },
    {
        name: "いも焼酎(ロック)",
        alcohol_percentage: 25.00,
        capacity_per_glass: 90,
        alcohol_amount: 2250,
        description: "「蒸留酒」の一つ。芋を原料にして作られた焼酎。「好きなお酒はいも焼酎です」と言うとおじさんに可愛がられるかも。",
        image: File.open('db/fixtures/images/reishu.png')
    },
    {
        name: "麦焼酎",
        alcohol_percentage: 25.00,
        capacity_per_glass: 90,
        alcohol_amount: 2250,
        description: "「蒸留酒」の一つ。麦を原料にして作られた焼酎。甘い匂いを出す。飲むと酩酊に近づくことができる。",
        image: File.open('db/fixtures/images/reishu.png')
    },
    {
        name: "レモンサワー",
        alcohol_percentage: 5.00,
        capacity_per_glass: 350,
        alcohol_amount: 1750,
        description: "「混成酒」の一つ。某有名男性ダンスグループに飲まれているお酒。お店によって度数の変動が激しい。",
        image: File.open('db/fixtures/images/highball.png')
    },
    {
        name: "男梅サワー",
        alcohol_percentage: 5.00,
        capacity_per_glass: 350,
        alcohol_amount: 1750,
        description: "「混成酒」の一つ。梅干しまるごと粉砕製法で、梅干しのおいしさを余すことなく閉じ込めた梅干しサワー。酸っぱい。",
        image: File.open('db/fixtures/images/otokoume.png')
    },
    {
        name: "濃いめのレモンサワー",
        alcohol_percentage: 7.00,
        capacity_per_glass: 350,
        alcohol_amount: 1750,
        description: "「混成酒」の一つ。レモンサワー専門店で提供されることが多い。度数は高めだが、呑みやすいことに定評がある。",
        image: File.open('db/fixtures/images/highball.png')
    },
    {
        name: "和み水",
        alcohol_percentage: 0,
        capacity_per_glass: 350,
        alcohol_amount: 0,
        description: "日本酒のお供に飲む水。日本酒は他のお酒と違ってお湯割りやソーダ割りができないためチェイサーとして嗜まれている。普通の水。",
        image: File.open('db/fixtures/images/nagomimizu.png')
    },
    {
        name: "氷",
        alcohol_percentage: 0,
        capacity_per_glass: 350,
        alcohol_amount: 0,
        description: "炭酸系の酒を飲み終わった後の残骸。溶けると水になるため、お酒の濃度を薄めてくれる。お口が寂しい時は舐めよう。",
        image: File.open('db/fixtures/images/koori.png')
    },
    {
        name: "水",
        alcohol_percentage: 0,
        capacity_per_glass: 350,
        alcohol_amount: 0,
        description: "お酒のお供に必ず頼もう。体内のアルコール濃度を下げてくれる。二日酔いやアルハラを防止する。",
        image: File.open('db/fixtures/images/softdrink.png')
    },
    {
        name: "水",
        alcohol_percentage: 0,
        capacity_per_glass: 350,
        alcohol_amount: 0,
        description: "飲み会の前、最中、最後に活躍するユーティリティプレイヤー。体内の70%を占めている。もはや人間。",
        image: File.open('db/fixtures/images/softdrink.png')
    },
    {
        name: "水",
        alcohol_percentage: 0,
        capacity_per_glass: 350,
        alcohol_amount: 0,
        description: "上司や先輩に酒を飲まされたら真っ先に飲もう。数十分したら尿意を催す事ができる。血中アルコール濃度を下げよう。",
        image: File.open('db/fixtures/images/softdrink.png')
    },
    {
        name: "水",
        alcohol_percentage: 0,
        capacity_per_glass: 350,
        alcohol_amount: 0,
        description: "飲み会の最初にピッチャーで頼もう。何かと大活躍する。上司の見ていない場所でこっそり飲もう。",
        image: File.open('db/fixtures/images/softdrink.png')
    },
    {
        name: "水",
        alcohol_percentage: 0,
        capacity_per_glass: 350,
        alcohol_amount: 0,
        description: "飲み会の席では水を飲んでも大丈夫な席を確保しよう。水はきっとあなたを助けてくれる。",
        image: File.open('db/fixtures/images/softdrink.png')
    },
    {
        name: "烏龍茶",
        alcohol_percentage: 0,
        capacity_per_glass: 350,
        alcohol_amount: 0,
        description: "堂々と頼もう。まるでウーロンハイを飲んでいるかのように堂々と。",
        image: File.open('db/fixtures/images/ocha.png')
    },
    {
        name: "緑茶",
        alcohol_percentage: 0,
        capacity_per_glass: 350,
        alcohol_amount: 0,
        description: "一番ポピュラーなお茶。チャノキの葉から作った茶のうち、摘み取った茶葉を加熱処理して茶葉中の酵素反応を妨げたもの。",
        image: File.open('db/fixtures/images/ocha.png')
    },
    {
        name: "梅酒",
        alcohol_percentage: 11.50,
        capacity_per_glass: 60,
        alcohol_amount: 690,
        description: "6月頃に収穫される青梅を、蒸留酒（ホワイトリカー、焼酎、ブランデーが一般的）に漬け込むことで作られる混成酒類（アルコール飲料）の一種。甘くて美味しいが意外と度数が高い。飲み過ぎに注意だ。",
        image: File.open('db/fixtures/images/kajitushu.png')
    },
    {
        name: "みかん酒",
        alcohol_percentage: 11.50,
        capacity_per_glass: 60,
        alcohol_amount: 690,
        description: "みかんを蒸留酒（ホワイトリカー、焼酎、ブランデーが一般的）に漬け込むことで作られる混成酒類（アルコール飲料）の一種。甘くて美味しいが意外と度数が高い。飲み過ぎに注意だ。",
        image: File.open('db/fixtures/images/kajitushu.png')
    },
    {
        name: "ファジーネーブル",
        alcohol_percentage: 3.00,
        capacity_per_glass: 350,
        alcohol_amount: 1050,
        description: "リキュールベースの甘いカクテル。「桃なのかオレンジなのかわからない曖昧な味」や「桃の産毛」という意味がある。",
        image: File.open('db/fixtures/images/cocktail.png')
    },
    {
        name: "カクテル",
        alcohol_percentage: 3.00,
        capacity_per_glass: 350,
        alcohol_amount: 1050,
        description: "優しいお酒。お酒は頼んでおかないと場の雰囲気を壊しそう、、と判断した時に頼もう。",
        image: File.open('db/fixtures/images/cocktail.png')
    },
    {
        name: "モスコミュール",
        alcohol_percentage: 5.00,
        capacity_per_glass: 350,
        alcohol_amount: 1750,
        description: "「モスクワのラバ」という意味があり、「ラバに蹴飛ばされたように」効いてくる、強いウォッカベースのカクテル。",
        image: File.open('db/fixtures/images/cocktail.png')
    },
    {
        name: "メガ金麦",
        alcohol_percentage: 5.00,
        capacity_per_glass: 700,
        alcohol_amount: 3500,
        description: "金麦のメガサイズ。“贅沢麦芽”による麦のうまみとバランスの良い後味にこだわった金麦",
        image: File.open('db/fixtures/images/megakinmugi.png')
    },
)
    