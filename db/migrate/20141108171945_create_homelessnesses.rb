class CreateHomelessnesses < ActiveRecord::Migration
  def change
    create_table :homelessnesses do |t|
      t.integer :local_authority
      t.integer :type_1
      t.integer :type_2
      t.integer :type_3
      t.integer :type_4
      t.integer :type_5
      t.integer :total

      t.timestamps
    end
  end
end
