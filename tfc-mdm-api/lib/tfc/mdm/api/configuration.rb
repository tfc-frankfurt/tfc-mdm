module Tfc
  module Mdm
    module Api
      class Configuration
        class << self
          extend Forwardable

          attr_accessor :values

          def define_option(key, default: nil)
            @values[key] = default
            define_singleton_method(key) do
              @values[key]
            end

            define_singleton_method("#{key}=") do |value|
              @values[key] = value
            end
          end
        end

        @values = {}

      define_option :base_controller, default: "ActionController::API"

      define_option :resources_controllers, default: -> {[
        Tfc::Mdm::Api::Achievements::AchievementsController,
        Tfc::Mdm::Api::Achievements::CategoriesController,
        Tfc::Mdm::Api::Addresses::AddressesController,
        Tfc::Mdm::Api::Addresses::RolesController,
        Tfc::Mdm::Api::Positions::EntriesController,
        Tfc::Mdm::Api::Positions::ExitsController,
        Tfc::Mdm::Api::Positions::PositionsController,
        Tfc::Mdm::Api::BranchesController,
        Tfc::Mdm::Api::ClubsController,
        Tfc::Mdm::Api::EstablishmentsController,
        Tfc::Mdm::Api::MembershipAgreementsController,
        Tfc::Mdm::Api::MembershipCancellationsController,
        Tfc::Mdm::Api::PeopleController,
      ]}

      define_option :resource_controllers, default: -> {[]}
      
      define_option :service_controllers, default: -> {[
        Tfc::Mdm::Api::CreateClubFromEstablishmentServiceController,
        Tfc::Mdm::Api::CreatePersonFromMembershipAgreementServiceController,
        Tfc::Mdm::Api::NotifyAboutNewMembershipAgreementServiceController,
      ]}
      
      define_option :sidebar_controllers, default: -> {[]}
      end
    end
  end
end
