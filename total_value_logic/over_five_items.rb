# frozen_string_literal: true

require_relative 'interface'

module TotalValueLogic
  class OverFiveItems < TotalValueLogic::Interface
    def execute
      condition(items) ? [:-, 10] : [:*, 1]
    end

    private

    def condition(items)
      items.size > 5
    end
  end
end
