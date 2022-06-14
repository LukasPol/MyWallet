require 'rails_helper'

RSpec.describe Wallet, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:user) }
end
