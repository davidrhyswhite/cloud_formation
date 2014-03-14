
module CloudFormation

  module Refinements
    refine String do
      def camel_case
        return self if self !~ /_/ && self =~ /[A-Z]+.*/
        split('_').map { |e| e.capitalize }.join
      end
    end
  end
  using Refinements

end
