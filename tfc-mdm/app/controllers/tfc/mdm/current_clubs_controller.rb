# frozen_string_literal: true

module Tfc
  module Mdm
    class CurrentClubsController < Tfc::Mdm::Configuration.base_controller.constantize
      include Rao::ResourceController::RestActionsConcern
      include Rao::ResourceController::ResourceConcern
      include Rao::ResourceController::RestResourceUrlsConcern
      include Rao::ResourceController::ResourceInflectionsConcern

      helper Rao::Component::ApplicationHelper

      def self.resource_class
        Tfc::Mdm::Club
      end

      private

      def load_resource
        @resource = current_club
      end
    end
  end
end
