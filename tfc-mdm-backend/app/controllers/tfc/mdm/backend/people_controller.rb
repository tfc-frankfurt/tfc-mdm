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

          def permitted_params
            params.require(:person).permit %i(salutation firstname lastname birthdate)
          end
      end
    end
  end
end
