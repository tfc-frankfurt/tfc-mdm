# frozen_string_literal: true

module Tfc::Mdm
  class ClubEstablished < Timeline::Event
    attr_accessor :club

    def title
      I18n.t("classes.#{self.class.name.underscore}")
    end

    def description
      club.name
    end
  end
end
