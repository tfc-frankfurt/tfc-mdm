# frozen_string_literal: true

class CreateTfcMdmAddressesLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :tfc_mdm_addresses_locations do |t|
      t.references :club
      t.string :line1
      t.string :line2
      t.string :street
      t.string :city
      t.string :zipcode
      t.string :country
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
