module Tfc
  module Mdm
    module Backend
      class NumberRangesController < Cmor::Core::Backend::ResourcesController::Base
        def self.resource_class
          Tfc::Mdm::NumberRange
        end

        private

        def permitted_params
          params.require(:number_range).permit(
            :format,
            :identifier,
            :minimum_length,
            :next_value,
            :prefix
          )
        end
      end
    end
  end
end
