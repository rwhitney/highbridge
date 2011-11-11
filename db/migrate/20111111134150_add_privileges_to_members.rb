class AddPrivilegesToMembers < ActiveRecord::Migration
  def change
    rename_column :members, :admin, :admin_calendar                 # admin over the calendar
    add_column :members, :admin_root, :boolean, :default => false   # admin over everything
    add_column :members, :admin_hr, :boolean, :default => false     # admin over people
    add_column :members, :visitor, :boolean, :default => false      # no write access to anything
  end
end
