require 'rails_helper'

RSpec.describe Trading, type: :model do
  let!(:user) { create(:user) }
  describe 'validates' do
    context 'presence' do
      it { should validate_presence_of(:value) }
      it { should validate_presence_of(:amount) }
      it { should validate_presence_of(:kind) }
      it { should validate_presence_of(:user) }
      it { should validate_presence_of(:wallet) }
      it { should validate_presence_of(:stock) }
    end

    context 'date should to be before Today' do
      it 'save successful' do
        # user = create(:user)
        trading = build(:trading, date: Date.yesterday)
        expect(trading.valid?).to be_truthy
      end

      it 'not save with date after today' do
        expect(build(:trading, date: Date.tomorrow).valid?).to be_falsey
      end
    end
  end
end
