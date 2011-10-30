class RemovePrivilegeFromMember < ActiveRecord::Migration
  def up
    remove_column :members, :privilege
  end

  def down
    add_column :members, :privilege, :string
  end
end
