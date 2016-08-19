module AutotaskApi
  class Client

    NAMESPACE = 'http://autotask.net/ATWS/v1_5/'

    attr_reader :config

    def initialize
      @config = AutotaskApi.config
      yield @config
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