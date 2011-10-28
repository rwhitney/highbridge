class CreateShifts < ActiveRecord::Migration
  def change
    create_table :shifts do |t|
      t.date :shiftdate
      t.integer :shiftnum
      t.integer :e1member_id
      t.integer :e2member_id
      t.integer :dmember_id

      t.timestamps
    end
  end
end
