module Tfc
  module Mdm
    module Backend
      module Memberships
        class EventsController < Cmor::Core::Backend::ResourcesController::Base
          def self.engine_class
            ::Tfc::Mdm::Backend::Engine
          end

          def self.resource_class
            Tfc::Mdm::Memberships::Event
          end

          private

          def initialize_resource
            super.tap do |resource|
              resource.attributes = permitted_params
            end
          end

          def load_collection_scope
            super.joins(:event_type, :membership, :person)
          end

          def permitted_params
            params.fetch(:memberships_event, {}).permit(:event_type_id, :membership_id, :happened_at, :description)
          end
        end
      end
    end
  end
end
