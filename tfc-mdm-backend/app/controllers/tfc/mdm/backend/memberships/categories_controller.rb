module Tfc
  module Mdm
    module Backend
      module Memberships
        class CategoriesController < Cmor::Core::Backend::ResourcesController::Base
          def self.engine_class
            ::Tfc::Mdm::Backend::Engine
          end

          def self.resource_class
            Tfc::Mdm::Memberships::Category
          end

          private

          def permitted_params
            params.require(:memberships_category).permit(:club_id, :identifier, :description)
          end
        end
      end
    end
  end
end
