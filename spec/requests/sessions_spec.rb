require 'rails_helper'
RSpec.describe 'UserSessions', type: :request do
    describe 'POST /sessions' do
        let!(:user) { FactoryBot.create(:user, :login) }
        let!(:valid_attributes) do
            {session:
            {
              email: "user1@example.com",
              password: "password" 
            }
          }
        end
      it '既に作成されたユーザーでログインできる' do
        delete api_v1_sessions_path
        post api_v1_sessions_path, params: {user: valid_attributes}
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