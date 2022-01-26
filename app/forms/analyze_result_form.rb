class AnalyzeResultForm
  include ActiveModel::Model
  include ActiveRecord::AttributeAssignment
  attr_accessor :alcohol_percentage,
                :alcohol_amount,
                :name,
                :description,
                :image,
                :selected_choices_0,
                :selected_choices_1,
                :selected_choices_2,
                :selected_choices_3,
                :selected_choices_4,
                :selected_choices_5,
                :selected_choices_6,
                :selected_choices_7,
                :selected_choices_8,
                :selected_choices_9,
                :selected_choices_10,
                :selected_choices_11,
                :selected_choices_12,
                :total_alcohol_amounts,
                :next_motivation,
                :explanation
  def initialize(next_motivation = 0, weight = 60, *tast_params)
    @next_motivation = next_motivation
    @weight = weight
  end
  # user_id = current_user.id
  user_id = 1
  tast_answer_array = TastAnswer.where("user_id = #{user_id}").pluck[0][0..12]

  # 選択肢をポイントに変換
  targetArray = tast_answer_array.map.with_index { |arr, i| (3 * i) + arr }

  # 各選択肢に割り振られたポイントを算出
  result = targetArray.map { |n| Answer.find(n + 1).point.to_f }

  # binding.pry
  # 各選択肢の合計を計算
  # total_points
  total_point = result.sum

  case total_point
  when -30...-20
    description_cal = 1
  when -20...-19
    description_cal = 2
  when -19...-18
    description_cal = 3
  when -18...-17
    description_cal = 4
  when -17...-16
    description_cal = 5
  when -16...-15
    description_cal = 6
  when -15...-14
    description_cal = 7
  when -14...-13
    description_cal = 8
  when -13...-12
    description_cal = 9
  when -12...-11
    description_cal = 10
  when -11...-10
    description_cal = 11
  when -10...-9
    description_cal = 12
  when -9...-8
    description_cal = 13
  when -8...-7
    description_cal = 14
  when -7...-6
    description_cal = 15
  when -6...-5
    description_cal = 16
  when -5...-4
    description_cal = 17
  when -4...-3
    description_cal = 18
  when -3...-2
    description_cal = 19
  when -2...-1
    description_cal = 20
  when -1...0
    description_cal = 21
  when 0...1
    description_cal = 22
  when 1...2
    description_cal = 23
  when 2...3
    description_cal = 24
  when 3...4
    description_cal = 25
  when 4...5
    description_cal = 26
  when 5...6
    description_cal = 27
  when 6...7
    description_cal = 28
  when 7...8
    description_cal = 29
  when 9...10
    description_cal = 30
  when 10...11
    description_cal = 31
  when 11...12
    description_cal = 32
  when 12...13
    description_cal = 33
  when 14...15
    description_cal = 34
  when 15...16
    description_cal = 35
  when 16...17
    description_cal = 36
  when 17...30
    description_cal = 37
  end
  @description = Description.find(description_cal).explanation

  # modelに切り出せる
  # alcohol_strongness

  case total_point
  when 3..30
    alcohol_strongness = 4
  when 0...3
    alcohol_strongness = 3
  when -3...0
    alcohol_strongness = 2
  when -30...-3
    alcohol_strongness = 1
  else
    alcohol_strongness = 0
  end

  next_motivation = @next_motivation

  # modelに切り出せる
  # alcohol_in_vein_id:
  alcohol_in_vein =
    if alcohol_strongness == 4 && next_motivation == 0
      AlcoholInVein.find(1).percentage
    elsif alcohol_strongness == 4 && next_motivation == 1
      AlcoholInVein.find(2).percentage
    elsif alcohol_strongness == 4 && next_motivation == 2
      AlcoholInVein.find(3).percentage
    elsif alcohol_strongness == 3 && next_motivation == 0
      AlcoholInVein.find(4).percentage
    elsif alcohol_strongness == 3 && next_motivation == 1
      AlcoholInVein.find(5).percentage
    elsif alcohol_strongness == 3 && next_motivation == 2
      AlcoholInVein.find(6).percentage
    elsif alcohol_strongness == 2 && next_motivation == 0
      AlcoholInVein.find(7).percentage
    elsif alcohol_strongness == 2 && next_motivation == 1
      AlcoholInVein.find(8).percentage
    elsif alcohol_strongness == 2 && next_motivation == 2
      AlcoholInVein.find(9).percentage
    elsif alcohol_strongness == 1 && next_motivation == 0
      AlcoholInVein.find(10).percentage
    elsif alcohol_strongness == 1 && next_motivation == 1
      AlcoholInVein.find(11).percentage
    elsif alcohol_strongness == 1 && next_motivation == 2
      AlcoholInVein.find(12).percentage
    elsif alcohol_strongness.zero? && next_motivation == 0
      AlcoholInVein.find(13).percentage
    elsif alcohol_strongness.zero? && next_motivation == 1
      AlcoholInVein.find(14).percentage
    elsif alcohol_strongness.zero? && next_motivation == 2
      AlcoholInVein.find(15).percentage
    end

  # modelに切りだセル
  coefficient = 833
  your_weight = @weight
  binding.pry
  @total_alcohol_amounts = @weight**coefficient * alcohol_in_vein / 100
  @alcohol_strongness = alcohol_strongness

  def save
    ActiveRecord::Base.transaction do
      AnalyzeResult.create(
        total_alcohol_amounts: @total_alcohol_amounts,
        next_motivation: @next_motivation,
        alcohol_strongness: @alcohol_strongness,
        description: @description
      )
    end
  end

  private

  def tast_answer_params; end
end
