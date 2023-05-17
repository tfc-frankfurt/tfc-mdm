# frozen_string_literal: true

module Tfc
  module Mdm
    module Api
      module Achievements
        class AchievementsController < ::Tfc::Mdm::Api::ResourcesController::Base
          def self.engine_class
            Tfc::Mdm::Api::Engine
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
