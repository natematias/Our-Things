class SharedThing < ActiveRecord::Base
  has_many :audited_actions
end
