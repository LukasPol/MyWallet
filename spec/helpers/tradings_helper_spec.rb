require 'rails_helper'

RSpec.describe TradingsHelper, type: :helper do
  it '.trading_kind_enum_search' do
    expect(trading_kind_enum_search).to eq([['Compra', 0], ['Venda', 1]])
  end

  it '.trading_kind_enum_form' do
    expect(trading_kind_enum_form).to eq([%w[Compra buy], %w[Venda hold]])
  end

  it '.trading_locale_kind' do
    expect(trading_locale_kind('buy')).to eq('Compra')
  end
end
