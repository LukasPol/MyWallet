class Trading
  class Updater < Base
    prepend SimpleCommand

    def call
      @trading&.update(attributes)
      unless @trading&.valid?
        errors.add(:model, @trading&.errors)
        @stock.destroy!
      end

      @trading
    end
  end
end
