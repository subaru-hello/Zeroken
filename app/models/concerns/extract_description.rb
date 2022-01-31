module ExtractDescription
  extend ActiveSupport::Concern
  EXTRACT_DESCRIPTIONS = [
    { total_point_range: -30...-20, cal: 5 },
    { total_point_range: -20...-19, cal: 15 },
    { total_point_range: -18...-17, cal: 25 },
    { total_point_range: -17...-16, cal: 35 },
    { total_point_range: -16...-15, cal: 45 },
    { total_point_range: -15...-14, cal: 55 },
    { total_point_range: -14...-13, cal: 65 },
    { total_point_range: -13...-12, cal: 75 },
    { total_point_range: -12...-11, cal: 85 },
    { total_point_range: -11...-10, cal: 95 },
    { total_point_range: -10...-9, cal: 105 },
    { total_point_range: -9...-8, cal: 115 },
    { total_point_range: -8...-7, cal: 125 },
    { total_point_range: -7...-6, cal: 135 },
    { total_point_range: -6...-5, cal: 145 },
    { total_point_range: -5...-4, cal: 155 },
    { total_point_range: -4...-3, cal: 165 },
    { total_point_range: -3...-2, cal: 175 },
    { total_point_range: -1...0, cal: 185 },
    { total_point_range: 0...1, cal: 195 },
    { total_point_range: 1...2, cal: 205 },
    { total_point_range: 2...3, cal: 215 },
    { total_point_range: 3...4, cal: 225 },
    { total_point_range: 4...5, cal: 235 },
    { total_point_range: 5...6, cal: 245 },
    { total_point_range: 6...7, cal: 255 },
    { total_point_range: 7...8, cal: 265 },
    { total_point_range: 8...9, cal: 275 },
    { total_point_range: 9...10, cal: 285 },
    { total_point_range: 10...11, cal: 295 },
    { total_point_range: 11...12, cal: 305 },
    { total_point_range: 12...13, cal: 315 },
    { total_point_range: 13...14, cal: 325 },
    { total_point_range: 14...15, cal: 335 },
    { total_point_range: 15...16, cal: 345 },
    { total_point_range: 16...17, cal: 355 },
    { total_point_range: 17...30, cal: 365 }
  ].freeze

  def self.which_extract_description(total_point)
    EXTRACT_DESCRIPTIONS.each do |extract_description|
      return extract_description[:cal] if extract_description[:total_point_range] == total_point
    end
  end
end
