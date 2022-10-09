module AutotaskRestApi
  
  # Data manipulation query
  class DMQuery 
    attr_accessor :entity, :client, :body, :request_type

    def initialize(entity, condition, client = AutotaskRestApi.client, request_type)
      @entity = entity
      @client = client
      @condition = condition
      @request_type = request_type
    end

    def call_autotask
      response = if request_type == 'get'
                   client.get_data entity, condition
                 elsif request_type == 'patch'
                   client.patch_data entity, condition
                 else
                   client.post_data entity, condition
                 end

      res_body = if response.code == 200
                    if request_type == 'get'
                      JSON(response.body)
                    elsif request_type == 'patch'
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
