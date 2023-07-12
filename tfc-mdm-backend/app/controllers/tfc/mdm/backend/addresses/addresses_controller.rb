# frozen_string_literal: true

module Tfc
  module Mdm
    module Backend
      module Addresses
        class AddressesController < Cmor::Core::Backend::ResourcesController::Base
          def self.engine_class
            ::Tfc::Mdm::Backend::Engine
          end

          def self.resource_class
            Tfc::Mdm::Addresses::Address
          end

          private

            def load_collection_scope
              super.includes(:role)
            end

            def initialize_resource
              @resource = resource_class.new(params.fetch(:address, {}).permit!)
            end

            def permitted_params
              params.require(:addresses_address).permit(
                :record_id,
                :record_type,
                :role_id,
                :valid_from,
                :valid_to,
                :line1,
                :line2,
                :street,
                :zipcode,
                :city,
                :country
              )
            end
        end
      end
    end
  end
end
