require 'test_helper'

class WikialgosControllerTest < ActionController::TestCase
  setup do
    @wikialgo = wikialgos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:wikialgos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create wikialgo" do
    assert_difference('Wikialgo.count') do
      post :create, wikialgo: {  }
    end

    assert_redirected_to wikialgo_path(assigns(:wikialgo))
  end

  test "should show wikialgo" do
    get :show, id: @wikialgo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @wikialgo
    assert_response :success
  end

  test "should update wikialgo" do
    put :update, id: @wikialgo, wikialgo: {  }
    assert_redirected_to wikialgo_path(assigns(:wikialgo))
  end

  test "should destroy wikialgo" do
    assert_difference('Wikialgo.count', -1) do
      delete :destroy, id: @wikialgo
    end

    assert_redirected_to wikialgos_path
  end
end
