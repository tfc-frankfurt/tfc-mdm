FactoryBot.define do
  factory :tfc_mdm_number_range, class: "Tfc::Mdm::NumberRange" do
    sequence(:identifier) { |i| "number_range_#{i}" }
    sequence(:prefix) { |i| (i + 64).chr * 2 }
    format { "%Y%m-" }
    next_value { 1 }
    minimum_length { 4 }
  end
end
