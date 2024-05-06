class CreateTfcMdmClubsEmailAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :tfc_mdm_clubs_email_addresses do |t|
      t.string :uuid
      t.references :club, null: false, foreign_key: { to_table: :tfc_mdm_clubs }
      t.string :role
      t.string :email

      t.timestamps
    end
  end
end
