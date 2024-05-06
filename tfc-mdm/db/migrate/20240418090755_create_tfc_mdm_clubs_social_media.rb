class CreateTfcMdmClubsSocialMedia < ActiveRecord::Migration[7.0]
  def change
    create_table :tfc_mdm_clubs_social_media do |t|
      t.string :uuid
      t.references :club, null: false, foreign_key: { to_table: :tfc_mdm_clubs }
      t.string :platform
      t.string :url
      t.string :handle

      t.timestamps
    end
  end
end
