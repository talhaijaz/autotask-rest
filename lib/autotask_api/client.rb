require 'rest-client'

module AutotaskApi

  class << self
    attr_accessor :client
  end

  def self.client
    @client ||= Client.new
  end

  class Client
    NAMESPACE = 'http://autotask.net/ATWS/v1_6/'

    attr_reader :config

    def initialize
      @config = AutotaskApi.config
      yield @config if block_given?
    end

    def default_headers
      { ApiIntegrationCode: config.integration_code, UserName: config.username,  Secret: config.password }
    end

    def call(operation, message = {})
      url = config.url + "/#{operation}/query"
      RestClient.get(url, headers=default_headers.merge!(params: { search: message.to_json }))
    end
  end
end