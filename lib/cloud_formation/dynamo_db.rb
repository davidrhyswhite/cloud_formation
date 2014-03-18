module CloudFormation
  class DynamoDB < Base

    attr_accessor :tables

    def initialize
      @tables = []
    end

    def build_table &block
      table = Table.new
      yield table
      @tables << table
      table
    end

    private

      class Table < Base
        attribute_list :name, :read_capacity_units, :write_capacity_units, :hash_key, :range_key

        attr_accessor :attribute_definitions

        def initialize
          @attribute_definitions = []
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
          properties["Properties"].merge! add_key_schemas
          properties["Properties"]["AttributeDefinitions"] = @attribute_definitions unless @attribute_definitions.empty?
          properties
        end

        def add_attribute attr_name, attr_value
          @attribute_definitions << { "AttributeName" => attr_name.to_s, "AttributeType" => type_mapping(attr_value) }
        end

        private

          def type_mapping type
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
            { "AttributeName" => k.to_s, "AttributeType" => type_mapping(key[k])  }
          end

      end

  end
end
