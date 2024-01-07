module Tfc
  module Mdm
    module Memberships
      class ImportFromMembershipAgreementService < Rao::Service::Base
        class Result < Rao::Service::Result::Base
          attr_accessor :membership, :agreement_event, :termination_event, :user
        end

        attr_accessor :membership_agreement, :membership_agreement_id

        validates :membership_agreement, presence: true
        validates :category, presence: true

        private

        def _perform
          @result.membership = build_membership
          if @result.membership.invalid?
            add_error_and_say :membership, "Could not build membership. Errors: #{@result.membership.errors.full_messages.to_sentence}"
            return
          end

          @result.agreement_event = build_agreement_event
          if @result.agreement_event.invalid?
            add_error_and_say :agreement_event, "Could not build agreement event. Errors: #{@result.agreement_event.errors.full_messages.to_sentence}"
            return
          end

          unless @membership_agreement.person.user.present?
            @result.user = build_user
            if @result.user.invalid?
              add_error_and_say :user, "Could not build user. Errors: #{user.errors.full_messages.to_sentence}"
              return
            end
          end

          if membership_agreement.membership_cancellation.present?
            @result.termination_event = build_termination_event
            if @result.termination_event.invalid?
              add_error_and_say :termination_event, "Could not build termination event. Errors: #{@result.termination_event.errors.full_messages.to_sentence}"
              return
            end
          else
            say "No membership cancellation found. Skipping termination event."
          end
        end

        def save
          ActiveRecord::Base.transaction do
            @result.membership.save!
            @result.agreement_event.save!
            @result.termination_event&.save!
            @result.user&.save!
          rescue => e
            add_error_and_say :membership, "Rolling changes back. Errors: #{e.message}"
            raise e
          end
        end

        def membership_agreement
          @membership_agreement ||= Tfc::Mdm::MembershipAgreement.find(@membership_agreement_id)
        end

        def build_user
          say "Building user for #{membership_agreement.person.human} in #{membership_agreement.club.name}." do
            Tfc::Mdm::Configuration.user_class_name.constantize.new.tap do |u|
              u.email = membership_agreement.email
              u.password = SecureRandom.hex(16)
              u.password_confirmation = u.password
              u.active = true
              u.confirmed = true
              u.approved = true
            end
          end
        end

        def build_membership
          say "Building membership for #{membership_agreement.person.human} in #{membership_agreement.club.name}." do
            Memberships::Membership.new.tap do |m|
              m.club = membership_agreement.club
              m.person = membership_agreement.person
              m.category = category
              m.active_from = membership_agreement.entry_at
              m.active_to = membership_agreement&.membership_cancellation&.entry_at || Time.new(9999, 12, 31, 23, 59, 59)
            end
          end
        end

        def build_agreement_event
          say "Building agreement event for #{membership_agreement.person.human} in #{membership_agreement.club.name} at #{membership_agreement.entry_at}." do
            Memberships::Event.new.tap do |e|
              e.event_type = agreement_event
              e.membership = @result.membership
              e.happened_at = membership_agreement.entry_at
            end
          end
        end

        def build_termination_event
          say "Building termination event for #{membership_agreement.person.human} in #{membership_agreement.club.name} at #{membership_agreement.membership_cancellation.entry_at}." do
            Memberships::Event.new.tap do |e|
              e.event_type = termination_event
              e.membership = @result.membership
              e.happened_at = membership_agreement.membership_cancellation.entry_at
            end
          end
        end

        def agreement_event
          @agreement_event ||= Tfc::Mdm::Memberships::EventType.where(identifier: "agreement").first_or_initialize
        end

        def termination_event
          @termination_event ||= Tfc::Mdm::Memberships::EventType.where(identifier: "termination").first_or_initialize
        end

        def category
          @category ||= membership_agreement.club.memberships_categories.find_by(identifier: "active")
        end
      end
    end
  end
end
