require 'rails_helper'
require 'spec_helper'

RSpec.describe "Alcohols", type: :request do
  describe "GET /alcohols" do
    # let(:alcohol_num) { 2 }
    it 'returns 200' do
      
      alcohol = FactoryBot.create(:alcohol)
      get api_v1_alcohols_path, headers: { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' }

      expect(response).to be_successful
      expect(response.status).to eq(200)
    end

  end
  
end