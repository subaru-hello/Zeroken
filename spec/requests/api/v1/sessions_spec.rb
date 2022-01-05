require 'rails_helper'
RSpec.describe 'UserSessions', type: :request do
  let(:password) { 'password' }
  let(:password_confirmation) { 'password' }
  let!(:user) { FactoryBot.create(:user, :login) }
    describe 'POST /sessions' do
      it '既に作成されたユーザーでログインできる' do
        # binding.pry
        delete api_v1_sessions_path
        request_hash = { headers: { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' }, params:{ email: "user1@example.com", password: "password" }.to_json }
        post api_v1_sessions_path,  request_hash 
        expect(json['data']['id'].to_i).to eq(user.id)
        expect(json['data']['type']).to eq('user')
        expect(json['data']['attributes']['nickname']).to eq(user.nickname)
        expect(json['data']['attributes']['email']).to eq(user.email)
        expect(response).to be_successful
        expect(response).to have_http_status(200)
      end

      it 'ログアウトする' do
        delete api_v1_sessions_path
        expect(logged_in?).to be_falsey
      end
    end

    describe "POST api_v1_sessions_path" do
        it '存在しないユーザでログインに失敗する' do
          post api_v1_sessions_path, { headers: { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' }, params: { email: user.email, password: 'wrong_password' }.to_json }
    
            expect(json['message']).to eq('Record Not Found')
            expect(json['errors'].count).to eq(1)
            expect(response).to have_http_status(404)
          # user = build(:user)
  
          # expect(response.status).to eq 401
        end
      end
  end