# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Translations", type: :model do
  {
    Tfc::Mdm::Achievements::Achievement => { locales: [:de] },
    Tfc::Mdm::Achievements::Category    => { locales: [:de] },
    Tfc::Mdm::Addresses::Address        => { locales: [:de] },
    Tfc::Mdm::Addresses::Role           => { locales: [:de] },
    Tfc::Mdm::Positions::Entry          => { locales: [:de] },
    Tfc::Mdm::Positions::Exit           => { locales: [:de] },
    Tfc::Mdm::Positions::Position       => { locales: [:de] },
    Tfc::Mdm::Branch                    => { locales: [:de] },
    Tfc::Mdm::Club                      => { locales: [:de] },
    Tfc::Mdm::Establishment             => { locales: [:de] },
    Tfc::Mdm::MembershipAgreement       => { locales: [:de] },
    Tfc::Mdm::MembershipCancellation    => { locales: [:de] },
    Tfc::Mdm::Person                    => { locales: [:de] },
  }.each do |model, options|
    options[:locales] ||= I18n.available_locales
    options[:locales].each do |locale|
      I18n.locale = locale

      describe "for locale #{locale}:" do
        describe "#{model} translations" do
          it "include one" do
            I18n.locale = locale
            i18n_key = ["activerecord", "models", model.name.underscore].join(".")
            i18n_options = {}
            expect(I18n.translate!(i18n_key, **options)[:one]).to be_a(String)
          end

          it "include other" do
            I18n.locale = locale
            i18n_key = ["activerecord", "models", model.name.underscore].join(".")
            i18n_options = {}
            expect(I18n.translate!(i18n_key, **options)[:other]).to be_a(String)
          end

          describe "for attributes" do
            model.column_names.each do |column_name|
              it "include #{column_name}" do
                I18n.locale = locale
                i18n_key = ["activerecord", "attributes", model.name.underscore, column_name].join(".")
                expect(I18n.translate!(i18n_key)).to be_a(String)
              end
            end
          end
        end
      end
    end
  end
end
