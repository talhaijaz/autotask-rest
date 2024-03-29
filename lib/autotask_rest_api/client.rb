require 'rest-client'

module AutotaskRestApi

  class << self
    attr_accessor :client
  end

  def self.client
    @client ||= Client.new
  end

  class Client
    attr_reader :config

    def initialize
      @config = AutotaskRestApi.config
      yield @config if block_given?
    end

    def default_headers
      { ApiIntegrationCode: config.integration_code, UserName: config.username, Secret: config.password }
    end

    def get_data(entity, conditions = {})
      url = config.url + "/#{entity}/query"
      RestClient.get(url, default_headers.merge!(params: { search: conditions.to_json }))
    end

    def patch_data(entity, body = {})
      if entity == 'ContractServices' || entity == 'ContractCharges'
        return invalid_contract_id unless body['contractID']
      end
      url = compose_url(entity, body)

      begin
        RestClient.patch(url, body.except('contractID'), default_headers)
      rescue StandardError => e
        handle_exception(e)
      end
    end

    def post_data(entity, body = {})
      if entity == 'ContractServices' || entity == 'ContractCharges'
        return invalid_contract_id unless body['contractID']
      end
      url = compose_url(entity, body) 

      begin
        RestClient.post(url, body, default_headers)
      rescue StandardError => e
        handle_exception(e)
      end
    end

    def handle_exception(exception)
      if exception.http_code == 404
        OpenStruct.new({ code: exception.http_code,
                         body: 'The resource you are looking for might have been removed or had its name changed or is temporarily unavailable.' })
      elsif exception.http_code == 401
        OpenStruct.new({ code: exception.http_code, body: exception.message})
      else
        OpenStruct.new({ code: exception.http_code, body: JSON(exception.http_body)['errors'].first })
      end
    end

    def invalid_contract_id
      OpenStruct.new({ code: 500,
        body: 'ContractID not present' })
    end

    def compose_url(entity, body)
      case entity
      when 'ContractServices'
        config.url + "/Contracts/#{body['contractID']}/Services"
      when 'ContractCharges'
        config.url + "/Contracts/#{body['contractID']}/Charges"
      else
        config.url + "/#{entity}"
      end
    end
  end
end
