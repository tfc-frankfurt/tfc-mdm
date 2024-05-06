class CreateTfcMdmClubsBankDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :tfc_mdm_clubs_bank_details do |t|
      t.string :uuid
      t.references :club, null: false, foreign_key: { to_table: :tfc_mdm_clubs }
      t.string :role
      t.string :account_holder
      t.string :bank_name
      t.string :iban
      t.string :bic
      t.text :note

      t.timestamps
    end
  end
end
