module AutotaskApi

  class << self
    attr_accessor :config
  end

  def self.config
    @config ||= Configuration.new
  end

  def self.configure
    yield(config)
  end

  class Configuration
    attr_accessor :wsdl, :username, :password, :read_timeout, :open_timeout, :debug, :integration_code

    def initialize
      @wsdl = 'https://webservices.autotask.net/atservices/1.6/atws.wsdl'
      @read_timeout = 30
      @open_timeout = 30
      @debug = false
    end

    def set(options = {})
      options.each { |k, v| self.send("#{k.to_s}=", v) }
    end

    def to_hash
      hash = {}
      instance_variables.each { |var| hash[var.to_s.delete('@').to_sym] = instance_variable_get(var) }
      hash
    end

  end

end