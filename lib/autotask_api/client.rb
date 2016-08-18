module AutotaskApi
  class Client

    NAMESPACE = 'http://autotask.net/ATWS/v1_5/'

    def savon_client
      @savon_client ||= Savon.client(
          wsdl: AutotaskApi.config.wsdl,
          logger: Rails.logger,
          log_level: :debug,
          log: AutotaskApi.config.debug,
          basic_auth: [AutotaskApi.config.username, AutotaskApi.config.password]
      )
    end

    def call(operation, message = {})
      savon_client.call(operation, message: message, attributes: { xmlns: NAMESPACE })
    end

  end
end