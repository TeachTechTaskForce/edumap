require 'test_helper'

class LessonsControllerTest < ActionController::TestCase
  test "load_lessons redirects to saved_lessons" do
     get(:load_lessons, lessons: [2, 3, 4, 5, 6])
     assert_redirected_to :saved_lessons
  end

  test "load_lessons adds the lesson ids to the session" do
     get(:load_lessons, lessons: [2, 3])
     assert_equal session[:lessons], ['2', '3']
  end
end
