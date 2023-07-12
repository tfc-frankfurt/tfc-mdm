# frozen_string_literal: true

module Tfc
  module Mdm
    class MembershipCancellation < ActiveRecord::Base
      belongs_to :club
      belongs_to :person
      belongs_to :membership_agreement

      before_validation :set_person
      before_validation :set_club

      def to_event
        MembershipCancellationSigned.new(membership_cancellation: self, happened_at: entry_at, color: "#f8d7da")
      end

      private

        def set_club
          self.club = membership_agreement.try(:club)
        end

        def set_person
          self.person = membership_agreement.try(:person)
        end
    end
  end
end
