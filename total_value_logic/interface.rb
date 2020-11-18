# frozen_string_literal: true

module TotalValueLogic
  class Interface
    attr_reader :items
    attr_reader :sum

    def initialize(items, sum)
      @items = items
      @sum = sum
    end

    def execute
      raise NotImplementedError, 'subclass did not define #execute'
    end
  end
end
