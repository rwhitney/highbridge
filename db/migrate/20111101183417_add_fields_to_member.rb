class AddFieldsToMember < ActiveRecord::Migration
  def change
    add_column :members, :first_name, :string
    add_column :members, :last_name, :string
    add_column :members, :training_level, :string
    rename_column :members, :fullname, :full_name
    rename_column :members, :portablename, :portable_name
    rename_column :members, :portablenumber, :portable_number
    rename_column :members, :streetaddress, :street_address
    rename_column :members, :homephone, :home_phone
    rename_column :members, :workphone, :work_phone
    rename_column :members, :cellorotherphone, :cell_or_other_phone
    rename_column :members, :shirtsize, :shirt_size
    rename_column :members, :miscnotes, :misc_notes
  end
end
