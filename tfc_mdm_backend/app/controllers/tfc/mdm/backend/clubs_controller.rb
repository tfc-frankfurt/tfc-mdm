# frozen_string_literal: true

module Tfc
  module Mdm
    module Backend
      class ClubsController < Cmor::Core::Backend::ResourcesController::Base
        include SimpleFormPolymorphicAssociations::Controller::AutocompleteConcern

        view_helper Tfc::Mdm::Backend::ApplicationViewHelper, as: :tfc_mdm_backend_helper
        view_helper TimelineEvents::ApplicationViewHelper, as: :timeline_helper

        def self.resource_class
          Tfc::Mdm::Club
        end

        private

          def permitted_params
            params.require(:club).permit %i(establishment_id name logo favicon)
          end
      end
    end
  end
end
