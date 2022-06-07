module AutotaskRestApi
  class Entity

    def self.all(client = AutotaskRestApi.client, id = 1)
      where(Condition.new(Expression.new('id', 'GreaterThanorEquals', id)), client)
    end

    # @param conditions [Hash]
    def self.where(condition, client = AutotaskRestApi.client)
      query = Query.new(self::NAME, condition, client)

      begin
        response = query.fetch
      rescue RuntimeError => e
        raise Error.new(e.message)
      end

      # return empty collection if there were no results
      return EntityCollection.new(self, [], condition, client) if response[:entity_results].nil?

      results = response[:entity_results][:entity]
      results = [results] unless results.is_a?(Array)
      results = clean_results(results)

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
        record.update(record) { |_k, v| v == { :"@xsi:type" => "xsd:string" } ? nil : v }
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

  class Country < Entity
    NAME = 'Country'
  end

  class Department < Entity
    NAME = 'Department'
  end

  class ExpenseItem < Entity
    NAME = 'ExpenseItem'
  end

  class ExpenseReport < Entity
    NAME = 'ExpenseReport'
  end

  class InstalledProduct < Entity
    NAME = 'InstalledProduct'
  end

  class InstalledProductType < Entity
    NAME = 'InstalledProductType'
  end

  class InternalLocation < Entity
    NAME = 'InternalLocation'
  end

  class InventoryItem < Entity
    NAME = 'InventoryItem'
  end

  class InventoryLocation < Entity
    NAME = 'InventoryLocation'
  end

  class Invoice < Entity
    NAME = 'Invoice'
  end

  class Opportunity < Entity
    NAME = 'Opportunity'
  end

  class PaymentTerm < Entity
    NAME = 'PaymentTerm'
  end

  class Phase < Entity
    NAME = 'Phase'
  end

  class Product < Entity
    NAME = 'Product'
  end

  class Project < Entity
    NAME = 'Project'
  end

  class ProjectCost < Entity
    NAME = 'ProjectCost'
  end

  class ProjectNote < Entity
    NAME = 'ProjectNote'
  end

  class PurchaseOrderItem < Entity
    NAME = 'PurchaseOrderItem'
  end

  class Quote < Entity
    NAME = 'Quote'
  end

  class QuoteItem < Entity
    NAME = 'QuoteItem'
  end

  class QuoteLocation < Entity
    NAME = 'QuoteLocation'
  end

  class Resource < Entity
    NAME = 'Resource'
  end

  class ResourceRole < Entity
    NAME = 'ResourceRole'
  end

  class ResourceSkill < Entity
    NAME = 'ResourceSkill'
  end

  class Role < Entity
    NAME = 'Role'
  end

  class SalesOrder < Entity
    NAME = 'SalesOrder'
  end

  class Service < Entity
    NAME = 'Service'
  end

  class ServiceBundle < Entity
    NAME = 'ServiceBundle'
  end

  class ServiceBundleService < Entity
    NAME = 'ServiceBundleService'
  end

  class ServiceCall < Entity
    NAME = 'ServiceCall'
  end

  class ServiceCallTask < Entity
    NAME = 'ServiceCallTask'
  end

  class ServiceCallTaskResource < Entity
    NAME = 'ServiceCallTaskResource'
  end

  class ServiceCallTicket < Entity
    NAME = 'ServiceCallTicket'
  end

  class ServiceCallTicketResource < Entity
    NAME = 'ServiceCallTicketResource'
  end

  class Skill < Entity
    NAME = 'Skill'
  end

  class Task < Entity
    NAME = 'Task'
  end

  class TaskPredecessor < Entity
    NAME = 'TaskPredecessor'
  end

  class TaskSecondaryResource < Entity
    NAME = 'TaskSecondaryResource'
  end

  class Tax < Entity
    NAME = 'Tax'
  end

  class TaxCategory < Entity
    NAME = 'TaxCategory'
  end

  class TaxRegion < Entity
    NAME = 'TaxRegion'
  end

  class Ticket < Entity
    NAME = 'Ticket'
  end

  class TicketCost < Entity
    NAME = 'TicketCost'
  end

  class TicketSecondaryResource < Entity
    NAME = 'TicketSecondaryResource'
  end

  class TimeEntry < Entity
    NAME = 'TimeEntry'
  end
end
