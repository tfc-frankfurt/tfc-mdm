class CreateTfcMdmAchievementsAchievements < ActiveRecord::Migration[6.0]
  def change
    create_table :tfc_mdm_achievements_achievements do |t|
      t.references :club
      t.references :category
      t.references :achiever, polymorphic: true, index: { name: 'index_tfc_mdm_achievements_achievements_on_a_type_and_aid' }
      t.string :title
      t.text :body
      t.date :happened_at
      t.timestamp :published_at
      t.integer :position

      t.timestamps
    end
  end
end
