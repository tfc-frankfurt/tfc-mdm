# frozen_string_literal: true

module Tfc
  module Mdm
    module Backend
      class EstablishmentsController < Cmor::Core::Backend::ResourcesController::Base
        def self.resource_class
          Tfc::Mdm::Establishment
        end

        private

          def load_collection_scope
            super.includes(:club)
          end

          def permitted_params
            params.require(:establishment).permit(:name, :logo, :happened_at, :line1, :line2, :street, :zipcode, :city, :country)
          end

          module ClubConcern
            extend ActiveSupport::Concern

            included do
              after_action :call_create_club_from_establishment_service, only: :create, if: proc { params.key?(:call_create_club_from_establishment_service) }
            end

            private

              def call_create_club_from_establishment_service
                Tfc::Mdm::CreateClubFromEstablishmentService.call(establishment_id: @resource.id)
              end
          end

          include ClubConcern
      end
    end
  end
end
