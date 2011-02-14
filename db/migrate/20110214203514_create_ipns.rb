class CreateIpns < ActiveRecord::Migration
  def self.up
    create_table :ipns do |t|
      t.text :params
      t.string :status
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :ipns
  end
end
