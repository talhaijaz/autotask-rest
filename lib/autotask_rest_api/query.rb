module AutotaskRestApi
  class Query
    attr_accessor :entity, :client, :condition

    def initialize(entity, condition = nil, client = AutotaskRestApi.client)
      @entity = entity
      @client = client
      @condition = condition
    end

    def fetch
      response = client.call entity, condition
      JSON(response.body)
    end
  end
end
