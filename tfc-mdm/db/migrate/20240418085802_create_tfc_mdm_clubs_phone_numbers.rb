class CreateTfcMdmClubsPhoneNumbers < ActiveRecord::Migration[7.0]
  def change
    create_table :tfc_mdm_clubs_phone_numbers do |t|
      t.string :uuid
      t.references :club, null: false, foreign_key: { to_table: :tfc_mdm_clubs }
      t.string :role
      t.string :number

      t.timestamps
    end
  end
end
