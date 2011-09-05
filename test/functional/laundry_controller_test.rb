require 'test_helper'

class LaundryControllerTest < ActionController::TestCase
  # Replace this with your real tests.

  test "list laundry devices" do
    get :index
    assert :success
  end

  test "show laundry device" do
    get :show, :id=>1
    assert :success
    #ensure that the returned information is sufficient
    get :show, :id=>10
    assert :failure
  end

  test "carry out laundry device actions" do 
    get :signal
    assert :failure

    washer = shared_things(:washer)

    assert_difference 'AuditedAction.count', 1 do
      post :signal, {:id=>washer.id, :audited_action=>"start"}
      assert :success
    end

    assert_difference 'AuditedAction.count', 1 do
      post :signal, {:id=>washer.id, :audited_action=>"remove"}
      assert :success
    end

    assert_difference 'AuditedAction.count', 1 do
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
