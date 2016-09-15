module AutotaskApi
  class Entity

    def self.all(client = AutotaskApi.client)
      where(Condition.new(Expression.new('id', 'GreaterThan', 0)), client)
    end

    # @param conditions [Hash]
    def self.where(condition, client = AutotaskApi.client)
      query = Query.new(self::NAME, condition, client)
      response = query.fetch

      return [] if response[:entity_results].nil?
      results = clean_results response[:entity_results][:entity]

      results.is_a?(Array) ? results : [results]
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
    NAME = 'account'
  end

  class Contact < Entity
    NAME = 'contact'
  end

  class Contract < Entity
    NAME = 'contract'
  end

  class Resource < Entity
    NAME = 'resource'
  end
end