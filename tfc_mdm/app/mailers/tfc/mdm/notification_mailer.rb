# frozen_string_literal: true

module Tfc::Mdm
  class NotificationMailer < ApplicationMailer
    def new_membership_agreement_email(membership_agreement, chairman_fullname, recipient_user_email_addresses)
      @chairman_fullname = chairman_fullname
      @membership_agreement = membership_agreement
      # raise default_i18n_subject(club_name: @membership_agreement.club_name, membership_agreement_entry_at: membership_agreement.entry_at, member_fullname: membership_agreement.fullname)
      mail(to: recipient_user_email_addresses, subject: default_i18n_subject(club_name: @membership_agreement.club_name, membership_agreement_entry_at: I18n.l(membership_agreement.entry_at), member_fullname: membership_agreement.fullname))
    end
  end
end
