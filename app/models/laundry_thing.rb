class LaundryThing < SharedThing
  def self.possible_actions
    {"start"=>"New Load",
     "remove"=>"Load removed",
     "displace"=>"Items displaced"}
  end
end
