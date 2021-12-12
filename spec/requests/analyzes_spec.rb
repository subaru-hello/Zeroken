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
              description: "気配り上手で先輩から好かれるタイプの酒豪" 
            }
          }
        end
      it '正常に診断ができる' do
       
        post api_v1_analyzes_path, params: valid_attributes
        expect(response).to have_http_status(200)
      end
    end
  end