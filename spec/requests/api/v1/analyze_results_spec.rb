require 'rails_helper'
RSpec.describe 'AnalyzeResults', type: :request do

  
  let(:headers) { { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' } }

  describe 'GET /analyzes' do
    let(:user) { create(:user) }
    let(:analyze_result_num) { 5 }
  let(:http_request) { get api_v1_analyze_results_path, headers: headers }
  before do
    create_list(:analyze_result, analyze_result_num, user: user)
  end
  context 'with access_token' do
    let!(:api_key) { create(:api_key, user: user) }
    let!(:headers) { { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json', Authorization: "Bearer #{api_key.access_token}" } }

    it 'returns analyzes in json format' do
      http_request
      expect(json.count).to eq(analyze_result_num)
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end
  end
  it_should_behave_like 'unauthorized user'
end

  describe 'POST /analyze_results' do
    let(:user) { create(:user) }
    let!(:request_hash) { {} }
    let(:http_request) { post api_v1_analyze_results_path, request_hash }
    
    context 'with access_token' do
      let!(:api_key) { create(:api_key, user: user) }
      let(:headers) { { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json', Authorization: "Bearer #{api_key.access_token}" } }
      let!(:request_hash) { { headers: headers, params: { analyze_result: attributes_for(:analyze_result) }.to_json } }

      it 'returns analyzes in json format' do
        expect {
          http_request
        }.to change(AnalyzeResult, :count).by(1)

        expect(response).to be_successful
        expect(response).to have_http_status(201)
      end
    end
    it_should_behave_like 'unauthorized user'
  end
end

    
