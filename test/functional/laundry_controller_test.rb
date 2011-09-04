require 'test_helper'

class LaundryControllerTest < ActionController::TestCase
  # Replace this with your real tests.

  test "list laundry devices" do
    get :list
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
    assert_difference 'AuditedAction.count', 1 do
      post :signal, {:id=>1, :action=>"start"}
      assert :success
    end

    assert_difference 'AuditedAction.count', 1 do
      post :signal, {:id=>1, :action=>"remove"}
      assert :success
    end

    assert_difference 'AuditedAction.count', 1 do
      post :signal, {:id=>1, :action=>"displace"}
      assert :success
    end

    assert_difference 'AuditedAction.count', 0 do
      post :signal, {:id=>10, :action=>"start"}
      assert :failure
    end

    assert_difference 'AuditedAction.count', 0 do
      post :signal, {:id=>1, :action=>"Je ne se quois"}
      assert :failure
    end
  end
end
