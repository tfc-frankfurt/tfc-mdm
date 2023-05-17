# frozen_string_literal: true

class CreateTfcMdmAddressesRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :tfc_mdm_addresses_roles do |t|
      t.references :club
      t.string :identifier

      t.timestamps
    end
  end
end
