class CreateAds < ActiveRecord::Migration
  def self.up
    create_table :ads do |t|
      t.string :name
      t.text :code

      t.timestamps
    end
    add_index :ads, :name
  end

  def self.down
    drop_table :ads
  end
end
