require 'rails_helper'
require 'spec_helper'

RSpec.describe "Alcohols", type: :request do
  describe "get api/v1/alcohols" do
    it '200が返ってくる' do
      alcohol = FactoryBot.create(:alcohol)

   
     
      get api_v1_alcohols_path
      # binding.pry
      json = JSON.parse(response.body)
      binding.irb
      expect(response.status).to eq(200)
      # check that the message attributes are the same.
      expect(json['data'].length).to eq(10)

    # ensure that private attributes aren't serialized
    expect(json['private_attr']).to eq(nil)
    end

  end
  
end