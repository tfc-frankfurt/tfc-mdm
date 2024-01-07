module Tfc
  module Mdm
    module Backend
      module Memberships
        class ImportFromMembershipAgreementServicesController < Cmor::Core::Backend::ServiceController::Base
          def self.engine_class
            ::Tfc::Mdm::Backend::Engine
          end
          
          def self.service_class
            Tfc::Mdm::Memberships::ImportFromMembershipAgreementService
          end
  
          private

          def initialize_service
            super.tap do |service|
              service.attributes = permitted_params
            end
          end
  
          def permitted_params
            params.fetch(:memberships_import_from_membership_agreement_service, {}).permit(:membership_agreement_id)
          end
        end
      end
    end
  end
end
