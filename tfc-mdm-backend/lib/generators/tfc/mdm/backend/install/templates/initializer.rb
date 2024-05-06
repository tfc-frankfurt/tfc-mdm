Tfc::Mdm::Backend.configure do |config|
  # Register self to be shown in the backend.
  #
  # Default: config.register_engine("Bgit::Accounting::Engine", {})
  #
  config.cmor.administrador.register_engine("Tfc::Mdm::Backend::Engine", {})

  # Set the resources, that will be shown in the backend menu.
  # 
  # Default: config.registered_controllers = -> {[
  #            Tfc::Mdm::Backend::EstablishmentsController,
  #            Tfc::Mdm::Backend::MembershipAgreementsController,
  #            Tfc::Mdm::Backend::MembershipCancellationsController,
  #            Tfc::Mdm::Backend::NumberRangesController,
  #            Tfc::Mdm::Backend::PeopleController
  #            Tfc::Mdm::Backend::Addresses::AddressesController,
  #            Tfc::Mdm::Backend::Addresses::RolesController,
  #            Tfc::Mdm::Backend::Memberships::CategoriesController,
  #            Tfc::Mdm::Backend::Memberships::EventsController,
  #            Tfc::Mdm::Backend::Memberships::EventTypesController,
  #            Tfc::Mdm::Backend::Memberships::FeesController,
  #            Tfc::Mdm::Backend::Memberships::MembershipsController,
  #            Tfc::Mdm::Backend::Clubs::BankDetailsController,
  #            Tfc::Mdm::Backend::Clubs::BranchesController,
  #            Tfc::Mdm::Backend::Clubs::ClubsController,
  #            Tfc::Mdm::Backend::Clubs::EmailAddressesController,
  #            Tfc::Mdm::Backend::Clubs::PhoneNumbersController,
  #            Tfc::Mdm::Backend::Clubs::SocialMediaController
  #          ]}
  #
  config.registered_controllers = -> {[
    Tfc::Mdm::Backend::EstablishmentsController,
    Tfc::Mdm::Backend::MembershipAgreementsController,
    Tfc::Mdm::Backend::MembershipCancellationsController,
    Tfc::Mdm::Backend::NumberRangesController,
    Tfc::Mdm::Backend::PeopleController,
    Tfc::Mdm::Backend::Addresses::AddressesController,
    Tfc::Mdm::Backend::Addresses::RolesController,
    Tfc::Mdm::Backend::Memberships::CategoriesController,
    Tfc::Mdm::Backend::Memberships::EventsController,
    Tfc::Mdm::Backend::Memberships::EventTypesController,
    Tfc::Mdm::Backend::Memberships::FeesController,
    Tfc::Mdm::Backend::Memberships::MembershipsController,
    Tfc::Mdm::Backend::Clubs::BankDetailsController,
    Tfc::Mdm::Backend::Clubs::BranchesController,
    Tfc::Mdm::Backend::Clubs::ClubsController,
    Tfc::Mdm::Backend::Clubs::EmailAddressesController,
    Tfc::Mdm::Backend::Clubs::PhoneNumbersController,
    Tfc::Mdm::Backend::Clubs::SocialMediaController
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