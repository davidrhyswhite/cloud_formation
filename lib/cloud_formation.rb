require "cloud_formation/version"

module CloudFormation
  autoload :Refinements, "cloud_formation/refinements"
  autoload :Base, "cloud_formation/base"
  autoload :Template, "cloud_formation/template"
  autoload :DynamoDB, "cloud_formation/dynamo_db"
end
