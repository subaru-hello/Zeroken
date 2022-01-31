class AnalyzeResult < ApplicationRecord
  include ExtractDescription
  belongs_to :user
  has_many :descriptions, dependent: :destroy
  enum next_motivation: { flesh: 0, tipsy: 1, heavy_drunk: 2 }
  enum alcohol_strongness: { weak: 0, weak_normal: 1, normal: 2, normal_strong: 3, strong: 4 }

    def self.cal_shuchedule(weight, next_motivation, user_id)
      total_point = AnalyzeResult.cal_total_point(user_id)
      description = ExtractDescription.which_extract_description(total_point)
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

      target_array = tast_answer_array.map.with_index { |arr, i| 10 * (arr + 3 * i) -5 }
      result = target_array.map { |n| Answer.find(n).point.to_f }

      result.sum
    end

    def self.cal_total_alcohol_amount(weight, alcohol_strongness, next_motivation)
      pair = [alcohol_strongness, next_motivation]
      check_alcohol_in_vein =
        case pair
        when [4, 0]
          5
        when [4, 1]
          15
        when [4, 2]
          25
        when [3, 0]
          35
        when [3, 1]
          45
        when [3, 2]
          55
        when [2, 0]
          65
        when [2, 1]
          75
        when [2, 2]
          85
        when [1, 0]
          95
        when [1, 1]
          105
        when [1, 2]
          115
        when [0, 0]
          125
        when [0, 1]
          135
        when [0, 2]
          145
        end
      alcohol_in_vein = AlcoholInVein.find(check_alcohol_in_vein).percentage

      coefficient = 833
      weight * coefficient * alcohol_in_vein / 100
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
