class CreateSketches < ActiveRecord::Migration
  def self.up
    create_table :sketches do |t|
      t.string :name
      t.text :content
			t.integer :user_id

      t.timestamps
    end

    add_index :user_id
  end

  def self.down
    drop_table :sketches
  end
end
