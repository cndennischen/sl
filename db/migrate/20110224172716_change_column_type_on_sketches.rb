class ChangeColumnTypeOnSketches < ActiveRecord::Migration
  def self.up
    change_column :sketches, :content, :text
  end

  def self.down
    change_column :sketches, :content, :string
  end
end
