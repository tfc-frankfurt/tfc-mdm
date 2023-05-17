# frozen_string_literal: true

module Tfc
  module Mdm
    module Api
      class CreatePersonFromMembershipAgreementServiceController < Cmor::Core::Backend::ServiceController::Base
        def self.service_class
          Tfc::Mdm::CreatePersonFromMembershipAgreementService
        end

        def initialize_service
          @service = service_class.new(hashified_params, service_options)
        end

        private

          def permitted_params
            params.fetch(:create_person_from_membership_agreement_service, {}).permit(:membership_agreement_id)
          end
      end
    end
  end
end
