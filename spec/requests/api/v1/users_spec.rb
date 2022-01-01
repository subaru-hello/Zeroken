require 'rails_helper'

RSpec.describe "Users", type: :request do
    context 'パラメータが正常な場合' do
        describe "GET api_v1_users_path" do
            it "FactoryBotが正常に動く" do
                user = FactoryBot.attributes_for(:user)
                get "/register"
                expect(response).to have_http_status(200)
            end
        end

        describe "POST api_v1_users_path" do
            it "正常にログインする" do
                @params = FactoryBot.attributes_for(:user, :login)
                post api_v1_users_path, params: { user: @params } 
                expect(response).to have_http_status(200)
            end
        end
    end

    context 'パラメータが不正な場合ユーザーが登録されないこと' do
        it '名前がブランクの場合' do
          @params = FactoryBot.attributes_for(:user, :nickname_invalid)
          post api_v1_users_path , params: { user: @params }
          expect(response.status).to eq 400
    end
        it 'メールがブランクの場合' do
          @params = FactoryBot.attributes_for(:user, :email_invalid)
          post api_v1_users_path , params: { user: @params }
          expect(response.status).to eq 400
    end
        it 'パスワードがブランクの場合' do
          @params = FactoryBot.attributes_for(:user, :password_invalid)
          post api_v1_users_path , params: { user: @params }
          expect(response.status).to eq 400
    end
  end
end