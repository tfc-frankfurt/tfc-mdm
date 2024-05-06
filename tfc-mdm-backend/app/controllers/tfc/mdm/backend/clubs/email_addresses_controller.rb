# frozen_string_literal: true

module Tfc
  module Mdm
    module Backend
      module Clubs
        class EmailAddressesController < Cmor::Core::Backend::ResourcesController::Base
          def self.resource_class
            Tfc::Mdm::Clubs::EmailAddress
          end

          def self.engine_class
            Tfc::Mdm::Backend::Engine
          end

          private

          def permitted_params
            params.require(:clubs_email_address).permit()
          end
        end
      end
    end
  end
end
