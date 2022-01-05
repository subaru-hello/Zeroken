require 'rails_helper'
RSpec.describe 'Analyzes', type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let!(:analyze){ FactoryBot.create(:analyze, user: user)  }
    describe 'GET /analyzes' do
      let(:analyze_num) { 1 }

      it '正常に診断を取得できる' do 
        login_as(user)
        
        get api_v1_analyzes_path, headers: { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' }
binding.irb
        expect(json['data'].length).to eq(analyze_num)
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end
   
      describe 'POST /analyzes' do
      it '正常に作成する事ができる' do
        
      end
      end
      end
  
end