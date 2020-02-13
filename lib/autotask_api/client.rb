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

    def savon_client
      @savon_client ||= Savon.client(
        wsdl: config.wsdl,
        logger: Rails.logger,
        log_level: :debug,
        log: config.debug,
        basic_auth: [config.username, config.password],
        soap_header: soap_header
      )
    end

    def call(operation, message = {})
      savon_client.call(
        operation,
        message: message,
        attributes: { xmlns: NAMESPACE }
      )
    end

    def soap_header
      return nil unless config.integration_code

      xml = Nokogiri::XML::Builder.new do |xml|
        xml.AutotaskIntegrations xmlns: NAMESPACE do
          xml.IntegrationCode config.integration_code
        end
      end

      xml.doc.root.to_s
    end
  end
end