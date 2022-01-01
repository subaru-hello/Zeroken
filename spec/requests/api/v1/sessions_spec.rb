require 'rails_helper'
RSpec.describe 'UserSessions', type: :request do
  before do
    allow_any_instance_of(ActionDispatch::Request).to receive(:session)
  end
    describe 'POST /sessions' do
        let!(:user) { FactoryBot.attributes_for(:user, :login) }
        let!(:valid_attributes) do
            {session:
            {
              email: "user1@example.com",
              password: "password" 
            }
          }
        end
        it 'ログインができる' do
          get api_v1_sessions_path
          expect(response).to have_http_status(200)
        end
      it '既に作成されたユーザーでログインできる' do
        login_user(user, "password" )
        delete api_v1_sessions_path
        binding.irb
        # post api_v1_sessions_path,  params:  {session:{user: user.email, password: user.password}}
        post api_v1_sessions_path,  params: :valid_attributes.to_json, as: :json 
        binding.irb
        expect(response).to have_http_status(200)
      end

      it 'ログアウトする' do
        delete api_v1_sessions_path
        expect(logged_in?).to be_falsey
      end
    end

    describe "POST api_v1_sessions_path" do
        it '存在しないユーザでログインに失敗すること' do
          user = build(:user)
          post api_v1_sessions_path, params: {user: { session: { email: "user2@example.com", password: "password" } }}
          expect(response.status).to eq 401
        end
      end
  end