module AutotaskRestApi
    class DMQuery #Data manipulation query
      attr_accessor :entity, :client, :body
  
      def initialize(entity, body, client = AutotaskRestApi.client)
        @entity = entity
        @client = client
        @body = body
      end
  
      def fetch
        response = client.post_data entity, body
     
        if response.code == 200
          "#{entity} Created Successfully!"
        else
          JSON(response.body)
        end
      end
    end
  end
  