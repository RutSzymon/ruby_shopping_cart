# frozen_string_literal: true

module ItemValueLogic
  class Interface
    attr_reader :items

    def initialize(items)
      @items = items
    end

    def execute
      raise NotImplementedError, 'subclass did not define #execute'
    end
  end
end
