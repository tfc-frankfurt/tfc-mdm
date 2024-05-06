module Tfc
  module Mdm
    module Backend
      module Memberships
        class MembershipsController < Cmor::Core::Backend::ResourcesController::Base
          include SimpleFormPolymorphicAssociations::Controller::AutocompleteConcern

          def self.engine_class
            ::Tfc::Mdm::Backend::Engine
          end

          def self.resource_class
            Tfc::Mdm::Memberships::Membership
          end

          private

          def query_allowed_scopes
            %i[active]
          end

          def load_collection_scope
            super.joins(:club, :person)
          end

          def permitted_params
            params.require(:memberships_membership).permit(:club_id, :category_id, :active_from, :active_to, :person_id, :membership_number)
          end
        end
      end
    end
  end
end
