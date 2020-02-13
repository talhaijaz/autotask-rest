module AutotaskApi
  class Query
    attr_accessor :entity, :client, :condition

    def initialize(entity, condition = nil, client = AutotaskApi.client)
      @entity = entity
      @client = client
      @condition = condition
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

    def query_string
      Nokogiri::XML::Builder.new do
        sXML do
          cdata(
            Nokogiri::XML::Builder.new do |xml|
              xml.queryxml do
                xml.entity entity
                xml.query do
                  condition.to_xml(xml)
                end
              end
            end.doc.root
          )
        end
      end.doc.root.to_s
    end

  end

  class Condition

    attr_reader :expressions, :operator

    def initialize(expressions, operator = 'AND')
      @expressions = expressions.is_a?(Array) ? expressions : [expressions]
      @operator = operator
    end

    def to_xml(xml)
      xml.condition do
        expressions.each { |expression| expression.to_xml(xml) }
      end
    end

    def self.from_hash(condition = {})
      expressions = condition[:expressions].map do |expression|
        expression.has_key?(:expressions) ? Condition.from_hash(expression) : Expression.from_hash(expression)
      end

      new expressions, condition[:operator] || 'AND'
    end

    def remove_expression_by_field(field)
      expressions.reject! do |expression|
        expression.is_a?(Condition) ? expression.remove_expression_by_field(field) : expression.field == field
      end
    end

  end

  class Expression

    attr_reader :field, :operator, :value

    def initialize(field, operator, value)
      @field = field
      @operator = operator
      @value = value
    end

    def to_xml(xml)
      xml.field field do
        xml.expression value, op: operator
      end
    end

    def self.from_hash(expression = {})
      new(expression[:field], expression[:operator], expression[:value])
    end

  end

end
