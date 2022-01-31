module ExtractDescription
  extend ActiveSupport::Concern
  class << self
    def extract_description(total_point)
      description_cal =
        case total_point
        when -30...-15
          lower_than_minus_fifteen(total_point)
        when -14...-7
          range_minus_seven_minus_fourteen(total_point)
        when -7...0
          range_zero_minus_seven(total_point)
        when 0...7
          range_zero_seven(total_point)
        when 7...13
          range_seven_thirteen(total_point)
        when 13...30
          range_fourteen_thirty(total_point)
        end
      Description.find(description_cal).explanation
    end

    def lower_than_minus_fifteen(total_point)
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
      end
    end

    def range_minus_seven_minus_fourteen(total_point)
      case total_point
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
      end
    end

    def range_zero_minus_seven(total_point)
      case total_point
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
      end
    end

    def range_zero_seven(total_point)
      case total_point
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
      end
    end

    def range_seven_thirteen(total_point)
      case total_point
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
      end
    end

    def range_fourteen_thirty(total_point)
      case total_point
      when 14...15
        34
      when 15...16
        35
      when 16...17
        36
      when 17...30
        37
      end
    end
  end
end
