module Tfc
  module Mdm
    module Backend
      module Memberships
        class BillingRunServicesController < Cmor::Core::Backend::ServiceController::Base
          def self.engine_class
            ::Tfc::Mdm::Backend::Engine
          end
          
          def self.service_class
            Tfc::Mdm::Memberships::BillingRunService
          end

          private

          def initialize_service
            super
            @service.year = params[:year] if params[:year].present?
            @service.club_id = params[:club_id] if params[:club_id].present?
            @service.valid?
          end

          def permitted_params
            params.require(:memberships_billing_run_service).permit(:club_id, :year, memberships: [:selected])
          end
        end
      end
    end
  end
end
