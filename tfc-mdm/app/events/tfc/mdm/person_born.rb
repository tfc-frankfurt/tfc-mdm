# frozen_string_literal: true

module Tfc::Mdm
  class PersonBorn < Timeline::Event
    attr_accessor :person

    def title
      I18n.t("classes.#{self.class.name.underscore}")
    end

    def description
      person.fullname
    end
  end
end
