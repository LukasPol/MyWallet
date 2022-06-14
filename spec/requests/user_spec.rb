require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let!(:user) { create(:user) }

  describe 'GET #sign_in' do
    it 'returns http success' do
      get '/users/sign_in'
      expect(response).to have_http_status(:success)
    end
  end
end
