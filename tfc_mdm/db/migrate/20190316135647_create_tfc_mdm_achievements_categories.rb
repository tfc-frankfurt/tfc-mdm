class CreateTfcMdmAchievementsCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :tfc_mdm_achievements_categories do |t|
      t.references :club
      t.string :name_de
      t.string :name_en

      t.timestamps
    end
  end
end
