class AuditedAction < ActiveRecord::Base
  belongs_to :shared_thing
end
