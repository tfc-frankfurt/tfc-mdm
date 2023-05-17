# frozen_string_literal: true

module Tfc
  module Mdm
    module Backend
      class NotifyAboutNewMembershipAgreementServiceController < Cmor::Core::Backend::ServiceController::Base
        def self.service_class
          Tfc::Mdm::NotifyAboutNewMembershipAgreementService
        end

        private

          def permitted_params
            params.require(:notify_about_new_membership_agreement_service).permit(:membership_agreement_id, :chairman_fullname, :recipients)
          end
      end
    end
  end
end
