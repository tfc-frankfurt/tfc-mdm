# frozen_string_literal: true

module Tfc
  module Mdm
    module Api
      module Clubs
        class BranchesController < ::Tfc::Mdm::Api::ResourcesController::Base
          def self.resource_class
            Tfc::Mdm::Clubs::Branch
          end

          private

            def permitted_params
              params.require(:clubs_branch).permit(:club_id, :identifier, :valid_from, :valid_to, :name, :description, assets: [])
            end
        end
      end
    end
  end
end
