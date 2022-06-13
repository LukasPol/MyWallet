require 'rails_helper'

RSpec.describe Stock, type: :model do
  it { should validate_presence_of(:code) }
  it { should validate_length_of(:code) }
end
