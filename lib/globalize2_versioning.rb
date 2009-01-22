module Globalize
  module Model
    module ActiveRecord
      module Versioned
        def self.included(base)
          base.extend ActMethods
        end

        module ActMethods
          def versions(*attr_names)
          end          
        end

        module ClassMethods
          def create_translation_table!(fields)
            translated_fields = self.globalize_options[:translated_attributes]
            translated_fields.each do |f|
              raise MigrationMissingTranslatedField, "Missing translated field #{f}" unless fields[f]
            end
            fields.each do |name, type|
              unless translated_fields.member? name 
                raise UntranslatedMigrationField, "Can't migrate untranslated field: #{name}"
              end              
              unless [ :string, :text ].member? type
                raise BadMigrationFieldType, "Bad field type for #{name}, should be :string or :text"
              end 
            end
            translation_table_name = self.name.underscore + '_translations'
            self.connection.create_table(translation_table_name) do |t|
              t.references self.table_name.singularize
              t.string :locale
              fields.each do |name, type|
                t.column name, type
              end
              t.timestamps              
            end
          end

          def drop_translation_table!
            translation_table_name = self.name.underscore + '_translations'
            self.connection.drop_table translation_table_name
          end
        end
        
      end
    end
  end
end