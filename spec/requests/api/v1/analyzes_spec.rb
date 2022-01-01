require 'rails_helper'
RSpec.describe 'Analyzes', type: :request do
    describe 'POST /analyzes' do
        let(:analyze) { FactoryBot.create(:analyze) }
        let(:valid_attributes) do
            {analyze:
            {
              total_points: 2.6,
              alcohol_strongness: "weak",
              next_motivation: "tipsy",
              shuchedule: 12,
              description: "気配り上手で先輩から好かれるタイプの酒豪" ,
              user_id: 1
            }
          }
        end
      it '正常に診断ができる' do 
        post api_v1_analyzes_path, params: valid_attributes
        binding.irb
        expect(response.status).to eq(200)
      end
    end
   
    describe "post api/v1/analyzes" do
      let(:analyze) { FactoryBot.create(:analyze) }
      let(:valid_attributes) do
          {analyze:
          {
            total_points: 2.6,
            alcohol_strongness: "weak",
            next_motivation: "tipsy",
            shuchedule: 12,
            description: "気配り上手で先輩から好かれるタイプの酒豪" ,
            user_id: 1
          }
        }
      end
      it '正常に作成する事ができる' do
        
        #データが作成されている事を確認
        expect { get new_api_v1_analyze_path, params: valid_attributes}.to change(Analyze, :count).by(+1)
        # binding.irb
        # リクエスト成功を表す200が返ってきたか確認する。
        expect(response.status).to eq(200)
      end
      it 'Analyzeデータを正常に作成する事ができる' do
        

      end
  end
end