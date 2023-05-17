# frozen_string_literal: true

module Tfc
  module Mdm
    module Api
      module Positions
        class EntriesController < ::Tfc::Mdm::Api::ResourcesController::Base
          def self.engine_class
            Tfc::Mdm::Api::Engine
          end

          def self.resource_class
            Tfc::Mdm::Positions::Entry
          end

          private

            def load_collection_scope
              super.includes(:club)
            end

            def permitted_params
              params.require(:positions_entry).permit(
                :happened_at,
                :club_id,
                :position_id,
                :positionable_type,
                :positionable_id,
                :description,
                :email,
                :image
              )
            end
        end
      end
    end
  end
end
