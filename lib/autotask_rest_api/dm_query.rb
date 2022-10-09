module AutotaskRestApi
  
  # Data manipulation query
  class DMQuery 
    attr_accessor :entity, :client, :request_body, :request_type

    def initialize(entity, body, client = AutotaskRestApi.client, request_type)
      @entity = entity
      @client = client
      @request_body = body
      @request_type = request_type
    end

    def call_autotask
      response = if request_type == 'patch'
                   client.patch_data entity, request_body
                 else
                   client.post_data entity, request_body
                 end

      res_body = if response.code == 200
                    if request_type == 'patch'
                      "#{entity} Updated Successfully!"
                    else
                      "#{entity} Created Successfully!"
                    end
                 elsif response.code == 500 || response.code == 404 || response.code == 401
                    response.body
                 else
                    JSON(response.body)
                 end
      OpenStruct.new({ code: response.code, body: res_body })
    end
  end
end
