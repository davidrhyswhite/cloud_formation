module FactoryHelpers

  def build_template_instance opts = {}
    options = {
      name: "stack-name",
      description: "A description of the stack"
    }
    options.merge! opts
    template = CloudFormation::Template.new

    template.build do |t|
      t.name = options[:name]
      t.description = options[:description]
    end
    template
  end

  def build_dynamo_table_instance db = nil, opts = {}
    db = CloudFormation::DynamoDB.new if db === nil
    options = {
      name: "tableName",
      read_capacity_units: 10,
      write_capacity_units: 5,
      hash_key: { column_one_id: :number },
      range_key: { column_two_id: :number }

    }
    options.merge! opts

    table = db.build_table do |t|
      t.name = options[:name]
      t.read_capacity_units = options[:read_capacity_units]
      t.write_capacity_units = options[:write_capacity_units]
      t.hash_key = options[:hash_key]
      t.range_key = options[:range_key]
    end
    table
  end
end
