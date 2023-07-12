# frozen_string_literal: true

module Tfc
  module Mdm
    module Backend
      class BranchesController < Cmor::Core::Backend::ResourcesController::Base
        view_helper Twitter::Bootstrap::Components::Rails::V4::ViewHelper, as: :bootstrap_helper
        view_helper Tfc::Mdm::Backend::ApplicationViewHelper, as: :tfc_mdm_backend_helper

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
