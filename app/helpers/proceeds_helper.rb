module ProceedsHelper
  def proceed_kind_enum
    Proceed.kinds.keys.map do |k|
      [proceed_locale_kind(k), k]
    end
  end

  def proceed_locale_kind(kind)
    I18n.t(kind, scope: 'activerecord.attributes.proceed.kind_enum')
  end
end
