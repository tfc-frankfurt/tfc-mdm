class AddUserReferenceToTfcMdmPeople < ActiveRecord::Migration[7.0]
  def change
    add_reference :tfc_mdm_people, :user, foreign_key: { to_table: Tfc::Mdm::Configuration.user_class_name.constantize.table_name }
  end
end
