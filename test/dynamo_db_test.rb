require 'test_helper'

class DynamoDBTest < Minitest::Test

  def setup
    @table = build_dynamo_table_instance
  end

  def test_build_table_should_return_table_class
    dynamo_db = CloudFormation::DynamoDB.new
    table = build_dynamo_table_instance
    assert_instance_of CloudFormation::DynamoDB::Table, table
  end

  def test_build_table_should_add_table_to_tables_array
    dynamo_db = CloudFormation::DynamoDB.new
    assert_empty dynamo_db.tables

    build_dynamo_table_instance dynamo_db
    assert_equal 1, dynamo_db.tables.length
  end

  def test_basic
    expected = @table.serialize
    assert_equal load_fixture("dynamo_db/basic"), expected
  end

end
