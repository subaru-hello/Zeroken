require 'rails_helper'

RSpec.describe Analyze, type: :model do
  let(:analyze) { build(:analyze) }
  describe '診断項目が正しく作成されるかの検証' do
    context '診断内容が適切な場合' do
      valid_total_points = %w[ -10 10 1 0 3 4 ]
      valid_alcohol_strongness = %w[ weak normal strong ]
      valid_next_motivation = %w[ flesh tipsy heavy_drunk ]
      it 'total_pointsが作成される' do
        valid_total_points.each do |point|
          analyze.total_points = point
          expect(analyze).to be_valid
        end
      end
      it 'お酒の強さが作成される' do
        valid_alcohol_strongness.each do |strongness|
          analyze.alcohol_strongness = strongness
          expect(analyze).to be_valid
        end
      end
      it '次の飲み会に向けた気分が作成される' do
        valid_next_motivation.each do |nomivation|
          analyze.next_motivation = nomivation
          expect(analyze).to be_valid
        end
      end
    end
  end
end
