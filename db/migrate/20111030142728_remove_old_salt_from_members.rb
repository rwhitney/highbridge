class RemoveOldSaltFromMembers < ActiveRecord::Migration
  def up
    remove_column :members, :salt
  end

  def down
    add_column :members, :salt, :string
  end
end
