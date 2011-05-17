class AddPositionToSketches < ActiveRecord::Migration
  def self.up
    add_column :sketches, :position, :integer
  end

  def self.down
    remove_column :sketches, :position
  end
end
