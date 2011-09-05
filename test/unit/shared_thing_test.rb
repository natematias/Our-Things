require 'test_helper'

class SharedThingTest < ActiveSupport::TestCase
  test "find the latest audited action" do
    assert_equal "Items displaced", shared_things(:washer).last_action.message
    assert_equal "Load removed", shared_things(:dryer_one).last_action.message
    assert_nil shared_things(:dryer_two).last_action
  end

  test "add a new audited action" do
    washer = shared_things(:washer) 
    assert_difference 'AuditedAction.count', 1 do
      assert_difference 'washer.audited_actions.count', 1 do
        washer.record_action "remove"
        washer.reload
        assert_equal "Load removed", washer.last_action.message
      end
    end
    assert_nil washer.record_action "hooliganism"
  end
end
