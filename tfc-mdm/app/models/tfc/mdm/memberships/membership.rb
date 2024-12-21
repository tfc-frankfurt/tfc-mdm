module Tfc::Mdm
  class Memberships::Membership < ApplicationRecord
    include SimpleFormPolymorphicAssociations::Model::AutocompleteConcern
    include Tfc::Mdm::Model::ActiveConcern
    include Tfc::Mdm::Model::ValueTranslationConcern

    belongs_to :club, class_name: "Tfc::Mdm::Clubs::Club"
    belongs_to :person
    belongs_to :category
    has_many :events, dependent: :destroy
    has_one :current_fee, -> { active }, class_name: "Tfc::Mdm::Memberships::Fee", through: :category, source: :fees
    has_many :billed_items, class_name: "Bgit::Invoicing::BilledItem", as: :billable, dependent: :restrict_with_error
    has_many :line_items, through: :billed_items, class_name: "Bgit::Invoicing::LineItem"
    has_many :invoices, through: :billed_items, class_name: "Bgit::Invoicing::Invoice", source: :line_item
    has_many :journals, class_name: "Keepr::Journal", as: :accountable, dependent: :restrict_with_error if Object.const_defined?("Keepr")
    has_many :postings, through: :journals, class_name: "Keepr::Posting", source: :keepr_postings if Object.const_defined?("Keepr")
    has_one :user, through: :person

    scope :started_in_year, ->(year) { started_after(year.beginning_of_year).started_before(year.end_of_year) }
    scope :started_before, ->(point_in_time) { where("active_from < ?", point_in_time) }
    scope :started_after, ->(point_in_time) { where("active_from > ?", point_in_time) }

    scope :ended_in_year, ->(year) { ended_after(year.beginning_of_year).ended_before(year.end_of_year) }
    scope :ended_before, ->(point_in_time) { where("active_to < ?", point_in_time) }
    scope :ended_after, ->(point_in_time) { where("active_to > ?", point_in_time) }

    autocomplete scope: ->(matcher) { joins(:person).where("lower(tfc_mdm_people.firstname) LIKE :term OR lower(tfc_mdm_people.lastname) LIKE :term", term: "%#{matcher.downcase}%") }, id_method: :id, text_method: :human

    delegate :email, to: :user, prefix: true

    after_touch do
      update_active_from_and_active_to_from_events!
    end

    register_currency Tfc::Mdm::Configuration.default_currency
    monetize :total_fee_for_year_cents

    def human
      [club.human, person.human, category.human].join(" - ")
    end

    def self.human_scope_name(scope)
      I18n.t(scope, scope: "activerecord.scopes.#{model_name.i18n_key}")
    end

    def update_active_from_and_active_to_from_events!
      self.update!(
        active_from: (events.agreements.order(happened_at: :asc).first&.effective_at || active_from),
        active_to: (events.terminations.order(happened_at: :asc).last&.effective_at || active_to)
      )
    end

    def membership_state
      events.order(happened_at: :desc).first&.event_type&.identifier
    end

    def days_active_in_year(year)
      return [] if active_from.nil? || active_to.nil?
      beginning = [active_from.to_date, Time.zone.local(year).beginning_of_year.to_date].max
      ending = [active_to.to_date, Time.zone.local(year).end_of_year.to_date].min
      (beginning..ending)
    end

    def full_months_active_in_year(year)
      grouped_days = days_active_in_year(year)&.to_a&.group_by(&:month)
      # remove all months that are not full months
      days_in_full_months = grouped_days&.select { |k, v| v.count == v.first.end_of_month.day }
      # return an array of dates that represent the first day of the full months
      days_in_full_months&.map { |k, v| v.first.beginning_of_month }
    end

#    def months_active_in_year(year)
#      days = days_active_in_year(year)
#
#      months = foo(year)
#
#      # calculate the number of full months the membership was active in the given year
#      first_of_months = days.select { |d| d.day == 1 }.count
#      last_of_months = days.select { |d| d.day == d.end_of_month.day }.count
#      [first_of_months, last_of_months].min
#    end

    def total_fee_for_year_cents(year = Time.zone.now.year)
      return 0 if category.nil?
      full_months_active_in_year(year)&.sum do |month|
        category.fees.active_at(month).first&.amount_cents || 0
      end
    end

    module MembershipNumberConcern
      extend ActiveSupport::Concern

      included do
        after_create :set_membership_number
      end

      def set_membership_number
        self.membership_number = Tfc::Mdm::NumberRanges::NextNumberService.call!(identifier: "membership_number").value
      end

      def set_membership_number!
        set_membership_number
        save!
      end
    end

    include MembershipNumberConcern
  end
end
