module CloudFormation
  class Base
    def self.attribute_list *attrs
      attrs.each do |name|
        define_method "#{name}=".to_sym do |value|
          instance_variable_set "@#{name}", value
        end
        define_method name.to_sym do
          instance_variable_get "@#{name}"
        end
      end
      define_method :attributes do
        attrs
      end
    end

    def build &block
      yield self
    end
  end
end
