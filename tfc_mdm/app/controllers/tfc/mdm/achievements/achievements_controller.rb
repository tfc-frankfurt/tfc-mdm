# frozen_string_literal: true

module Tfc
  module Mdm
    module Achievements
      class AchievementsController < Tfc::Mdm::Configuration.base_controller.constantize
        include Rao::ResourcesController::RestActionsConcern
        include Rao::ResourcesController::ResourcesConcern
        include Rao::ResourcesController::RestResourceUrlsConcern
        include Rao::ResourcesController::ResourceInflectionsConcern

        def self.resource_class
          Tfc::Mdm::Achievements::Achievement
        end

        private

          def load_collection_scope
            super.published.all
          end
      end
    end
  end
end