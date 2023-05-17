# frozen_string_literal: true

module Tfc
  module Mdm
    module Backend
      module Positions
        class EntriesController < Cmor::Core::Backend::ResourcesController::Base
          def self.engine_class
            ::Tfc::Mdm::Backend::Engine
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
