# frozen_string_literal: true

module Tfc
  module Mdm
    module Api
      module Positions
        class ExitsController < ::Tfc::Mdm::Api::ResourcesController::Base
          def self.engine_class
            Tfc::Mdm::Api::Engine
          end

          def self.resource_class
            Tfc::Mdm::Positions::Exit
          end

          private

            def load_collection_scope
              super.includes(:club)
            end

            def permitted_params
              params.require(:positions_exit).permit %i( club_id entry_id happened_at )
            end
        end
      end
    end
  end
end
