class AddSketchCount < ActiveRecord::Migration
  def self.up
    add_column :users, :sketches_count, :integer, :default => 0

    User.reset_column_information
    User.all.each do |u|
      User.update_counters u.id, :sketches_count => u.sketches.length
    end
  end

  def self.down
    remove_column :users, :sketches_count
  end
end
