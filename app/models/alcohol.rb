class Alcohol < ApplicationRecord
  include Rails.application.routes.url_helpers
  has_many :alcohol_analyzes, dependent: :destroy

  #  has_many :likes, through: :favorites, source: :user

  mount_uploader :image, ImageUploader
  has_one_attached :image
  def self.cal_amount(amount)
    amount_under_3000 = [50, 0, 0, 0]
    amount_3200 = [1440, 690, 0, 0]
    amount_3500 = [1750, 1750, 0, 0]
    amount_4000 = [1750, 1440, 1050, 0]
    amount_4500 = [1750, 1750, 1050, 0]

    amount_5000 = [1750, 1440, 1440, 0]
    amount_5500 = [1750, 1750, 2250, 0]
    amount_6000 = [1750, 690, 2700, 1050]
    amount_6500 = [1750, 2750, 690, 1050]
    amount_7000 = [1750, 1750, 1750, 1750]
    amount_7500 = [1750, 2700, 2800, 0]

    amount_8000 = [1750, 2700, 2250, 1050]
    amount_8500 = [1750, 2250, 2800, 1750]
    amount_9000 = [1750, 2250, 2800, 2250]
    amount_9500 = [1800, 2800, 2800, 2250]
    amount_10000 = [1750, 4900, 1750, 1200]

    amount_10500 = [1750, 2250, 2250, 2250]
    amount_11000 = [1750, 4900, 4900, 1200]
    amount_11500 = [1750, 1200, 4900, 3500]
    amount_12000 = [1750, 3500, 1750, 4900]
    amount_12500 = [3500, 1200, 4900, 2800]
    case amount
    when 0...3000
      amount_under_3000
    when 3000...3200
      amount_3200
    when 3200...3500
      amount_3500
    when 3500...4000
      amount_4000
    when 4000...4500
      amount_4500
    when 4500...5000
      amount_5000
    when 5000...5500
      amount_5500
    when 5500...6000
      amount_6000
    when 6000...6500
      amount_6500
    when 6500...7000
      amount_7000
    when 7000...7500
      amount_7500
    when 7500...8000
      amount_8000
    when 8000...8500
      amount_8500
    when 8500...9000
      amount_9000
    when 9000...9500
      amount_9500
    when 9500...10_000
      amount_10000
    when 10_000...10_500
      amount_10500
    when 10_500...11_000
      amount_11000
    when 11_000...11_500
      amount_11500
    when 11_500...12_000
      amount_12000
    when 12_000...12_500
      amount_12500
    end
  end

  def self.sum_amount(point)
    alcohol_array = Alcohol.cal_amount(point)
    alcohol_array.map { |alcohol_amount| Alcohol.where('alcohol_amount= ?', alcohol_amount) }
  end
end
