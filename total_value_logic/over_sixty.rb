# frozen_string_literal: true

require_relative 'interface'

module TotalValueLogic
  class OverSixty < TotalValueLogic::Interface
    def execute
      condition(sum) ? [:*, 0.9] : [:*, 1]
    end

    private

    def condition(sum)
      sum > 60
    end
  end
end
