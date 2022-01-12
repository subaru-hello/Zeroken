shared_examples_for 'unauthorized user' do
    context 'when user has not signed in' do
      it 'returns 401 errors' do
        http_request
  
        expect(response.body).to eq("HTTP Token: Access denied.\n")
        expect(response).to have_http_status(401)
      end
    end
  end
  