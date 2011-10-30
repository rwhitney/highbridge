class RemoveOldPasswordFromMembers < ActiveRecord::Migration
  def up
    remove_column :members, :password
  end

  def down
    add_column :members, :password, :string
  end
end
