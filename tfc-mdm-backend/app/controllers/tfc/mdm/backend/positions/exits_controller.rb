# frozen_string_literal: true

module Tfc
  module Mdm
    module Backend
      module Positions
        class ExitsController < Cmor::Core::Backend::ResourcesController::Base
          def self.engine_class
            ::Tfc::Mdm::Backend::Engine
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
