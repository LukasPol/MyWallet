require 'rails_helper'

RSpec.describe '/tradings', type: :request do
  let!(:user) { create(:user) }
  let(:wallet) { user.wallets.first }

  before { sign_in(user) }

  let(:valid_attributes) do
    attributes_for(:trading, user: user, wallet: wallet)
  end

  let(:invalid_attributes) do
    {
      value: 0,
      amount: 10
    }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Trading.create! valid_attributes
      get tradings_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      trading = Trading.create! valid_attributes
      get trading_url(trading)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_trading_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      trading = Trading.create! valid_attributes
      get edit_trading_url(trading)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      xit 'creates a new Trading' do
        expect do
          post tradings_url, params: { trading: valid_attributes }
        end.to change(Trading, :count).by(1)
      end

      xit 'redirects to the created trading' do
        post tradings_url, params: { trading: valid_attributes }
        expect(response).to redirect_to(tradings_url)
      end
    end

    context 'with invalid parameters' do
      xit 'does not create a new Trading' do
        expect do
          post tradings_url, params: { trading: invalid_attributes }
        end.to change(Trading, :count).by(0)
      end

      xit "renders a successful response (i.e. to display the 'new' template)" do
        post tradings_url, params: { trading: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        skip('Add a hash of attributes valid for your model')
      end

      xit 'updates the requested trading' do
        trading = Trading.create! valid_attributes
        patch trading_url(trading), params: { trading: new_attributes }
        trading.reload
        skip('Add assertions for updated state')
      end

      xit 'redirects to the trading' do
        trading = Trading.create! valid_attributes
        patch trading_url(trading), params: { trading: new_attributes }
        trading.reload
        expect(response).to redirect_to(trading_url(trading))
      end
    end

    context 'with invalid parameters' do
      xit "renders a successful response (i.e. to display the 'edit' template)" do
        trading = Trading.create! valid_attributes
        patch trading_url(trading), params: { trading: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested trading' do
      trading = Trading.create! valid_attributes
      expect do
        delete trading_url(trading)
      end.to change(Trading, :count).by(-1)
    end

    it 'redirects to the tradings list' do
      trading = Trading.create! valid_attributes
      delete trading_url(trading)
      expect(response).to redirect_to(tradings_url)
    end
  end
end
