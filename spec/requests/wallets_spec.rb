require 'rails_helper'

RSpec.describe 'Wallets', type: :request do
  let(:user) { create(:user) }
  let(:stock) { create(:stock) }

  describe '/index' do
    context 'when is logged' do
      before :each do
        create_list(:trading, 3, user: user, stock: stock)

        sign_in(user)
      end

      it 'returns count correct' do
        get wallets_path

        expect(assigns[:grouped_tradings].count).to eq(1)
      end
    end
  end
end
