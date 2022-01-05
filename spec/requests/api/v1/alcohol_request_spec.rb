require 'rails_helper'
require 'spec_helper'

RSpec.describe "Alcohols", type: :request do
  describe "get api/v1/alcohols" do
    # let(:alcohol_num) { 2 }
    it '200が返ってくる' do
      
      alcohol = FactoryBot.create(:alcohol)
      get api_v1_alcohols_path, headers: { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' }
      # binding.pry
      # binding.irb
      
      # check that the message attributes are the same.
      # expect(json['data'].count).to eq(1)
      expect(response).to be_successful
      expect(response.status).to eq(200)
    end

  end
  
end