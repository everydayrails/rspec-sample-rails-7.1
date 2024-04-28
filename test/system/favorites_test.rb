require "application_system_test_case"

class FavoritesTest < ApplicationSystemTestCase
  setup do
    @favorite = favorites(:one)
  end

  test "visiting the index" do
    visit favorites_url
    assert_selector "h1", text: "Favorites"
  end

  test "should create favorite" do
    visit favorites_url
    click_on "New favorite"

    fill_in "Recipe", with: @favorite.recipe_id
    fill_in "User", with: @favorite.user_id
    click_on "Create Favorite"

    assert_text "Favorite was successfully created"
    click_on "Back"
  end

  test "should update Favorite" do
    visit favorite_url(@favorite)
    click_on "Edit this favorite", match: :first

    fill_in "Recipe", with: @favorite.recipe_id
    fill_in "User", with: @favorite.user_id
    click_on "Update Favorite"

    assert_text "Favorite was successfully updated"
    click_on "Back"
  end

  test "should destroy Favorite" do
    visit favorite_url(@favorite)
    click_on "Destroy this favorite", match: :first

    assert_text "Favorite was successfully destroyed"
  end
end
