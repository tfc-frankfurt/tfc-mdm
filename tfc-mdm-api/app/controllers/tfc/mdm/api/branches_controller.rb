# frozen_string_literal: true

module Tfc
  module Mdm
    module Api
      class BranchesController < ::Tfc::Mdm::Api::ResourcesController::Base
        def self.resource_class
          Tfc::Mdm::Branch
        end

        private

          def permitted_params
            params.require(:branch).permit(:club_id, :identifier, :valid_from, :valid_to, :name, :description, assets: [])
          end
      end
    end
  end
end
