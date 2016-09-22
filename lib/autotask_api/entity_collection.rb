module AutotaskApi
  class EntityCollection
    include Enumerable

    attr_accessor :condition

    attr_reader :entities, :client, :class_name

    def initialize(class_name, entities, condition, client = AutotaskApi.client)4
      @class_name = class_name
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
      new_expression = Expression.new('id', 'GreaterThan', entities.last[:id])
      condition.remove_expression_by_field('id')

      new_condition = Condition.new([condition, new_expression])

      class_name.where(new_condition, client)
    end

  end
end
