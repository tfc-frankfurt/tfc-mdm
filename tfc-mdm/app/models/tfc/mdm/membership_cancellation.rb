# frozen_string_literal: true

module Tfc
  module Mdm
    class MembershipCancellation < ActiveRecord::Base
      belongs_to :club
      belongs_to :person
      belongs_to :membership_agreement, inverse_of: :membership_cancellation

      before_validation :set_person
      before_validation :set_club

      scope :happened_in_year, ->(year) { happened_after(year.beginning_of_year).happened_before(year.end_of_year) }
      scope :happened_before, ->(point_in_time) { where("tfc_mdm_membership_cancellations.entry_at < ?", point_in_time) }
      scope :happened_after, ->(point_in_time) { where("tfc_mdm_membership_cancellations.entry_at > ?", point_in_time) }

      validates :entry_at, presence: true

      def to_event
        MembershipCancellationSigned.new(membership_cancellation: self, happened_at: entry_at, color: "#f8d7da")
      end

      def human
        [club.human, person.human, entry_at].join(" ")
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
