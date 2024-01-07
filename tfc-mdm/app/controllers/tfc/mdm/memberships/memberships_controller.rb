# frozen_string_literal: true

module Tfc
  module Mdm
    module Memberships
      class MembershipsController < Tfc::Mdm::Configuration.base_controller.constantize
        include Rao::ResourcesController::RestActionsConcern
        include Rao::ResourcesController::ResourcesConcern
        include Rao::ResourcesController::RestResourceUrlsConcern
        include Rao::ResourcesController::ResourceInflectionsConcern

        helper Rao::Component::ApplicationHelper

        def self.available_rest_actions
          %i(index show)
        end

        def self.resource_class
          Tfc::Mdm::Memberships::Membership
        end

        private

        def load_collection_scope
          fetch_current_user.memberships
        end

        def load_resource_scope
          fetch_current_user.memberships
        end

        def fetch_current_user
          instance_exec(&Tfc::Mdm::Configuration.current_user_proc)
        end
      end
    end
  end
end