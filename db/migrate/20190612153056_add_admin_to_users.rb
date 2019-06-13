class AddAdminToUsers < ActiveRecord::Migration[5.2]
  def up
    add_column :users, :admin, :boolean, default: false, null: false
  end
  def down
    remove_colume :users, :admin
  end
end
