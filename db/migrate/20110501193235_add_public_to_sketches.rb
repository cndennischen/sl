class AddPublicToSketches < ActiveRecord::Migration
  def self.up
    add_column :sketches, :public, :boolean, :default => false
    add_index :sketches, :public
  end

  def self.down
    remove_column :sketches, :public
  end
end
