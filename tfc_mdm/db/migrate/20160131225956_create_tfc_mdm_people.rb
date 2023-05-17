# frozen_string_literal: true

class CreateTfcMdmPeople < ActiveRecord::Migration[6.0]
  def change
    create_table :tfc_mdm_people do |t|
      t.references :club
      t.string :salutation
      t.string :firstname
      t.string :lastname
      t.date   :birthdate

      t.timestamps null: false
    end
  end
end
