require 'test_helper'

class DynamoDBTest < Minitest::Test

  def setup
    @dynamo_db = CloudFormation::DynamoDB.new

    @dynamo_db.build_table do |t|
      t.name = "tableName"
      t.read_capacity_units = 10
      t.write_capacity_units = 5
      t.hash_key = { column_one_id: :number }
      t.range_key = { column_two_id: :number }
    end
  end

  def test_basic
    expected = @dynamo_db.serialize
    assert_equal load_fixture("dynamo_db/basic"), expected
  end

end
