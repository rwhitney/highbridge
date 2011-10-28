class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :fullname
      t.string :portablename
      t.integer :portablenumber
      t.string :email
      t.string :privilege
      t.string :streetaddress
      t.string :city
      t.string :zip
      t.string :area
      t.string :homephone
      t.string :workphone
      t.string :cellorotherphone
      t.string :shirtsize
      t.string :status
      t.string :miscnotes
      t.string :password
      t.string :salt

      t.timestamps
    end
  end
end
