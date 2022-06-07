module AutotaskRestApi
  class EntityCollection
    include Enumerable

    PAGE_SIZE = 500

    attr_accessor :condition

    attr_reader :entities, :client, :class_name

    def initialize(class_name, entities, condition, client = AutotaskRestApi.client)
      @class_name = class_name
      @entities = entities
      @condition = condition
      @client = client
    end

    def each(&block)
      entities.each(&block)
    end

    def last(&block)
      entities.last(&block)
    end

    def next_page?
      entities.size >= PAGE_SIZE
    end

    def next_page
      new_expression = Expression.new('id', 'GreaterThan', entities.last[:id])

      condition.remove_expression_by_field('id')
      params = condition.expressions.empty? ? new_expression : [condition, new_expression]

      new_condition = Condition.new(params)

      class_name.where(new_condition, client)
    end

    def empty?
      entities.empty?
    end
  end
end
