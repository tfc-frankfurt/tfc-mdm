# frozen_string_literal: true

module Tfc
  module Mdm
    module Backend
      class MembershipAgreementsController < Cmor::Core::Backend::ResourcesController::Base
        def self.resource_class
          Tfc::Mdm::MembershipAgreement
        end

        private

          def load_collection_scope
            super.joins(:club).includes(:person).order(entry_at: :desc)
          end

          def permitted_params
            params.require(:membership_agreement).permit(%i(club_id salutation firstname lastname street zipcode city country birthdate phone email entry_at))
          end

          module PersonConcern
            extend ActiveSupport::Concern

            included do
              after_action :call_create_person_from_membership_agreement_service, only: :create, if: proc { params.key?(:call_create_person_from_membership_agreement_service) }
            end

            private

              def call_create_person_from_membership_agreement_service
                Tfc::Mdm::CreatePersonFromMembershipAgreementService.call(membership_agreement_id: @resource.id)
              end
          end

          include PersonConcern
      end
    end
  end
end
