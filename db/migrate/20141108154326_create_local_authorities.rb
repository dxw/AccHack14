class CreateLocalAuthorities < ActiveRecord::Migration
  def change
    create_table :local_authorities do |t|
      t.string :la_code
      t.string :name
    end
  end
end
