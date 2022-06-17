module TradingsHelper
  def kind_enum
    Trading.kinds.keys.map do |k|
      [locale_kind(k), k]
    end
  end

  def locale_kind(kind)
    I18n.t(kind, scope: 'activerecord.attributes.trading.kind_enum')
  end
end
