module Tfc
  module Mdm
    module Memberships
      class BillingRunService::Membership
        include ActiveModel::Model
        include ActiveModel::Attributes
  
        attribute :membership
        attribute :selected, :boolean, default: false
        validates :membership, presence: true
        validates :selected, inclusion: {in: [true, false]}

        delegate *Tfc::Mdm::Memberships::Membership.attribute_names, to: :membership
        delegate :human, :full_months_active_in_year, :total_fee_for_year, :total_fee_for_year_cents, :person, :category, :events, to: :membership
      end
    end
  end
end
