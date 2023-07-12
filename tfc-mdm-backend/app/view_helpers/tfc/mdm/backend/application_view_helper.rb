# frozen_string_literal: true

module Tfc
  module Mdm
    module Backend
      class ApplicationViewHelper < Rao::ViewHelper::Base
        def addressable_table_columns(table)
          render locals: { table: table }
        end

        private

          def render(*args)
            options = args.extract_options!
            partial = args.first || "/#{self.class.name.underscore}/#{caller_locations(1, 1)[0].label}"
            c.render options.merge(partial: partial)
          end
      end
    end
  end
end
