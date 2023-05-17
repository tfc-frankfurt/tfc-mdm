Tfc::Mdm::Api.configure do |config|
  # Set the base controller for the page controller
  #
  # Default: config.base_controller = '<%= base_controller_class_name %>'
  #
  config.base_controller = '<%= base_controller_class_name %>'

  config.resources_controllers = ->{[
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
  
  config.resource_controllers = ->{[]}
  
  config.service_controllers = ->{[
    Tfc::Mdm::Api::CreateClubFromEstablishmentServiceController,
    Tfc::Mdm::Api::CreatePersonFromMembershipAgreementServiceController,
    Tfc::Mdm::Api::NotifyAboutNewMembershipAgreementServiceController,
  ]}
  
  config.sidebar_controllers = ->{[]}
end
