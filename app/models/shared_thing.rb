class SharedThing < ActiveRecord::Base
  has_many :audited_actions, :order => 'created_at ASC'
  def last_action()
    return nil if self.audited_actions.count < 1
    self.audited_actions[-1]
  end

  def record_action action
    if action.nil? or !possible_actions.has_key? action
      return nil
    end
    self.audited_actions.create!(:message => possible_actions[action])
  end

  protected
  def possible_actions
    {}
  end

end
