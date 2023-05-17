# frozen_string_literal: true

FactoryBot.define do
  factory :tfc_mdm_membership_cancellation, class: Tfc::Mdm::MembershipCancellation do
    association :membership_agreement, factory: :tfc_mdm_membership_agreement
    association :club, factory: :tfc_mdm_club
    association :person, factory: :tfc_mdm_person
  end
end
