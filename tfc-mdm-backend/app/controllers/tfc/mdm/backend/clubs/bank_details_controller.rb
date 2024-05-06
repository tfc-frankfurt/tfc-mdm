# frozen_string_literal: true

module Tfc
  module Mdm
    module Backend
      module Clubs
        class BankDetailsController < Cmor::Core::Backend::ResourcesController::Base
          def self.resource_class
            Tfc::Mdm::Clubs::BankDetail
          end

          def self.engine_class
            Tfc::Mdm::Backend::Engine
          end

          private

          def permitted_params
            params.require(:clubs_bank_detail).permit(:club_id, :role, :account_holder, :bank_name, :bic, :iban, :note)
          end
        end
      end
    end
  end
end
