module Globalize
  module Model
    class Adapter
      def update_translations!
        @stash.each do |locale, attrs|
          translation = @record.globalize_translations.find_or_initialize_by_locale(locale.to_s)
          attrs.each{|attr_name, value| translation[attr_name] = value }
          translation.version = @record.version if @record.versioned?
          translation.save!
        end
      end
    end
    
    module ActiveRecord
      
      # Hook this into Globalize2's translates method
      module Translated::Callbacks
        def globalize2_versioning
          if globalize_options[:versioned].blank?
            define_method :'versioned?', lambda { false }
          else
            include Versioned::InstanceMethods
            before_save :bump_version
          end
        end
      end
      
      module Versioned
        module InstanceMethods
          def versioned?; true end
          
          def bump_version
            self.version = next_version if save_version?
          end
          
          def next_version
            ( globalize_translations.maximum(:version) || 0 ) + 1
          end
                    
          # Checks whether a new version should be saved or not.
          def save_version?
            new_record? || ( globalize_options[:versioned].map {|k| k.to_s } & changed ).length > 0
          end                
        end        
      end
    end
  end
end