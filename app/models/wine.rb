class Wine < Alcohol
  # Alcoholを使うポリモーフィックなモデルはAlcoholableをincludeする
  include Alcoholable

  # moduleで定義されているメソッドをオーバーライドする

  def name
    'ワイン'
  end

  def description
    'とりあえずワイン'
  end

  def alcohol_percentage
    5
  end

  def alcohol_amount
    350
  end

  def pure_alcohol_intake
    14
  end
end
