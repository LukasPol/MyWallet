class Trading
  class Creator < Base
    prepend SimpleCommand

    def call
      @trading = Trading.new(attributes)
      unless @trading.valid?
        errors.add(:model, @trading.errors)
        @stock.destroy!
      end

      @trading
    end
  end
end
