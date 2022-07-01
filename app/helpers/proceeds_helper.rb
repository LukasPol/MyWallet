module ProceedsHelper
  def proceed_kind_enum_search
    Proceed.kinds.map do |key, value|
      [proceed_locale_kind(key), value]
    end
  end

  def proceed_kind_enum_form
    Proceed.kinds.keys.map do |k|
      [proceed_locale_kind(k), k]
    end
  end

  def proceed_locale_kind(kind)
    I18n.t(kind, scope: 'activerecord.attributes.proceed.kind_enum')
  end
end
