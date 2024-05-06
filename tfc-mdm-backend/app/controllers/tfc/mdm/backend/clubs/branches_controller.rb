# frozen_string_literal: true

module Tfc
  module Mdm
    module Backend
      module Clubs
        class BranchesController < Cmor::Core::Backend::ResourcesController::Base
          view_helper Twitter::Bootstrap::Components::Rails::V4::ViewHelper, as: :bootstrap_helper
          view_helper Tfc::Mdm::Backend::ApplicationViewHelper, as: :tfc_mdm_backend_helper

          def self.resource_class
            Tfc::Mdm::Clubs::Branch
          end

          def self.engine_class
            Tfc::Mdm::Backend::Engine
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
