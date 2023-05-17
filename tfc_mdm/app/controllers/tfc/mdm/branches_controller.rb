# frozen_string_literal: true

module Tfc
  module Mdm
    class BranchesController < Tfc::Mdm::Configuration.base_controller.constantize
      include Rao::ResourcesController::RestActionsConcern
      include Rao::ResourcesController::ResourcesConcern
      include Rao::ResourcesController::RestResourceUrlsConcern
      include Rao::ResourcesController::ResourceInflectionsConcern

      # helper ResourceRenderer::ViewHelper

      def self.resource_class
        Tfc::Mdm::Branch
      end

      private

        def load_collection_scope
          super.order(valid_to: :desc).valid.all
        end
    end
  end
end
