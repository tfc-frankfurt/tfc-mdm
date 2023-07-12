# frozen_string_literal: true

module Tfc::Mdm
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
