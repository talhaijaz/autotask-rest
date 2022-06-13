require 'nokogiri'

require 'autotask_rest_api/version'
require 'autotask_rest_api/config'
require 'autotask_rest_api/client'
require 'autotask_rest_api/query'
require 'autotask_rest_api/dm_query'
require 'autotask_rest_api/entity'
require 'autotask_rest_api/entity_collection'

module AutotaskRestApi
  class Error < StandardError
    def initialize(msg)
      # extract Rest Exception message if present
      if msg.include?('[RestException:')
        msg = msg[/\[RestException:(.*?)\]/, 1]&.strip
      end

      super(msg)
    end
  end
end