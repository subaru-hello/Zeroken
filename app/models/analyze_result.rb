class AnalyzeResult < ApplicationRecord
  belongs_to :user
  has_many :descriptions, dependent: :destroy
  enum next_motivation: { flesh: 0, tipsy: 1, heavy_drunk: 2 }
  enum alcohol_strongness: { weak: 0, weak_normal: 1, normal: 2, normal_strong: 3, strong: 4 }

  def self.cal_shuchedule(weight, next_motivation, user_id)
    total_point = AnalyzeResult.cal_total_point(user_id)
    description = AnalyzeResult.extract_description(total_point)
    alcohol_strongness = AnalyzeResult.cal_alcohol_strongness(total_point)
    total_alcohol_amounts =
      AnalyzeResult.cal_total_alcohol_amount(weight, alcohol_strongness, next_motivation)
    alcohols = Alcohol.sum_amount(total_alcohol_amounts)
    shuchedule = alcohols.map(&:sample)

    {
      user_id: user_id,
      next_motivation: next_motivation,
      description: description,
      alcohol_strongness: alcohol_strongness,
      total_alcohol_amounts: total_alcohol_amounts,
      first_alcohol: shuchedule[0]['id'],
      second_alcohol: shuchedule[1]['id'],
      third_alcohol: shuchedule[2]['id'],
      forth_alcohol: shuchedule[3]['id']
    }
  end

  def self.cal_total_point(user_id)
    tast_answer_array = TastAnswer.where(user_id: user_id).pluck[0][2..14]

    target_array = tast_answer_array.map.with_index { |arr, i| (3 * i) + arr }

    result = target_array.map { |n| Answer.find(n).point.to_f }

    result.sum
  end

  def self.cal_total_alcohol_amount(weight, alcohol_strongness, next_motivation)
    pair = [alcohol_strongness, next_motivation]
    check_alcohol_in_vein =
      case pair
      when [4, 0]
        1
      when [4, 1]
        2
      when [4, 2]
        3
      when [3, 0]
        4
      when [3, 1]
        5
      when [3, 2]
        6
      when [2, 0]
        7
      when [2, 1]
        8
      when [2, 2]
        9
      when [1, 0]
        10
      when [1, 1]
        11
      when [1, 2]
        12
      when [0, 0]
        13
      when [0, 1]
        14
      when [0, 2]
        15
      end
    alcohol_in_vein = AlcoholInVein.find(check_alcohol_in_vein).percentage

    # modelに切りだセル
    coefficient = 833
    weight * coefficient * alcohol_in_vein / 100
  end

  def self.extract_description(total_point)
    description_cal =
      case total_point
      when -30...-20
        1
      when -20...-19
        2
      when -19...-18
        3
      when -18...-17
        4
      when -17...-16
        5
      when -16...-15
        6
      when -15...-14
        7
      when -14...-13
        8
      when -13...-12
        9
      when -12...-11
        10
      when -11...-10
        11
      when -10...-9
        12
      when -9...-8
        13
      when -8...-7
        14
      when -7...-6
        15
      when -6...-5
        16
      when -5...-4
        17
      when -4...-3
        18
      when -3...-2
        19
      when -2...-1
        20
      when -1...0
        21
      when 0...1
        22
      when 1...2
        23
      when 2...3
        24
      when 3...4
        25
      when 4...5
        26
      when 5...6
        27
      when 6...7
        28
      when 7...8
        29
      when 9...10
        30
      when 10...11
        31
      when 11...12
        32
      when 12...13
        33
      when 14...15
        34
      when 15...16
        35
      when 16...17
        36
      when 17...30
        37
      end
    Description.find(description_cal).explanation
  end

  def self.cal_alcohol_strongness(total_point)
      case total_point
      when 3..30
        4
      when 0...3
        3
      when -3...0
        2
      when -30...-3
        1
      else
        0
      end
  end
end
