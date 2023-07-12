# frozen_string_literal: true

module Tfc
  module Mdm
    module Backend
      class CreateClubFromEstablishmentServiceController < Cmor::Core::Backend::ServiceController::Base
        def self.service_class
          Tfc::Mdm::CreateClubFromEstablishmentService
        end

        private

          def permitted_params
            params.require(:create_club_from_establishment_service).permit(:establishment_id)
          end
      end
    end
  end
end
