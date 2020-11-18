# frozen_string_literal: true

require_relative 'interface'

module ItemValueLogic
  class TwoOrMoreRedScarfs < ItemValueLogic::Interface
    def execute
      condition(items) ? { '001' => 8.5 } : {}
    end

    private

    def condition(items)
      items.select { |i| i == '001' }.size > 1
    end
  end
end
