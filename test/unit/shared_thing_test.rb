require 'test_helper'

class SharedThingTest < ActiveSupport::TestCase
  test "find the latest status" do
    assert_equal "Items displaced", shared_things(:washer).last_action.message
    assert_equal "Load removed", shared_things(:dryer_one).last_action.message
    assert_nil shared_things(:dryer_two).last_action
  end
end
