require "test_helper"

class PredmetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @predmet = predmets(:one)
  end

  test "should get index" do
    get predmets_url
    assert_response :success
  end

  test "should get new" do
    get new_predmet_url
    assert_response :success
  end

  test "should create predmet" do
    assert_difference("Predmet.count") do
      post predmets_url, params: { predmet: {  } }
    end

    assert_redirected_to predmet_url(Predmet.last)
  end

  test "should show predmet" do
    get predmet_url(@predmet)
    assert_response :success
  end

  test "should get edit" do
    get edit_predmet_url(@predmet)
    assert_response :success
  end

  test "should update predmet" do
    patch predmet_url(@predmet), params: { predmet: {  } }
    assert_redirected_to predmet_url(@predmet)
  end

  test "should destroy predmet" do
    assert_difference("Predmet.count", -1) do
      delete predmet_url(@predmet)
    end

    assert_redirected_to predmets_url
  end
end
