# frozen_string_literal: true

module Tfc
  module Mdm
    module Backend
      class PeopleController < Cmor::Core::Backend::ResourcesController::Base
        include SimpleFormPolymorphicAssociations::Controller::AutocompleteConcern

        def self.resource_class
          Tfc::Mdm::Person
        end

        private

        def resource_path(resource)
          polymorphic_path(resource)
        end

        def edit_resource_path(resource)
          edit_polymorphic_path(resource)
        end

        def permitted_params
          params.require(:person).permit %i(salutation firstname lastname birthdate user_id)
        end
      end
    end
  end
end
