require 'rails_helper'

RSpec.describe '/proceeds', type: :request do
  let!(:user) { create(:user) }
  let(:wallet) { user.wallets.first }
  let(:stock) { create(:stock) }

  before { sign_in(user) }

  let(:valid_attributes) do
    attributes_for(:proceed, user: user, wallet: wallet)
      .merge!(stock_id: stock.id)
  end

  let(:invalid_attributes) do
    {
      value: 0,
      amount: 10
    }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Proceed.create! valid_attributes
      get proceeds_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      proceed = Proceed.create! valid_attributes
      get proceed_url(proceed)
      expect(response).to be_successful
    end

    context 'try to see another user proceeds' do
      before :each do
        user2 = create(:user)
        proceed2 = create(:proceed, user: user2)
        get proceed_url(proceed2)
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
      get new_proceed_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      proceed = Proceed.create! valid_attributes
      get edit_proceed_url(proceed)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Proceed' do
        expect do
          post proceeds_url, params: { proceed: valid_attributes }
        end.to change(Proceed, :count).by(1)
      end

      it 'redirects to the created proceed' do
        post proceeds_url, params: { proceed: valid_attributes }
        expect(response).to redirect_to(proceeds_url)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Proceed' do
        expect do
          post proceeds_url, params: { proceed: invalid_attributes }
        end.to change(Proceed, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post proceeds_url, params: { proceed: invalid_attributes }
        expect(response).to be_unprocessable
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        { value: 10.5 }
      end

      it 'updates the requested proceed' do
        proceed = Proceed.create! valid_attributes
        patch proceed_url(proceed), params: { proceed: new_attributes }
        proceed.reload
        expect(proceed.value).to eq(10.5)
      end

      it 'redirects to the proceed' do
        proceed = Proceed.create! valid_attributes
        patch proceed_url(proceed), params: { proceed: new_attributes }
        proceed.reload
        expect(response).to redirect_to(proceeds_url)
      end
    end

    context 'with invalid parameters' do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        proceed = Proceed.create! valid_attributes
        patch proceed_url(proceed), params: { proceed: invalid_attributes }
        expect(response).to be_unprocessable
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested proceed' do
      proceed = Proceed.create! valid_attributes
      expect do
        delete proceed_url(proceed)
      end.to change(Proceed, :count).by(-1)
    end

    it 'redirects to the proceeds list' do
      proceed = Proceed.create! valid_attributes
      delete proceed_url(proceed)
      expect(response).to redirect_to(proceeds_url)
    end
  end
end
