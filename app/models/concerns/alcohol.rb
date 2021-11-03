module Alcoholable
  extend ActiveSupport::Concern

  included { has_many :alcohols, as: :alcoholable, dependent: :destroy }

  def name; end

  def desctiption; end

  def alcohol_percentage; end

  def alcohol_amount; end

  def pure_alcohol_intake; end
end
