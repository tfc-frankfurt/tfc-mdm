# frozen_string_literal: true

module Tfc
  module Mdm
    module Api
      module Achievements
        class CategoriesController < ::Tfc::Mdm::Api::ResourcesController::Base
          def self.engine_class
            Tfc::Mdm::Api::Engine
          end

          def self.resource_class
            Tfc::Mdm::Achievements::Category
          end

          private

            def load_collection_scope
              super.includes(:club)
            end

            def permitted_params
              params.require(:achievements_category).permit(
                :club_id,
                :name_en,
                :name_de
              )
            end
        end
      end
    end
  end
end
