# frozen_string_literal: true

module Tfc
  module Mdm
    module Api
      module Addresses
        class RolesController < ::Tfc::Mdm::Api::ResourcesController::Base
          def self.engine_class
            Tfc::Mdm::Api::Engine
          end

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
