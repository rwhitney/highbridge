class ChangeIndexesOnMember < ActiveRecord::Migration
  def up
    remove_index :members, :email
    add_index :members, :portable_name, :unique => true
  end

  def down
    remove_index :members, :portable_name
    add_index :members, :email, :unique => true
  end
end
