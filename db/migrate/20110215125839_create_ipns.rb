class CreateIpns < ActiveRecord::Migration
  def self.up
    create_table :ipns do |t|
      t.text :params
      t.integer :user_id
      t.string :status
      t.string :transaction_id
      t.timestamps
    end
  end

  def self.down
    drop_table :ipns
  end
end
