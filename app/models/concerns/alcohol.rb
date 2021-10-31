module Alcoholable
  extend ActiveSupport::Concern

  included { has_many :alcohols, as: :alcoholable }

  def name
    # オーバーライドされなかった場合はエラーが上がるようにしておく
    raise NotImplementedError
  end

  def desctiption
    raise NotImplementedError
  end
  def alcohol_percentage
    raise NotImplementedError
  end
  def alcohol_amount
    raise NotImplementedError
  end
  def pure_alcohol_intake
    raise NotImplementedError
  end
end
