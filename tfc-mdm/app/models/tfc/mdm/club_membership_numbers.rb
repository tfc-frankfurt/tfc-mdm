module Tfc
  module Mdm
    class ClubMembershipNumbers < Rao::ActiveCollection::Base
      attr_accessor :year
      attr_accessor :membership_agreements
      attr_accessor :membership_cancellations
      attr_accessor :active_members_at_start_of_year
      attr_accessor :active_members_at_end_of_year
      attr_accessor :membership_development
    end
  end
end
