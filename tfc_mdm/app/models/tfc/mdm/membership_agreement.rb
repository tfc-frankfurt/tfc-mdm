# frozen_string_literal: true

module Tfc
  module Mdm
    class MembershipAgreement < ActiveRecord::Base
      belongs_to :club
      belongs_to :person, optional: true
      has_one :membership_cancellation

      delegate :name, to: :club, prefix: true, allow_nil: true

      validates :salutation, :firstname, :lastname, :street, :zipcode, :city, :country, :birthdate, :phone, :email, :entry_at, presence: true

      def to_event
        MembershipAgreementSigned.new(membership_agreement: self, happened_at: entry_at, color: "#d4edda")
      end

      def fullname
        "#{salutation} #{firstname} #{lastname}"
      end

      def human
        "[#{self.class.model_name.human}] #{club.human} - #{fullname}"
      end
    end
  end
end
