# frozen_string_literal: true

module Tfc
  module Mdm
    module Backend
      module Clubs
        class ClubsController < Cmor::Core::Backend::ResourcesController::Base
          include SimpleFormPolymorphicAssociations::Controller::AutocompleteConcern

          view_helper Tfc::Mdm::Backend::ApplicationViewHelper, as: :tfc_mdm_backend_helper
          view_helper TimelineEvents::ApplicationViewHelper, as: :timeline_helper

          def self.resource_class
            Tfc::Mdm::Clubs::Club
          end

          def self.engine_class
            Tfc::Mdm::Backend::Engine
          end

          private

          def permitted_params
            params.require(:clubs_club).permit %i(establishment_id name logo favicon vat_identifier tax_number)
          end

          def load_resource_scope
            super.friendly
          end
        end
      end
    end
  end
end
