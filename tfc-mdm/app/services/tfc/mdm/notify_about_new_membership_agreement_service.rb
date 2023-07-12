# frozen_string_literal: true

module Tfc::Mdm
  class NotifyAboutNewMembershipAgreementService < Rao::Service::Base
    class Result < Rao::Service::Result::Base
    end

    attr_accessor :membership_agreement_id, :chairman_fullname, :recipients

    validates :membership_agreement_id, presence: true

    def recipients
      @recipients ||= "vorstand@tfc-frankfurt.de"
    end

    def chairman_fullname
      @chairman_fullname ||= "Roberto"
    end

    private

    def _perform
      say "Delivering email" do
        if Tfc::Mdm::NotificationMailer.new_membership_agreement_email(membership_agreement, chairman_fullname, recipients.split(" ")).deliver_later
          say "Delivered notification about the new membership agreement #{membership_agreement} to: #{recipients}"
        else
          say "Failed delivering notification about the new membership agreement #{membership_agreement} to: #{recipients}"
        end
      end
    end

    def membership_agreement
      @membership_agreement ||= Tfc::Mdm::MembershipAgreement.find(membership_agreement_id)
    end
  end
end
