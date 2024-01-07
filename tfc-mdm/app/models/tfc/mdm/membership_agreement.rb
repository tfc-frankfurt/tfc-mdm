# frozen_string_literal: true

module Tfc
  module Mdm
    class MembershipAgreement < ActiveRecord::Base
      belongs_to :club
      belongs_to :person, optional: true
      has_one :membership_cancellation, inverse_of: :membership_agreement

      delegate :name, to: :club, prefix: true, allow_nil: true

      validates :salutation, :firstname, :lastname, :street, :zipcode, :city, :country, :birthdate, :phone, :email, :entry_at, presence: true

      scope :happened_in_year, ->(year) { happened_after(year.beginning_of_year).happened_before(year.end_of_year) }
      scope :happened_before, ->(point_in_time) { where("tfc_mdm_membership_agreements.entry_at < ?", point_in_time) }
      scope :happened_after, ->(point_in_time) { where("tfc_mdm_membership_agreements.entry_at > ?", point_in_time) }

      scope :not_cancelled, -> { where.missing(:membership_cancellation) }

      def to_event
        MembershipAgreementSigned.new(membership_agreement: self, happened_at: entry_at, color: "#d4edda")
      end

      def fullname
        "#{salutation} #{firstname} #{lastname}"
      end

      def address
        [street, "#{zipcode} #{city}", country].join(", ")
      end

      def human
        [club&.human, person&.human, entry_at].compact.join(" - ")
      end
    end
  end
end
