require 'rails_helper'

RSpec.describe "Alcohols", type: :request do
  describe "get api/v1/alcohols" do
    before do
      get api_v1_alcohols_path
    end

    it '200が返ってくる' do
      expect(response).to have_http_status(200)
    end
  end
end