require "test_helper"

class UserCoffeesControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:admin)
  end

  teardown do
    sign_out users(:admin)
  end
  test "should GET index" do
    get user_coffees_url
    assert_response :success
  end

  test "should GET show" do
    get user_coffee_path(users(:admin).user_coffees.first)
    assert_response :success
  end

  test "POST update should update the content" do
    assert_equal users(:admin).user_coffees.first.personal_notes, nil
    patch user_coffee_path(users(:admin).user_coffees.first), params: {
      user_coffee: {personal_notes: "test for updating user coffee"}
    }
    assert_response :success
    assert_equal users(:admin).user_coffees.first.personal_notes, "test for updating user coffee"
  end

  test "POST update with weight_left < 0 should update archived" do
    assert_equal users(:admin).user_coffees.first.archived, nil
    patch user_coffee_path(users(:admin).user_coffees.first), params: {user_coffee: {weight_left: -1}}
    assert_response :success
    assert_equal users(:admin).user_coffees.first.archived, true
  end

  test "should POST create" do
    post user_coffees_path, params: {user_coffee: { bag_weight: 250, price: 23}, coffee: coffees(:coffee_one).attributes}
    assert_response :redirect
  end

  test "should GET new" do
    get new_user_coffee_url
    assert_response :success
  end
end
