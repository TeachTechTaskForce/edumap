class StaticPagesControllerTest < ActionController::TestCase
  test "#about renders the About page" do
    get(:about)
    assert_template "about"
  end
end
