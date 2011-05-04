class CreateThoughts < ActiveRecord::Migration
  def self.up
    create_table :thoughts do |t|
      t.string :name
      t.string :guid

      t.timestamps
    end
    change_column :thoughts, :id, :string
  end

  def self.down
    drop_table :thoughts
  end
end
