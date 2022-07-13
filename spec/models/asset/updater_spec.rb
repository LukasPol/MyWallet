require 'rails_helper'

RSpec.describe Asset::Updater do
  let(:user) { create(:user) }
  let(:stock) { create(:stock) }
  let(:tradings) { user.reload.tradings }
  let(:asset) { user.reload.assets.last }

  describe '.call' do
    context 'kind buy' do
      context 'when you buy the first asset' do
        let(:trading) { create(:trading, kind: 'buy', user: user) }

        before :each do
          trading.reload
        end

        it 'asset.amount should to be equal trading.amount' do
          expect(trading.asset.amount).to eq(trading.amount)
        end

        it 'asset.total_invested should to be equal trading.total_value' do
          expect(trading.asset.total_invested).to eq(trading.total_value)
        end

        it 'average_price should be correct' do
          expect(trading.asset.average_price).to eq((trading.total_value / trading.amount).round(2))
        end
      end

      context 'when you buy the second assets' do
        before :each do
          create_list(:trading, 2,
                      kind: 'buy',
                      user: user,
                      amount: rand(1..10),
                      value: rand(5.0..20.9).round(2),
                      stock: stock)
        end

        it 'asset.amount should to be equal trading.amount' do
          expect(asset.amount).to eq(tradings.sum(&:amount))
        end

        it 'asset.total_invested should to be equal trading.total_value' do
          expect(asset.reload.total_invested).to eq(tradings.sum(&:total_value))
        end

        it 'average_price should be correct' do
          expect(asset.average_price).to eq((tradings.sum(&:total_value) / tradings.sum(&:amount)).round(2))
        end
      end
    end

    context 'kind sold' do
      context 'when you buy and sell the same amount of stocks' do
        before :each do
          create(:trading, kind: 'buy', user: user, stock: stock)
          create(:trading, kind: 'hold', user: user, stock: stock)
        end

        it 'asset.amount should to be equal trading.amount' do
          expect(asset.amount).to be_zero
        end

        it 'asset.total_invested should to be equal trading.total_value' do
          expect(asset.total_invested).to be_zero
        end

        it 'average_price should be correct' do
          expect(asset.average_price).to be_zero
        end
      end

      context 'when you buy and sell different amounts' do
        before :each do
          create(:trading, kind: 'buy', amount: 10, value: 15.0, user: user, stock: stock)
          create(:trading, kind: 'hold', amount: 5, value: rand(5.0..20.9).round(2), user: user, stock: stock)
        end

        it 'asset.amount should to be equal trading.amount' do
          expect(asset.amount).to eq(5)
        end

        it 'asset.total_invested should to be equal trading.total_value' do
          expect(asset.total_invested).to eq((0.15 * 5).round(2))
        end

        it 'average_price should be correct' do
          expect(asset.average_price).to eq(0.15)
        end
      end
    end
  end
end
