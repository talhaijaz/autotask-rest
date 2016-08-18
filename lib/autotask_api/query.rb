module AutotaskApi
  class Query
    Condition = Struct.new(:field, :op, :expression)
    attr_accessor :entity, :client, :conditions

    def initialize(entity)
      @entity = entity
      @client = Client.new
      @conditions = []
    end

    def fetch
      response = client.call :query, query_string

      result = response.body[:query_response][:query_result]

      if result[:return_code].to_i == -1
        raise result[:errors][:atws_error][:message]
      else
        return result
      end
    end

    def add_condition(field, op, expression)
      self.conditions << Condition.new(field, op, expression)
    end

    def query_string
      Nokogiri::XML::Builder.new do
        sXML do
          cdata(Nokogiri::XML::Builder.new do |xml|
            xml.queryxml do
              xml.entity entity
              xml.query do
                conditions.each do |condition|
                  xml.condition do
                    xml.field condition.field do
                      xml.expression condition.expression,
                                     op: condition.op
                    end
                  end
                end
              end
            end
          end.doc.root)
        end
      end.doc.root.to_s
    end

  end
end