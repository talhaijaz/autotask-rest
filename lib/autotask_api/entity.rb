module AutotaskApi
  class Entity

    def self.all(client = AutotaskApi.client)
      where(Condition.new(Expression.new('id', 'GreaterThan', 0)), client)
    end

    # @param conditions [Hash]
    def self.where(condition, client = AutotaskApi.client)
      query = Query.new(self::NAME, condition, client)
      clean_results query.fetch[:entity_results][:entity]
    end

    def self.expression(value)
      case value.class
        when TrueClass
          1
        when FalseClass
          0
        else
          value
      end
    end

    # @param results [Array(Hash)]
    def self.clean_results(results)
      results.each { |record| record.delete('@xsi:type'.to_sym) }
      return results
    end

  end

  class Account < Entity
    NAME = 'Account'
  end

  class Contact < Entity
    NAME = 'Contact'
  end

  class Contract < Entity
    NAME = 'Contract'
  end

  class Resource < Entity
    NAME = 'Resource'
  end
end