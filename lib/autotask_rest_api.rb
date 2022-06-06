require 'nokogiri'

require 'autotask_rest_api/version'
require 'autotask_rest_api/config'
require 'autotask_rest_api/client'
require 'autotask_rest_api/query'
require 'autotask_rest_api/entity'
require 'autotask_rest_api/entity_collection'

module AutotaskRestApi
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