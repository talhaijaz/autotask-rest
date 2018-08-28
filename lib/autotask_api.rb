require 'nokogiri'
require 'savon'

require 'autotask_api/version'
require 'autotask_api/config'
require 'autotask_api/client'
require 'autotask_api/query'
require 'autotask_api/entity'
require 'autotask_api/entity_collection'

module AutotaskApi
  class Error < StandardError
    def initialize(msg)
      # extract SOAP Exception message if present
      if msg.include?('[SoapException:')
        msg = msg[/\[SoapException:(.*?)\]/, 1]&.strip
      end

      super(msg)
    end
  end
end