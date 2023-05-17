# frozen_string_literal: true

class CreateTfcMdmAddressesAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :tfc_mdm_addresses_addresses do |t|
      t.references :club
      t.references :record, polymorphic: true
      t.references :role
      t.string :line1
      t.string :line2
      t.string :street
      t.string :city
      t.string :zipcode
      t.string :country
      t.float :latitude
      t.float :longitude
      t.timestamp :valid_from
      t.timestamp :valid_to

      t.timestamps
    end
  end
end
