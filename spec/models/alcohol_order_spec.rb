require 'rails_helper'

RSpec.describe AlcoholOrder, type: :model do
    let(:alcohol_analyze) { build(:alcohol_analyze) }
    describe 'お酒の順番が正しく作成されるかの検証' do
      context '順番が適切な場合' do
        valid_orders = %w[ 1 2 3 4 5 6 7  ]
        it 'フォーマットバリデーションを通過する' do
          valid_orders.each do |alcohol|
            alcohol_analyze.order = alcohol
            expect(alcohol_analyze).to be_valid
          end
        end
      end
    end
end
