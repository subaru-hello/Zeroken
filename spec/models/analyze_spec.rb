require 'rails_helper'

RSpec.describe AnalyzeResult, type: :model do
  let(:analyze_result) { build(:analyze_result) }
  describe '診断項目が正しく作成されるかの検証' do
    context '診断内容が適切な場合' do
      valid_total_points = %w[ -10 10 1 0 3 4 ]
      valid_alcohol_strongness = %w[ weak normal strong ]
      valid_next_motivation = %w[ flesh tipsy heavy_drunk ]
      it 'total_pointsが作成される' do
        valid_total_points.each do |point|
          AnalyzeResult.total_points = point
          expect(analyze_result).to be_valid
        end
      end
      it 'お酒の強さが作成される' do
        valid_alcohol_strongness.each do |strongness|
          AnalyzeResult.alcohol_strongness = strongness
          expect(analyze_result).to be_valid
        end
      end
      it '次の飲み会に向けた気分が作成される' do
        valid_next_motivation.each do |nomivation|
          AnalyzeResult.next_motivation = nomivation
          expect(analyze_result).to be_valid
        end
      end
    end
  end
end
