module AutotaskRestApi
    class DMQuery
      attr_accessor :entity, :client, :body
  
      def initialize(entity, body, client = AutotaskRestApi.client)
        @entity = entity
        @client = client
        @body = body
      end
  
      def fetch
        response = client.post_data entity, body
        JSON(response.body)
      end
    end
  end
  