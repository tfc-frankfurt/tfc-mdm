# frozen_string_literal: true

module Tfc
  module Mdm
    module Backend
      module Addresses
        class RolesController < Cmor::Core::Backend::ResourcesController::Base
          def self.resource_class
            Tfc::Mdm::Addresses::Role
          end

          private

            def permitted_params
              params.require(:role).permit %i(identifier)
            end
        end
      end
    end
  end
end
