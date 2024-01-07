# frozen_string_literal: true

module Tfc
  module Mdm
    module Backend
      module Configuration
        def configure
          yield self
        end

        mattr_accessor :registered_controllers do
          lambda do
            [
              Tfc::Mdm::Backend::AddressesController,
              Tfc::Mdm::Backend::BranchesController,
              Tfc::Mdm::Backend::ClubsController,
              Tfc::Mdm::Backend::EstablishmentsController,
              Tfc::Mdm::Backend::MembershipAgreementsController,
              Tfc::Mdm::Backend::MembershipCancellationsController,
              Tfc::Mdm::Backend::PeopleController,
              Tfc::Mdm::Backend::Addresses::AddressesController,
              Tfc::Mdm::Backend::Addresses::LocationsController,
              Tfc::Mdm::Backend::Addresses::RolesController,
              Tfc::Mdm::Backend::Memberships::CategoriesController,
              Tfc::Mdm::Backend::Memberships::EventsController,
              Tfc::Mdm::Backend::Memberships::EventTypesController,
              Tfc::Mdm::Backend::Memberships::FeesController,
              Tfc::Mdm::Backend::Memberships::MembershipsController
            ]
          end
        end

        mattr_accessor :registered_services do
          lambda do
            [
              Tfc::Mdm::Backend::CreateClubFromEstablishmentServiceController,
              Tfc::Mdm::Backend::CreatePersonFromMembershipAgreementServiceController,
              Tfc::Mdm::Backend::NotifyAboutNewMembershipAgreementServiceController
            ]
          end
        end
      end
    end
  end
end
