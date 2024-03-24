module Tfc
  module Mdm
    module Memberships
      class BillingRunService < Rao::Service::Base
        include MoneyRails::ActiveRecord::Monetizable
        
        class Result < Rao::Service::Result::Base
          attr_accessor :invoices
        end

        attr_accessor :memberships, :year, :club, :club_id

        validates :memberships, presence: true
        validates :year, presence: true
        validates :club, presence: true

        def self.after_save; end # Make money-rails happy

        register_currency Tfc::Mdm::Configuration.default_currency
        monetize :total_membership_fee_cents, numericality: { greater_than_or_equal_to: 0 }

        def club
          @club ||= Tfc::Mdm::Club.find_by(id: club_id)
        end

        def memberships=(value)
          case value
          when Array
            @memberships = value.map { |m| Tfc::Mdm::Memberships::BillingRunService::Membership.new(membership: m) }
          when Hash
            @memberships = value.collect do |membership_id, attributes|
              next unless ActiveRecord::Type::Boolean.new.cast(attributes.delete(:selected))
              membership = Tfc::Mdm::Memberships::Membership.find(membership_id)
              Tfc::Mdm::Memberships::BillingRunService::Membership.new(attributes.merge(membership: membership))
            end.compact
          else
            @memberships = value
          end
        end

        def memberships
          @memberships ||= unbilled_memberships
        end

        def unbilled_memberships
          unbilled_memberships = Tfc::Mdm::Memberships::Membership
            .active_in(year_as_time.beginning_of_year..year_as_time.end_of_year)
            .includes(:person, category: [:current_fee, :fees], events: [:event_type])
            .order(active_from: :desc)
            .all.map { |m| Tfc::Mdm::Memberships::BillingRunService::Membership.new(membership: m) }

            unbilled_memberships.select do |m|
              invoices = m.invoices.for_year(year)
              return true if invoices.empty?

              # get shipping date ranges from all invoices
              shipping_date_ranges = invoices.map { |i| i.shipping_date..i.shipping_end_date }
              # check if the membership has any days outside of the shipping date ranges
              m.days_active_in_year(year).any? { |d| shipping_date_ranges.none? { |r| r.cover?(d) } }
            end
        end

        def year
          @year ||= Time.zone.now.year
        end
        
        def year_as_time
          Time.zone.local(year)
        end

        def total_membership_fee_cents
          @total_membership_fee_cents ||= memberships.sum { |m| m.total_fee_for_year_cents(year) }
        end

        private

        def _perform
          @result.invoices = build_invoices
          @result.invoices.each do |invoice|
            add_error_and_say(:memberships, "Invoice for #{invoice.owner.human} is invalid. Errors: #{invoice.errors.full_messages.to_sentence}") unless invoice.valid?
          end
        end

        def build_invoices
          memberships.collect do |membership|
            build_invoice_for_membership(membership).tap do |invoice|
              invoice.line_items << build_line_item(invoice, membership)
            end
          end
        end

        def save
          ActiveRecord::Base.transaction do
            @result.invoices.map(&:save!)
          end
        end
  
        def build_invoice_for_membership(membership)
          say "Building invoice for #{membership.human}" do
            Bgit::Invoicing::Invoice.new(
              owner: membership.membership,
              shipping_date: [membership.active_from, year_as_time.beginning_of_year].max,
              shipping_end_date: [membership.active_to, year_as_time.end_of_year].min
            )
          end
        end
  
        def build_line_item(invoice, membership)
          say "Building line item for invoice #{invoice.human} and membership #{membership.human}" do
            Bgit::Invoicing::LineItem.new.tap do |li|
              li.invoice = invoice
              li.name = membership.human
              li.description = membership.category.description
              li.unit_name = "Jahresmitgliedschaft"
              li.quantity = 1
              li.unit_net_amount = membership.total_fee_for_year(year)
              li.tax_rate_percentage = 0
              li.billed_items.build(billable: membership.membership)
              binding.pry if li.invalid?
            end
          end
        end
      end
    end
  end
end
