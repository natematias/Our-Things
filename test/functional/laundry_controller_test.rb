require 'test_helper'

class LaundryControllerTest < ActionController::TestCase
  # Replace this with your real tests.

  test "list laundry devices" do
    get :index
    assert :success
  end

  test "show laundry device" do
    washer = shared_things(:washer)
    get :show, :id=>washer.id
    assert :success
    #ensure that the returned information is sufficient
    get :show, :id=>10
    assert :failure
  end

  test "get laundry device calendar" do
    washer = shared_things(:washer)

    get :calendar, :id=>washer.id
    assert_equal 2, assigns["audited_actions"].size

    get :calendar, :id=>shared_things(:dryer_one).id
    assert_equal 1, assigns["audited_actions"].size
  end

  test "carry out laundry device actions" do 
    get :signal
    assert :failure

    washer = shared_things(:washer)

    assert_difference 'AuditedAction.count', 1 do
      Twitter::Client.any_instance.stubs(:update).returns(true)
      Twitter::Client.any_instance.expects(:update).with("Washing Machine: New Load").returns(true)
      post :signal, {:id=>washer.id, :audited_action=>"start"}
      assert :success
    end

    assert_difference 'AuditedAction.count', 1 do
      Twitter::Client.any_instance.stubs(:update).returns(true)
      Twitter::Client.any_instance.expects(:update).with("Washing Machine: Load removed").returns(true)
      post :signal, {:id=>washer.id, :audited_action=>"remove"}
      assert :success
    end

    assert_difference 'AuditedAction.count', 1 do
      Twitter::Client.any_instance.stubs(:update).returns(true)
      Twitter::Client.any_instance.expects(:update).with("Washing Machine: New Load").returns(true)
      post :signal, {:id=>washer.id, :audited_action=>"displace"}
      assert :success
    end

    assert_difference 'AuditedAction.count', 0 do
      post :signal, {:id=>10, :audited_action=>"start"}
      assert :failure
    end

    assert_difference 'AuditedAction.count', 0 do
      post :signal, {:id=>1, :audited_action=>"Je ne se quois"}
      assert :failure
    end
  end
end
