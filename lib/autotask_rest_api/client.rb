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

    def post_data(entity, body = {})
      url = config.url + "/#{entity}"
      begin
        RestClient.post(url, body, default_headers)
      rescue StandardError => e
        handle_exception(e)
      end
    end

    def patch_data(entity, body = {})
      url = if entity == 'ContractServices'
              config.url + "/Contracts/#{body['contractID']}/Services"
            else
              config.url + "/#{entity}"
            end
      begin
        RestClient.patch(url, body.except('contractID'), default_headers)
      rescue StandardError => e
        handle_exception(e)
      end
    end

    def handle_exception(exception)
      if exception.http_code == 404
        OpenStruct.new({ code: exception.http_code,
                         body: 'The resource you are looking for might have been removed or had its name changed or is temporarily unavailable.' })
      else
        OpenStruct.new({ code: exception.http_code, body: JSON(exception.http_body)['errors'].first })
      end
    end
  end
end
