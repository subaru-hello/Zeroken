module SumResult
  extend ActiveSupport::Concern
  def total_points(point)
    dd = point
    array = []
    sum = 0
    dd.each_with_index do |answer,i| 
        array << answer[i] 
      # "Point_#{i}" = Answer.find("answered_#{i}").point
      # sum += "Point_#{i}"
    end

    alcohol_strongness = 0

    case total_points = sum 
    when total_points > 3
     alcohol_strongness = 4
    when total_points > 0
     alcohol_strongness =  3
    when total_points > -3
      alcohol_strongness = 1
    when total_points < -3
      alcohol_strongness =  0
    else 
      alcohol_strongness =  2
    end


#アルコール総量に応じて取得するアルコールを抽出する
# 30	40	1200
# 60	12	720
# 180	15	2700
# 90	25	2250
# 100	10	1000
# 180	15	2700
# 350	7	2450
# 350	6	2100
# 350	5	1750
# 350	3	1050
# 700	7	4900

    case alcohol_strongness
    when alcohol_strongness < 1500
      #Alcohol.allから4つアルコールを取得する。
      #どうやってアルコールをDBから取得する？Alcoholコントローラーに値を渡して、値がまるまるだった場合、配列に４つ入れるって感じ?
     dd = Alcohol.find(sum)
     #4つの数字が入る
     array = []
     #arrayに入った数字をAlcoholDBから取得し、@alcoholsにjson形式で渡してviewに表示させる
      if 2000
        dd.map {|a| array << a.non_alcohol} 
        dd.map {|a| array << a.amount_1050} 
        dd.map {|a| array << a.amount_1750} 
        dd.map {|a| array << a.amount_2250} 
      if 3000
        dd.map {|a| array << a.non_alcohol} 
        dd.map {|a| array << a.amount_1050} 
        dd.map {|a| array << a.amount_1750} 
        dd.map {|a| array << a.amount_2250} 
      if 4000
        dd.map {|a| array << a.non_alcohol} 
        dd.map {|a| array << a.amount_1050} 
        dd.map {|a| array << a.amount_1750} 
        dd.map {|a| array << a.amount_2250} 
      #1500ビール一口,0,0,0
      #2000ビール,0,1050,0
      #2500ビール,0,1750,0
      #3000ビール,0,0,0
      #3500ビール,0,0,0
      #4000ビール,0,0,0
      #4500ビール,0,0,0
      #5000ビール,0,0,0
      #5500ビール,0,0,0
      #6000ビール,0,0,0
      #6500ビール,0,0,0
      #7000ビール,0,0,0
      #7500ビール,0,0,0
      #8000ビール,0,0,0
      #8500ビール,0,0,0
      #9000ビール,0,0,0
      #9500ビール,0,0,0
      #10000ビール,0,0,0
      #10500ビール,0,0,0
      #11000ビール,0,0,0
      #11500ビール,0,0,0
      #12000ビール,0,0,0
      #12500ビール,0,0,0

    #配列に入っている13個のpointを合計するメソッド
end
end
