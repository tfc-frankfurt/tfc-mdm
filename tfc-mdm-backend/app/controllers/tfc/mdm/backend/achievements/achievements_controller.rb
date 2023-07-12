# frozen_string_literal: true

module Tfc
  module Mdm
    module Backend
      module Achievements
        class AchievementsController < Cmor::Core::Backend::ResourcesController::Base
          include Rao::ResourcesController::ActsAsPublishedConcern
          include Rao::ResourcesController::ActsAsListConcern

          def self.engine_class
            ::Tfc::Mdm::Backend::Engine
          end

          def self.resource_class
            Tfc::Mdm::Achievements::Achievement
          end

          private

            def load_collection_scope
              super.includes(:club)
            end

            def permitted_params
              params.require(:achievements_achievement).permit(:club_id, :category_id, :achiever_type, :achiever_id, :happened_at, :title, :body, :published, :image)
            end
        end
      end
    end
  end
end
