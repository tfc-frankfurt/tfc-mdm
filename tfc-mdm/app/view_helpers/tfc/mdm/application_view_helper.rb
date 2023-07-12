# frozen_string_literal: true

module Tfc
  module Mdm
    class ApplicationViewHelper < Rao::ViewHelper::Base
      def achievements(achievements = nil, options = {})
        if achievements.nil? && c.current_club.nil?
          return I18n.t("tfc.mdm.application_view_helper.achievements.warnings.branch_load_error")
        end

        (achievements || c.current_club.achievements.published).collect do |achievement|
          c.render partial: "tfc/mdm/application_view_helper/achievement", locals: { achievement: achievement }
        end.join("<hr />").html_safe
      end

      def branches(branches = nil, options = {})
        if branches.nil? && c.current_club.nil?
          return I18n.t("tfc.mdm.application_view_helper.branches.warnings.branch_load_error")
        end

        (branches || c.current_club.branches.valid.order(valid_to: :desc)).collect do |branch|
          c.render partial: "tfc/mdm/application_view_helper/branch", locals: { branch: branch }
        end.join("<hr />").html_safe
      end

      def club_logo_url(club = nil)
        club ||= c.current_club
        if club.try(:logo).present?
          c.main_app.url_for(club.logo)
        else
          "https://placeholder.pics/svg/300"
        end
      end

      def club_favicon_url(club = nil)
        club ||= c.current_club
        if club.try(:favicon).present?
          c.main_app.url_for(club.favicon)
        end
      end

      def club_name(club = nil)
        club ||= c.current_club
        if club.respond_to?(:name)
          club.name
        else
          "No club selected"
        end
      end
    end
  end
end
