class CreateLinks < ActiveRecord::Migration
  def self.up
    create_table :links do |t|
      t.string :idA
      t.string :idB
      t.integer :dir

      t.timestamps
    end
    change_column :links, :id, :string
  end

  def self.down
    drop_table :links
  end
end
