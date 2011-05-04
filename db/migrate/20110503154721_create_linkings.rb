class CreateLinkings < ActiveRecord::Migration
  def self.up
    create_table :linkings do |t|
      t.string :link_id
      t.string :thought_id
    end
  end

  def self.down
    drop_table :linkings
  end
end
