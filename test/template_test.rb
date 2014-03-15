require 'test_helper'

class TemplateTest < Minitest::Test

  def setup
    @template = build_template_instance
  end

  def test_default
    rendered = @template.render
    assert_equal load_fixture("template/default"), JSON.parse(rendered)
  end

  def test_pretty
    rendered = @template.render pretty: true
    assert_equal load_fixture("template/default"), JSON.parse(rendered)
  end

  def test_adding_single_resource
    template = build_template_instance
    table = build_dynamo_table_instance

    template.add_resource table
    rendered = template.render pretty: true

    assert_equal load_fixture("template/adding_single_resource"), JSON.parse(rendered)
  end


  def test_adding_multiple_resources
    template = build_template_instance
    dynamo_db = CloudFormation::DynamoDB.new

    build_dynamo_table_instance dynamo_db
    build_dynamo_table_instance dynamo_db, name: "tableName2"


    template.add_resources dynamo_db.tables

    rendered = template.render pretty: true

    assert_equal load_fixture("template/adding_multiple_resources"), JSON.parse(rendered)
  end

end
