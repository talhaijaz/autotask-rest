module AutotaskRestApi
  class DMQuery # Data manipulation query
    attr_accessor :entity, :client, :body, :request_type

    def initialize(entity, body, client = AutotaskRestApi.client, request_type)
      @entity = entity
      @client = client
      @body = body
      @request_type = request_type
    end

    def fetch
      response = if request_type == 'patch'
                   client.patch_data entity, body
                 else
                   client.post_data entity, body
                 end

      res_body = if response.code == 200
                  if request_type == 'patch'
                     "#{entity} Updated Successfully!"
                  elsif request_type == 'get'
                      JSON(response.body)
                  else
                     "#{entity} Created Successfully!"
                   end
                 elsif response.code == 500 || response.code == 404
                   response.body
                 else
                   JSON(response.body)
                 end
      OpenStruct.new({ code: response.code, body: res_body })
    end
  end
end
