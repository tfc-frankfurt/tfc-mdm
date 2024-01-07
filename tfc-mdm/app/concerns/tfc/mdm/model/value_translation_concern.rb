module Tfc
  module Mdm
    module Model
      module ValueTranslationConcern
        extend ActiveSupport::Concern

        class_methods do
          def human_value_name(attribute, value, options = {})
            if options[:count].present?
              I18n.t("activerecord.values.#{model_name.i18n_key}.#{attribute}.#{value}.#{options[:count]}", default: value)
            else
              translation = I18n.t("activerecord.values.#{model_name.i18n_key}.#{attribute}.#{value}", default: value)
              case translation
              when String
                translation
              when Hash
                translation[:one]
              end
            end
          end
        end
  
        def human_value_name(attribute, options = {})
          self.class.human_value_name(attribute, send(attribute), options)
        end
      end
    end
  end
end
