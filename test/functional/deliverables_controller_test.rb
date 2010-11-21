require 'test_helper'

class DeliverablesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:deliverables)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create deliverable" do
    assert_difference('Deliverable.count') do
      post :create, :deliverable => { }
    end

    assert_redirected_to deliverable_path(assigns(:deliverable))
  end

  test "should show deliverable" do
    get :show, :id => deliverables(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => deliverables(:one).to_param
    assert_response :success
  end

  test "should update deliverable" do
    put :update, :id => deliverables(:one).to_param, :deliverable => { }
    assert_redirected_to deliverable_path(assigns(:deliverable))
  end

  test "should destroy deliverable" do
    assert_difference('Deliverable.count', -1) do
      delete :destroy, :id => deliverables(:one).to_param
    end

    assert_redirected_to deliverables_path
  end
end
