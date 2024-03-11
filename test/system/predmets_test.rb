require "application_system_test_case"

class PredmetsTest < ApplicationSystemTestCase
  setup do
    @predmet = predmets(:one)
  end

  test "visiting the index" do
    visit predmets_url
    assert_selector "h1", text: "Predmets"
  end

  test "should create predmet" do
    visit predmets_url
    click_on "New predmet"

    click_on "Create Predmet"

    assert_text "Predmet was successfully created"
    click_on "Back"
  end

  test "should update Predmet" do
    visit predmet_url(@predmet)
    click_on "Edit this predmet", match: :first

    click_on "Update Predmet"

    assert_text "Predmet was successfully updated"
    click_on "Back"
  end

  test "should destroy Predmet" do
    visit predmet_url(@predmet)
    click_on "Destroy this predmet", match: :first

    assert_text "Predmet was successfully destroyed"
  end
end
