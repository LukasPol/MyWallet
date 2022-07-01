module TradingsHelper
  def trading_kind_enum_search
    Trading.kinds.map do |key, value|
      [locale_kind(key), value]
    end
  end

  def trading_kind_enum_form
    Trading.kinds.keys.map do |k|
      [locale_kind(k), k]
    end
  end

  def locale_kind(kind)
    I18n.t(kind, scope: 'activerecord.attributes.trading.kind_enum')
  end
end
