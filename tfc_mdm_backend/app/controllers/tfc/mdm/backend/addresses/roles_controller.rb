# frozen_string_literal: true

module Tfc
  module Mdm
    module Backend
      module Addresses
        class RolesController < Cmor::Core::Backend::ResourcesController::Base
          def self.engine_class
            ::Tfc::Mdm::Backend::Engine
          end

          def self.resource_class
            Tfc::Mdm::Addresses::Role
          end

          private

            def permitted_params
              params.require(:addresses_role).permit(:club_id, :identifier)
            end
        end
      end
    end
  end
end
