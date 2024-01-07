module Tfc
  module Mdm
    module Backend
      module Memberships
        class EventTypesController < Cmor::Core::Backend::ResourcesController::Base
          def self.engine_class
            ::Tfc::Mdm::Backend::Engine
          end

          def self.resource_class
            Tfc::Mdm::Memberships::EventType
          end

          private

          def permitted_params
            params.require(:memberships_event_type).permit(:identifier, :description)
          end
        end
      end
    end
  end
end