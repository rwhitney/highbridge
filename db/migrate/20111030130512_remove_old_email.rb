class RemoveOldEmail < ActiveRecord::Migration
  def up
    remove_column :members, :oldemail
  end

  def down
    add_column :members, :oldemail, :string
  end
end
