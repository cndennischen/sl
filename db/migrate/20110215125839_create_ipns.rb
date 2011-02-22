class CreateIpns < ActiveRecord::Migration
  def self.up
    create_table :ipns do |t|
      t.text :params
      t.integer :user_id
      t.boolean :okay

      t.timestamps
    end

    add_index :ipns, :user_id
  end

  def self.down
    drop_table :ipns
  end
end
