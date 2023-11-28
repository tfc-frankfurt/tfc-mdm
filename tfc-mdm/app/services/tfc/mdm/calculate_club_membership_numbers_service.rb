module Tfc
  module Mdm
    class CalculateClubMembershipNumbersService < Rao::Service::Base
      class Result < Rao::Service::Result::Base
        attr_accessor :membership_numbers, :years

        def membership_numbers_for_year(year)
          membership_numbers.find { |mn| mn.year == year }
        end
      end

      attr_accessor :club

      validates :club, presence: true

      private

      def _perform
        # get all years since establishment
        @result.years = years

        @result.membership_numbers = years.collect do |year|
          calculate_membership_numbers_for_year(year)
        end
      end

      def year_as_time(year)
        Time.zone.local(year)
      end


      def years
        @years ||= (club.established_at.year..Time.zone.now.year).to_a.map { |y| year_as_time(y) }
      end

      def calculate_membership_numbers_for_year(year)
        Tfc::Mdm::ClubMembershipNumbers.new(
          year: year,
          membership_agreements: membership_agreements_for_year(year),
          membership_cancellations: membership_cancellations_for_year(year),
          active_members_at_start_of_year: active_members_at_start_of_year(year),
          active_members_at_end_of_year: active_members_at_end_of_year(year),
          membership_development: active_members_at_end_of_year(year) - active_members_at_start_of_year(year)
        )
      end

      def membership_agreements_for_year(year)
        club.membership_agreements.happened_in_year(year)
      end

      def membership_cancellations_for_year(year)
        club.membership_cancellations.happened_in_year(year)
      end

      def active_members_at_start_of_year(year)
        club.membership_agreements.happened_before(year.beginning_of_year).not_cancelled
      end

      def active_members_at_end_of_year(year)
        club.membership_agreements.happened_before(year.end_of_year).not_cancelled
      end
    end
  end
end
