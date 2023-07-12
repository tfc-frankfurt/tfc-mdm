# frozen_string_literal: true

module Tfc
  module Mdm
    module Backend
      module Achievements
        class CategoriesController < Cmor::Core::Backend::ResourcesController::Base
          def self.engine_class
            ::Tfc::Mdm::Backend::Engine
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
