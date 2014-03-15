require 'json'

module CloudFormation
  class Template < Base
    using Refinements
    AWS_TEMPLATE_FORMAT_VERSION = "2010-09-09"

    attribute_list :name, :description, :resources

    def initialize
      @resources = {}
    end

    def add_resource resource
      @resources[resource.name] = resource.serialize.tap { |a| a.delete("Name") }
    end

    def add_resources resources
      resources.each { |resource| add_resource resource }
    end

    def render pretty: false, indentation: 2
      pretty ? JSON.pretty_generate(serialize, indent: " "*indentation) : serialize.to_json
    end

    private

      def serialize
        attributes.inject(default_hash) do |hash, value|
          hash[value.to_s.camel_case] = self.send value
          hash
        end
      end

      def default_hash
        { "AWSTemplateFormatVersion" => AWS_TEMPLATE_FORMAT_VERSION }
      end
  end
end
