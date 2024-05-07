require "test_helper"

class Api::RecipesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_recipes_index_url
    assert_response :success
  end

  test "should get show" do
    get api_recipes_show_url
    assert_response :success
  end
end
