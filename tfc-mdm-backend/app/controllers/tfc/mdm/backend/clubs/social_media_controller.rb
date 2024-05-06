# frozen_string_literal: true

module Tfc
  module Mdm
    module Backend
      module Clubs
        class SocialMediaController < Cmor::Core::Backend::ResourcesController::Base
          def self.resource_class
            Tfc::Mdm::Clubs::SocialMedium
          end

          def self.engine_class
            Tfc::Mdm::Backend::Engine
          end

          private

          def permitted_params
            params.require(:clubs_social_medium).permit()
          end
        end
      end
    end
  end
end
