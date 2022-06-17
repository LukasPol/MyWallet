class Trading
  class Creator < Base
    prepend SimpleCommand

    def call
      @trading = Trading.new(attributes)
      check_errors

      @trading
    end
  end
end
