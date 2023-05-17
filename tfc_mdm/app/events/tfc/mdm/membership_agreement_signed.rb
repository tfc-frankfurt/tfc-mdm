# frozen_string_literal: true

module Tfc::Mdm
  class MembershipAgreementSigned < Timeline::Event
    attr_accessor :membership_agreement

    def title
      I18n.t("classes.#{self.class.name.underscore}")
    end

    def description
      person.fullname
    end

    private

      def person
        membership_agreement.person
      end
  end
end
