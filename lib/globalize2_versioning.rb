module Globalize
  module Model
    module ActiveRecord
      module Versioned
        def self.included(base)
          base.extend ActMethods
        end

        module ActMethods
          def translates(*attr_names)
            options = attr_names.extract_options!
            options[:translated_attributes] = attr_names

            # Only set up once per class
            unless included_modules.include? InstanceMethods
              class_inheritable_accessor :globalize_options
              include Globalize::Model::ActiveRecord::Translated::InstanceMethods
              include InstanceMethods
              extend  Globalize::Model::ActiveRecord::Translated::ClassMethods
              
              proxy_class = Globalize::Model::ActiveRecord.create_proxy_class(self)
              has_many :globalize_translations, :class_name => proxy_class.name do
                def by_locales(locales)
                  find :all, :conditions => { :locale => locales.map(&:to_s) }
                end
              end
              
              before_save :bump_version
              after_save  :update_globalize_record
                            
              def i18n_attr(attribute_name)
                self.name.underscore + "_translations.#{attribute_name}"
              end
            end

            self.globalize_options = options
            Globalize::Model::ActiveRecord.define_accessors(self, attr_names)
          end        
        end

        module ClassMethods
        end
        
        module InstanceMethods
          def bump_version
            self.version = next_version if new_record? || save_version?
          end
          
          def next_version
            ( globalize_translations.calculate(:max, :version) || 0 ) + 1
          end
                    
          # Checks whether a new version should be saved or not.
          def save_version?
            ( globalize_options[:versioned] & changed ).length > 0
          end
                
        end        
      end
    end
  end
end