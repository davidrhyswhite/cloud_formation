# CloudFormation

A Ruby gem to create AWS CloudFormation descriptions.

## Installation

Add this line to your application's Gemfile:

    gem 'cloud_formation'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cloud_formation

## Usage

### Generate a template

```ruby
template = CloudFormation::Template.new

template.build do |t|
  t.name = "stack-name"
  t.description = "A description of the stack"
end

template.render
```

Running this will generate a nicely compacted:
```json
{"AWSTemplateFormatVersion":"2010-09-09","Name":"stack-name","Description":"A description of the stack","Resources":{}}
```

### Generate a DynamoDB table

Generating a DynamoDB table is as simple as:

```ruby
template = CloudFormation::Template.new

template.build do |t|
  t.name = "stack-name"
  t.description = "A description of the stack"
end

dynamo_db = CloudFormation::DynamoDB.new

table = dynamo_db.build_table do |t|
  t.name = "commentsTable"
  t.read_capacity_units = 10
  t.write_capacity_units = 5
  t.hash_key = { blog_post_id: :number }
  t.range_key = { comment_id: :number }
end

template.add_resource table

puts template.render pretty: true
```

Running with the `pretty true` options will generate an easier to read version:

```json
{
  "AWSTemplateFormatVersion": "2010-09-09",
  "Name": "stack-name",
  "Description": "A description of the stack",
  "Resources": {
    "commentsTable": {
      "Type": "AWS::DynamoDB::Table",
      "Properties": {
        "ProvisionedThroughput": {
          "WriteCapacityUnits": "5",
          "ReadCapacityUnits": "10"
        },
        "KeySchema": {
          "RangeKeyElement": {
            "AttributeName": "comment_id",
            "AttributeType": "N"
          },
          "HashKeyElement": {
            "AttributeName": "blog_post_id",
            "AttributeType": "N"
          }
        }
      }
    }
  }
}
```

## Contributing

1. Fork it ( http://github.com/davidrhyswhite/cloud_formation/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
