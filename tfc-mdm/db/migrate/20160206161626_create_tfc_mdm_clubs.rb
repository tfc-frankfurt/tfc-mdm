# frozen_string_literal: true

class CreateTfcMdmClubs < ActiveRecord::Migration[6.0]
  def change
    create_table :tfc_mdm_clubs do |t|
      t.string :name
      t.references :establishment

      t.timestamps null: false
    end
  end
end
