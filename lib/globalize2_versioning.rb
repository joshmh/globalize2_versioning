module Globalize
  module Model
    module ActiveRecord
      module Versioned
        def self.included(base)
          base.extend ActMethods
        end

        module ActMethods
        end
        
      end
    end
  end
end