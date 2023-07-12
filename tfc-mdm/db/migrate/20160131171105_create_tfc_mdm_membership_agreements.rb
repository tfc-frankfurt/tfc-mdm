# frozen_string_literal: true

class CreateTfcMdmMembershipAgreements < ActiveRecord::Migration[6.0]
  def change
    create_table :tfc_mdm_membership_agreements do |t|
      t.references :club
      t.references :person
      t.string :salutation
      t.string :firstname
      t.string :lastname
      t.string :street
      t.string :zipcode
      t.string :city
      t.string :country
      t.date   :birthdate
      t.string :phone
      t.string :email
      t.date   :entry_at

      t.timestamps null: false
    end
  end
end
