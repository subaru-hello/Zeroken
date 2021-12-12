require 'rails_helper'
RSpec.describe 'Analyzes', type: :request do
    describe 'POST /analyzes' do
        let (:analyze) { FactoryBot.create(:analyze) }
      it '正常に診断ができる' do
        post api_v1_analyzes_path, params: analyze
        expect(response).to have_http_status(200)
      end
    end
  end