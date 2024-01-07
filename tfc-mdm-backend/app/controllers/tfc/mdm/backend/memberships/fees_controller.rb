module Tfc
  module Mdm
    module Backend
      module Memberships
        class FeesController < Cmor::Core::Backend::ResourcesController::Base
          def self.engine_class
            ::Tfc::Mdm::Backend::Engine
          end

          def self.resource_class
            Tfc::Mdm::Memberships::Fee
          end

          private

          def load_collection_scope
            super.joins(:category, :club)
          end

          def permitted_params
            params.require(:memberships_fee).permit(:category_id, :amount, :active_from, :active_to, :description)
          end
        end
      end
    end
  end
end