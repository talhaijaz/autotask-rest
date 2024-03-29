module AutotaskRestApi
  class Query
    attr_accessor :entity, :client, :condition

    def initialize(entity, condition = nil, client = AutotaskRestApi.client)
      @entity = entity
      @client = client
      @condition = condition
    end

    def call_autotask
      response = client.get_data entity, condition
      OpenStruct.new({ code: response.code, body: JSON(response.body) })
    end
  end
end
