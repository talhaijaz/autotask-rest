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
      { ApiIntegrationCode: config.integration_code, UserName: config.username,  Secret: config.password }
    end

    def get_data(entity, conditions = {})
      url = config.url + "/#{entity}/query"
      RestClient.get(url, headers=default_headers.merge!(params: { search: conditions.to_json }))
    end

    def post_data(entity, body = {})
      url = config.url + "/#{entity}"
      RestClient.post(url, body, headers=default_headers)
    end
  end
end