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

   test "send_lessons redirects to root path" do
     lesson_id = Lesson.create!(name: "lesson", lesson_url: "http://example.com").id
     post(:send_lessons, { email: "example@example.com" }, lessons: [lesson_id])
     assert_redirected_to root_path
   end

   test "send_lessons emails a list of lessons" do
     lesson_id = Lesson.create!(name: "lesson", lesson_url: "http://example.com").id
     post(:send_lessons, { email: "example@example.com" }, lessons: [lesson_id])
     assert_send([SessionsMailer, :lessons_email, [lesson_id]])
   end

   test "send_lessons clears the lesson list if clear_lessons is set" do
     lesson_id = Lesson.create!(name: "lesson", lesson_url: "http://example.com").id
     post(:send_lessons, { email: "example@example.com", clear_lessons: "on" }, lessons: [lesson_id])
     assert_equal session[:lessons], []
   end

   test "send_lessons does not clear lesson list if clear_lessons is not set" do
     lesson_id = Lesson.create!(name: "lesson", lesson_url: "http://example.com").id
     post(:send_lessons, { email: "example@example.com" }, lessons: [lesson_id])
     assert_equal session[:lessons], [lesson_id]
   end
end

class LoadSessionsTest < ActionController::TestCase
end
