module AutotaskApi
  class Entity

    def self.all(client = AutotaskApi.client, id = 1)
      where(Condition.new(Expression.new('id', 'GreaterThanorEquals', id)), client)
    end

    # @param conditions [Hash]
    def self.where(condition, client = AutotaskApi.client)
      query = Query.new(self::NAME, condition, client)
      response = query.fetch

      return [] if response[:entity_results].nil?
      results = clean_results response[:entity_results][:entity]
      results = [results] unless results.is_a?(Array)

      EntityCollection.new(self, results, condition, client)
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

  class AccountLocation < Entity
    NAME = 'AccountLocation'
  end

  class Account < Entity
    NAME = 'Account'
  end

  class AllocationCode < Entity
    NAME = 'AllocationCode'
  end

  class BillingItem < Entity
    NAME = 'BillingItem'
  end

  class Contact < Entity
    NAME = 'Contact'
  end

  class Contract < Entity
    NAME = 'Contract'
  end

  class ContractService < Entity
    NAME = 'ContractService'
  end

  class ContractServiceBundle < Entity
    NAME = 'ContractServiceBundle'
  end

  class Department < Entity
    NAME = 'Department'
  end

  class ExpenseItem < Entity
    NAME = 'ExpenseItem'
  end

  class Invoice < Entity
    NAME = 'Invoice'
  end

  class Product < Entity
    NAME = 'Product'
  end

  class Project < Entity
    NAME = 'Project'
  end

  class QuoteItem < Entity
    NAME = 'QuoteItem'
  end

  class Resource < Entity
    NAME = 'Resource'
  end

  class Role < Entity
    NAME = 'Role'
  end

  class Task < Entity
    NAME = 'Task'
  end

  class Ticket < Entity
    NAME = 'Ticket'
  end

  class TimeEntry < Entity
    NAME = 'TimeEntry'
  end
end
