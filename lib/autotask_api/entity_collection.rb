module AutotaskApi
  class EntityCollection
    include Enumerable

    attr_accessor :condition

    attr_reader :entities, :client

    def initialize(entities, condition, client = AutotaskApi.client)
      @entities = entities
      @condition = condition
      @client = client
    end

    def each(&block)
      entities.each(&block)
    end

    def next_page?
      entities.size >= 500
    end

    def next_page
      new_expression = Expression.new('id', 'GreaterThan', entities.last.id)
      new_condition = condition

      # TODO: find and replace the Expression inside new_condition related to the id field with new_expression

      entities.first.class.where(new_condition, client)
    end

  end
end