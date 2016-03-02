class SessionsControllerTest < ActionController::TestCase
   test "add_lesson adds the lesson id to the session" do
     post(:add_lesson, lesson: 2)
     assert_includes session[:lessons], '2'
   end

   test "add_lesson does not add duplicate lessons" do
     post(:add_lesson, lesson: 2)
     post(:add_lesson, lesson: 2)
     assert_equal session[:lessons], ['2']
   end

   test "remove_lesson removes the lesson id to the session" do
     session[:lessons] = ["2"]
     post(:remove_lesson, lesson: 2)
     assert_not_includes session[:lessons], '2'
   end

   test "response includes array of all remaining lesson ids" do
     post(:add_lesson, lesson: 2)
     assert_equal @response.body, ["2"].to_json
   end
end

class LoadSessionsTest < ActionController::TestCase
end
