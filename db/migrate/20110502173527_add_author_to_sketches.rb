class AddAuthorToSketches < ActiveRecord::Migration
  def self.up
    add_column :sketches, :author, :string
    add_index :sketches, :author
  end

  def self.down
    remove_column :sketches, :author
  end
end
