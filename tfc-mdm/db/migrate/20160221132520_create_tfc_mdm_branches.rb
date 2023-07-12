# frozen_string_literal: true

class CreateTfcMdmBranches < ActiveRecord::Migration[6.0]
  def change
    create_table :tfc_mdm_branches do |t|
      t.references :club
      t.string :identifier
      t.date :valid_from
      t.date :valid_to

      t.timestamps null: false
    end
  end
end
