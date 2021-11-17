require 'rails_helper'

RSpec.describe Analyze, type: :model do
  let(:analyze) { build(:analyze) }
  describe '診断項目が正しく作成されるかの検証' do
    context '診断内容が適切な場合' do
      valid_total_points = %w[ -10 10 1 0 3 4 ]
      valid_sake_strongness_types = %w[ weak normal strong ]
      valid_next_nomivation_types = %w[ flesh tipsy heavy_drunk ]
      it 'total_pointsが作成される' do
        valid_total_points.each do |point|
          analyze.total_points = point
          expect(analyze).to be_valid
        end
      end
      it 'お酒の強さが作成される' do
        valid_sake_strongness_types.each do |strongness|
          analyze.sake_strongness_types = strongness
          expect(analyze).to be_valid
        end
      end
      it '次の飲み会に向けた気分が作成される' do
        valid_next_nomivation_types.each do |nomivation|
          analyze.next_nomivation_types = nomivation
          expect(analyze).to be_valid
        end
      end
    end
  end
end
