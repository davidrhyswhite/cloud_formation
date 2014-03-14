module CloudFormation
  class DynamoDB < Base
    attribute_list :name, :read_capacity_units, :write_capacity_units, :hash_key, :range_key

    def build_table &block
      yield self
      self
    end

    def serialize
      properties = {
        "Type" => "AWS::DynamoDB::Table",
        "Properties" => {
          "ProvisionedThroughput" => {
            "WriteCapacityUnits" => @write_capacity_units.to_s,
            "ReadCapacityUnits" => @read_capacity_units.to_s
          }
        }
      }
      properties.merge add_key_schemas
    end


    private

      def key_type_mapping type
        case type
          when :string then "S"
          when :number then "N"
          when :binary then "B"
        end
      end

      def add_key_schemas
        key_schema = { "KeySchema" => {}}
        key_schema["KeySchema"]["RangeKeyElement"] = add_key_schema_for(@range_key) if @range_key
        key_schema["KeySchema"]["HashKeyElement"] = add_key_schema_for(@hash_key) if @hash_key
        key_schema
      end

      def add_key_schema_for key
        k = key.keys.first
        { "AttributeName" => k.to_s, "AttributeType" => key_type_mapping(key[k])  }
      end

  end
end
