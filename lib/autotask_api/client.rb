module AutotaskApi
  class Client

    NAMESPACE = 'http://autotask.net/ATWS/v1_5/'

    attr_reader :config

    class << self
      attr_accessor :client
    end

    def self.client
      @client ||= Client.new
    end

    def initialize
      @config = AutotaskApi.config
      yield @config if block_given?
    end

    def savon_client
      @savon_client ||= Savon.client(
          wsdl: config.wsdl,
          logger: Rails.logger,
          log_level: :debug,
          log: config.debug,
          basic_auth: [config.username, config.password]
      )
    end

    def call(operation, message = {})
      savon_client.call(operation, message: message, attributes: { xmlns: NAMESPACE })
    end

  end
end