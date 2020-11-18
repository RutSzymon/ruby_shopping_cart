# frozen_string_literal: true

require_relative 'interface'

module ItemValueLogic
  class ThreeOrMoreSilkDresses < ItemValueLogic::Interface
    def execute
      condition(items) ? { '003' => 10 } : {}
    end

    private

    def condition(items)
      items.select { |i| i == '003' }.size > 2
    end
  end
end
