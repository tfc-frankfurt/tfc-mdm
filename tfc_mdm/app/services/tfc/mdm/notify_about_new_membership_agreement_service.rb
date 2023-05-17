# frozen_string_literal: true

module Tfc::Mdm
  class NotifyAboutNewMembershipAgreementService < Rao::Service::Base
    class Result < Rao::Service::Result::Base
    end

    attr_accessor :membership_agreement_id, :chairman_fullname, :recipients

    private

      def _perform
        if Tfc::Mdm::NotificationMailer.new_membership_agreement_email(membership_agreement, chairman_fullname, recipients.split(" ")).deliver
          info "Delivered notification about the new membership agreement #{membership_agreement} to: #{recipients}", indent: 1
        else
          info "Failed delivering notification about the new membership agreement #{membership_agreement} to: #{recipients}", indent: 1
        end
        say "Done"
        response
      end

      def membership_agreement
        @membership_agreement ||= Tfc::Mdm::MembershipAgreement.find(membership_agreement_id)
      end

      def recipients
        @recipients ||= "vorstand@tfc-frankfurt.de"
      end

      def chairman_fullname
        @chairman_fullname ||= "Roberto"
      end
  end
end
