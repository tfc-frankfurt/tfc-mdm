# frozen_string_literal: true

module Tfc
  module Mdm
    module Backend
      module Positions
        class PositionsController < Cmor::Core::Backend::ResourcesController::Base
          include Rao::ResourcesController::ActsAsListConcern

          def self.engine_class
            ::Tfc::Mdm::Backend::Engine
          end

          def self.resource_class
            Tfc::Mdm::Positions::Position
          end

          private

            def load_collection_scope
              super.joins(:club).order(:club_id, :position)
            end

            def permitted_params
              params.require(:positions_position).permit(
                :club_id,
                :name_de,
                :name_en
              )
            end
        end
      end
    end
  end
end
