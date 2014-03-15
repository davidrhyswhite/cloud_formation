require 'test_helper'

class TemplateTest < Minitest::Test

  def setup
    @template = CloudFormation::Template.new

    @template.build do |t|
      t.name = "stack-name"
      t.description = "A description of the stack"
    end
  end

  def test_default
    rendered = @template.render
    assert_equal load_fixture("template/default"), JSON.parse(rendered)
  end

  def test_pretty
    rendered = @template.render pretty: true
    assert_equal load_fixture("template/default"), JSON.parse(rendered)
  end

end
