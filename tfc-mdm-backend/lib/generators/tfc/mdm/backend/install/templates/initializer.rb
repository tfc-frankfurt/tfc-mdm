Tfc::Mdm::Backend.configure do |config|  
  # Set the resources, that will be shown in the backend menu.
  # 
  # Default: config.registered_controllers = -> {[
  #            Tfc::Mdm::Backend::BranchesController,
  #            Tfc::Mdm::Backend::ClubsController,
  #            Tfc::Mdm::Backend::EstablishmentsController,
  #            Tfc::Mdm::Backend::MembershipAgreementsController,
  #            Tfc::Mdm::Backend::MembershipCancellationsController,
  #            Tfc::Mdm::Backend::PeopleController
  #            Tfc::Mdm::Backend::CreateClubFromEstablishmentServiceController,
  #            Tfc::Mdm::Backend::CreatePersonFromMembershipAgreementServiceController,
  #            Tfc::Mdm::Backend::NotifyAboutNewMembershipAgreementServiceController,
  #            Tfc::Mdm::Backend::Addresses::AddressesController,
  #            Tfc::Mdm::Backend::Addresses::RolesController,
  #            Tfc::Mdm::Backend::Memberships::CategoriesController,
  #            Tfc::Mdm::Backend::Memberships::EventsController,
  #            Tfc::Mdm::Backend::Memberships::EventTypesController,
  #            Tfc::Mdm::Backend::Memberships::FeesController,
  #            Tfc::Mdm::Backend::Memberships::MembershipsController
  #          ]}
  #
  config.registered_controllers = -> {[
    Tfc::Mdm::Backend::BranchesController,
    Tfc::Mdm::Backend::ClubsController,
    Tfc::Mdm::Backend::EstablishmentsController,
    Tfc::Mdm::Backend::MembershipAgreementsController,
    Tfc::Mdm::Backend::MembershipCancellationsController,
    Tfc::Mdm::Backend::PeopleController,
    Tfc::Mdm::Backend::Addresses::AddressesController,
    Tfc::Mdm::Backend::Addresses::RolesController,
    Tfc::Mdm::Backend::Memberships::CategoriesController,
    Tfc::Mdm::Backend::Memberships::EventsController,
    Tfc::Mdm::Backend::Memberships::EventTypesController,
    Tfc::Mdm::Backend::Memberships::FeesController,
    Tfc::Mdm::Backend::Memberships::MembershipsController
  ]}

  # Set the services, that will be shown in the backend menu.
  # 
  # Default: config.registered_services = -> {[
  #            Tfc::Mdm::Backend::CreateClubFromEstablishmentServiceController,
  #            Tfc::Mdm::Backend::CreatePersonFromMembershipAgreementServiceController,
  #            Tfc::Mdm::Backend::NotifyAboutNewMembershipAgreementServiceController,
  #            Tfc::Mdm::Backend::Memberships::ImportFromMembershipAgreementServicesController
  #          ]}
  # 
  config.registered_services = -> {[
    Tfc::Mdm::Backend::CreateClubFromEstablishmentServiceController,
    Tfc::Mdm::Backend::CreatePersonFromMembershipAgreementServiceController,
    Tfc::Mdm::Backend::NotifyAboutNewMembershipAgreementServiceController,
    Tfc::Mdm::Backend::Memberships::ImportFromMembershipAgreementServicesController
  ]}
end