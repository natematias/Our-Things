class CreateSharedThings < ActiveRecord::Migration
  def self.up
    create_table :shared_things do |t|
      t.string :type
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :shared_things
  end
end
