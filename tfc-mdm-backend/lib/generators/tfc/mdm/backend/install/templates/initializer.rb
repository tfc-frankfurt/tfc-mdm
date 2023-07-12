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
  #            Tfc::Mdm::Backend::Addresses::RolesController
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
    Tfc::Mdm::Backend::Addresses::RolesController
  ]}

  # Set the services, that will be shown in the backend menu.
  # 
  # Default: config.registered_services = -> {[
  #            Tfc::Mdm::Backend::CreateClubFromEstablishmentServiceController,
  #            Tfc::Mdm::Backend::CreatePersonFromMembershipAgreementServiceController,
  #            Tfc::Mdm::Backend::NotifyAboutNewMembershipAgreementServiceController
  #          ]}
  # 
  config.registered_services = -> {[
    Tfc::Mdm::Backend::CreateClubFromEstablishmentServiceController,
    Tfc::Mdm::Backend::CreatePersonFromMembershipAgreementServiceController,
    Tfc::Mdm::Backend::NotifyAboutNewMembershipAgreementServiceController
  ]}
end