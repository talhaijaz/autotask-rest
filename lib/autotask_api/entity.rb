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
      results.each do |record|
        record.update(record){ |k,v| v == {:"@xsi:type"=>"xsd:string"} ? nil : v }
          .delete('@xsi:type'.to_sym)
      end

      return results
    end

  end

  class Account < Entity
    NAME = 'Account'
  end

  class AccountLocation < Entity
    NAME = 'AccountLocation'
  end

  class AccountTeam < Entity
    NAME = 'AccountTeam'
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

  class ContractBlock < Entity
    NAME = 'ContractBlock'
  end

  class ContractCost < Entity
    NAME = 'ContractCost'
  end

  class ContractExclusionAllocationCode < Entity
    NAME = 'ContractExclusionAllocationCode'
  end

  class ContractExclusionRole < Entity
    NAME = 'ContractExclusionRole'
  end

  class ContractFactor < Entity
    NAME = 'ContractFactor'
  end

  class ContractMilestone < Entity
    NAME = 'ContractMilestone'
  end

  class ContractRate < Entity
    NAME = 'ContractRate'
  end

  class ContractRetainer < Entity
    NAME = 'ContractRetainer'
  end

  class ContractRoleCost < Entity
    NAME = 'ContractRoleCost'
  end

  class ContractService < Entity
    NAME = 'ContractService'
  end

  class ContractServiceAdjustment < Entity
    NAME = 'ContractServiceAdjustment'
  end

  class ContractServiceBundle < Entity
    NAME = 'ContractServiceBundle'
  end

  class ContractServiceBundleAdjustment < Entity
    NAME = 'ContractServiceBundleAdjustment'
  end

  class ContractServiceBundleUnit < Entity
    NAME = 'ContractServiceBundleUnit'
  end

  class ContractServiceUnit < Entity
    NAME = 'ContractServiceUnit'
  end

  class ContractTicketPurchase < Entity
    NAME = 'ContractTicketPurchase'
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
