# frozen_string_literal: true

class CreateTfcMdmEstablishments < ActiveRecord::Migration[6.0]
  def change
    create_table :tfc_mdm_establishments do |t|
      t.references :club
      t.string :name
      t.date :happened_at
      t.string :line1
      t.string :line2
      t.string :street
      t.string :zipcode
      t.string :city
      t.string :country

      t.timestamps null: false
    end
  end
end
