class AnalyzeResultForm
  include ActiveModel::Model

  attr_accessor :alcohol_percentage,
                :alcohol_amount,
                :name,
                :description,
                :image

  def save
    alcohol = Alcohol.all
  end
end
