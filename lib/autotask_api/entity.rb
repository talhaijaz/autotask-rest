module AutotaskApi
  class Entity

    # @param conditions [Hash]
    def self.where(conditions, client = Client.new)
      query = Query.new(self::NAME, client)

      conditions.each do |k, v|
        query.add_condition(k.to_s.camelize, 'equals', expression(v))
      end

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
end