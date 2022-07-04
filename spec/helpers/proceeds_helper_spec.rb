require 'rails_helper'

RSpec.describe ProceedsHelper, type: :helper do
  it '.proceed_kind_enum_search' do
    expect(proceed_kind_enum_search).to eq([['Dividendos', 0], ['JCP', 1]])
  end

  it '.proceed_kind_enum_form' do
    expect(proceed_kind_enum_form).to eq([%w[Dividendos dividends], %w[JCP jcp]])
  end

  it '.proceed_locale_kind' do
    expect(proceed_locale_kind('dividends')).to eq('Dividendos')
  end
end
