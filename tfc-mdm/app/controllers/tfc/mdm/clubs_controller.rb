module Tfc::Mdm
  class ClubsController < Tfc::Mdm::Configuration.base_controller.constantize
    include Rao::ResourcesController::RestActionsConcern
    include Rao::ResourcesController::ResourcesConcern
    include Rao::ResourcesController::RestResourceUrlsConcern
    include Rao::ResourcesController::ResourceInflectionsConcern

    helper Rao::Component::ApplicationHelper

    view_helper Tfc::Mdm::ApplicationViewHelper, as: :tfc_mdm_helper

    def self.resource_class
      Tfc::Mdm::Club
    end

    def self.available_rest_actions
      super - %i(new create edit update destroy)
    end

    private

    def load_resource_scope
      super.friendly
    end
  end
end
