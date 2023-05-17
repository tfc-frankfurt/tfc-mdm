# frozen_string_literal: true

module Tfc
  module Mdm
    module Api
      class ClubsController < ::Tfc::Mdm::Api::ResourcesController::Base
        def self.resource_class
          Tfc::Mdm::Club
        end

        private

          def permitted_params
            params.require(:club).permit %i(establishment_id name logo)
          end
      end
    end
  end
end
