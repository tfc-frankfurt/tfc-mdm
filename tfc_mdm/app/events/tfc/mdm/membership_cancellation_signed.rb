# frozen_string_literal: true

module Tfc::Mdm
  class MembershipCancellationSigned < Timeline::Event
    attr_accessor :membership_cancellation

    def title
      I18n.t("classes.#{self.class.name.underscore}")
    end

    def description
      person.fullname
    end

    private

      def person
        membership_cancellation.person
      end
  end
end
