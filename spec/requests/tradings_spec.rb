require 'rails_helper'

RSpec.describe '/tradings', type: :request do
  let!(:user) { create(:user) }
  let(:wallet) { user.wallets.first }
  let(:stock) { create(:stock) }
  let(:trading) { create(:trading, user: user) }

  before { sign_in(user) }

  let(:valid_attributes) do
    attributes_for(:trading, user: user, wallet: wallet)
      .merge!(stock: stock.code)
  end

  let(:invalid_attributes) do
    {
      value: 0,
      amount: 10
    }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      get tradings_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get trading_url(trading)
      expect(response).to be_successful
    end

    context 'try to see another user proceeds' do
      before :each do
        user2 = create(:user)
        trading2 = create(:trading, user: user2)
        get trading_url(trading2)
      end

      it 'should return the flash message error' do
        expect(flash[:error]).to eq('Acesso Negado')
      end

      it 'render unauthorized response' do
        expect(response).to be_unauthorized
      end
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
      get edit_trading_url(trading)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Trading' do
        expect do
          post tradings_url, params: { trading: valid_attributes }
        end.to change(Trading, :count).by(1)
      end

      it 'redirects to the created trading' do
        post tradings_url, params: { trading: valid_attributes }
        expect(response).to redirect_to(tradings_url)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Trading' do
        expect do
          post tradings_url, params: { trading: invalid_attributes }
        end.to change(Trading, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post tradings_url, params: { trading: invalid_attributes }
        expect(response).to be_unprocessable
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        { value: 5.99 }
      end

      it 'updates the requested trading' do
        patch trading_url(trading), params: { trading: new_attributes }
        trading.reload
        expect(trading.value).to eq(5.99)
      end

      it 'redirects to the trading' do
        patch trading_url(trading), params: { trading: new_attributes }
        expect(response).to redirect_to(tradings_url)
      end

      it 'updates stock' do
        patch trading_url(trading), params: { trading: { stock: stock.code } }
        expect(trading.reload.stock.code).to eq(stock.code)
      end
    end

    context 'with invalid parameters' do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        patch trading_url(trading), params: { trading: invalid_attributes }
        expect(response).to be_unprocessable
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested trading' do
      expect do
        delete trading_url(trading)
      end.to change(Trading, :count).by(0)
    end

    it 'redirects to the tradings list' do
      delete trading_url(trading)
      expect(response).to redirect_to(tradings_url)
    end
  end
end
