require 'rails_helper'

RSpec.describe "Users", type: :request do
    let(:request_hash) { { headers: { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' }, params: { user: user_attributes }.to_json } }

    describe 'POST /users' , autodoc: true do
      context 'when email and password is valid' do
        let(:user_attributes) { attributes_for(:user) }
        it 'returns user in json format' do
          post api_v1_users_path, request_hash
          expect(json['data']['type']).to eq('user')
          expect(json['data']['attributes']['nickname']).to eq(user_attributes[:nickname])
          expect(json['data']['attributes']['email']).to eq(user_attributes[:email])
          expect(response.headers['AccessToken']).to be_present
          expect(response).to be_successful
          expect(response).to have_http_status(200)
        end
      end
  
      context 'when email and password is invalid', autodoc: true  do
        let(:user_attributes) { attributes_for(:user, name: nil, email: nil, password: nil) }
        it 'returns errors in json format' do
          post api_v1_users_path, request_hash
  
          expect(json['message']).to eq('Bad Request')
          expect(json['errors'].count).to eq(5)
          expect(response.headers['AccessToken']).to be_blank
          expect(response).to have_http_status(400)
        end
      end
    end
end