class CreateAuditedActions < ActiveRecord::Migration
  def self.up
    create_table :audited_actions do |t|
      t.string :message
      t.integer :shared_thing_id, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :audited_actions
  end
end
