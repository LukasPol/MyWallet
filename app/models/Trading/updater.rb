class Trading
  class Updater < Base
    prepend SimpleCommand

    def call
      @trading&.update(attributes)
      check_errors

      @trading
    end
  end
end
