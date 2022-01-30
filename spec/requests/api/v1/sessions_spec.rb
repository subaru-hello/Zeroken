require 'rails_helper'
RSpec.describe 'UserSessions', type: :request do
  let(:password) { 'password' }

  
  
  describe 'POST /sessions' do
    context 'when email and password is valid' do
      let(:user) { create(:user, password: password) }  
      it 'returns user in json format' do
        
        request_hash = { headers: { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' }, params: { email: user.email, password: password }.to_json }
        post api_v1_sessions_path,  request_hash 
        expect(json['data']['id'].to_i).to eq(user.id)
        expect(json['data']['type']).to eq('user')
        expect(json['data']['attributes']['nickname']).to eq(user.nickname)
        expect(json['data']['attributes']['email']).to eq(user.email)
        expect(response.headers['AccessToken']).to be_present
        expect(response).to be_successful
        expect(response).to have_http_status(200)
      end
      it 'be able to delete session data' do
        delete api_v1_sessions_path
        expect(logged_in?).to be_falsey
      end
    end
    context 'when email and password is invalid' do
      let!(:user) { create(:user, password: password) }  
      it 'returns user in json format' do
        post api_v1_sessions_path, { headers: { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' }, params: { email: user.email, password: 'wrong_password' }.to_json }
        expect(json['message']).to eq('Record Not Found')
        expect(json['errors'].count).to eq(1)
        expect(response).to have_http_status(404)
      end
    end

    end

  end