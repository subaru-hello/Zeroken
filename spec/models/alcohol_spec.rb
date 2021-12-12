require 'rails_helper'

RSpec.describe Alcohol, type: :model do
  let(:alcohol) { build(:alcohol) }
  describe 'お酒が正しく作成されるかの検証' do
    context '名前が適切な場合' do
      valid_alcohol_names = %w[ ワイン ハイボール ウィスキー 梅酒 日本酒 レモンサワー ]
      valid_alcohol_amounts = %w[ 350 1000 500 120 700 ]
      valid_pure_alcohol_intakes = %w[ 12 22 1 0 40 30 ]
      it 'フォーマットバリデーションを通過する' do
        valid_alcohol_names.each do |alcohol_name|
          alcohol.name = alcohol_name
          expect(alcohol).to be_valid
        end
      end
      it 'フォーマットバリデーションを通過する' do
        valid_alcohol_amounts.each do |amount|
          alcohol.alcohol_amount = amount
          expect(alcohol).to be_valid
        end
      end
    
    end
  end
end
