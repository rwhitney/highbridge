class RenameEmailInMember < ActiveRecord::Migration
  def change
    rename_column :members, :email, :oldemail
  end
end
