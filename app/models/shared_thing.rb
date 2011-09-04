class SharedThing < ActiveRecord::Base
  has_many :audited_actions, :order => 'created_at DESC'
  def last_action()
    return nil if self.audited_actions.count < 1
    self.audited_actions[-1]
  end
end
