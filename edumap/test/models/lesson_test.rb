require 'test_helper'

class LessonTestSearchQueryScope < ActiveSupport::TestCase
  test "it returns nil if the query is blank" do
    #assert_nil Lesson.search_query ""
  end

  test "it searches on one word" do
    in_scope = Lesson.create!(name: "foo")
    out_of_scope = Lesson.create!(name: "bar")
    assert_equal (Lesson.search_query "foo"), [in_scope]
  end

  test "it searches two words like an AND clause" do
    in_scope = Lesson.create!(name: "foo bar")
    out_of_scope = Lesson.create!(name: "foo")
    assert_equal (Lesson.search_query "foo bar"), [in_scope]
  end

  test "does not enforce an order of words" do
    in_scope = Lesson.create!(name: "foo bar")
    assert_equal (Lesson.search_query "bar foo"), [in_scope]
  end

  test "it searches words on the lesson url" do
    in_scope = Lesson.create!(name: "foo bar", lesson_url: "baz")
    assert_equal (Lesson.search_query "baz"), [in_scope]
  end

  test "it AND clauses both the name and url" do
    in_scope = Lesson.create!(name: "foo bar", lesson_url: "baz")
    assert_equal (Lesson.search_query "foo baz"), [in_scope]
  end

  test "it allows partial matches" do
    in_scope = Lesson.create!(name: "foobar")
    assert_equal (Lesson.search_query "foo"), [in_scope]
  end

  test "it can match to the same query twice" do
    in_scope = Lesson.create!(name: "foobar")
    assert_equal (Lesson.search_query "foo bar"), [in_scope]
  end

  test "it allows wildcards" do
    in_scope = Lesson.create!(name: "foobar")
    assert_equal (Lesson.search_query "f*r"), [in_scope]
  end
end

class LessonTestScopes < ActiveSupport::TestCase
  test "it scopes by standard" do
    in_scope = Lesson.create!(standards: [standards(:defence)])
    out_of_scope = Lesson.create!(standards: [standards(:abacore)])
    assert_equal (Lesson.with_standard standards(:defence).id), [in_scope]
  end

  test "it scopes to the grade when a matching level is present" do
    in_scope = Lesson.create!(levels: [levels(:one)])
    out_of_scope = Lesson.create!(levels: [levels(:two)])
    assert_equal (Lesson.with_grade levels(:one).id), [in_scope]
  end

  test "it scopes to the grade when a matching range of levels is present" do
    [levels(:one), levels(:two), levels(:three), levels(:four)].each(&:touch)
    in_scope = Lesson.create!(levels: [levels(:one), levels(:three)])
    out_of_scope = Lesson.create!(levels: [levels(:three), levels(:four)])
    assert_equal (Lesson.with_grade levels(:two).id), [in_scope]
  end

  test "it groups by the lesson id" do
    in_scope = Lesson.create!(standards: [standards(:defence), standards(:abacore)])
    assert_equal (Lesson.with_standard(in_scope.standards.pluck(:id))), [in_scope]
  end

  test "it scopes by created_at time greater than a number" do
    in_scope = Lesson.create!(created_at: 1.day.ago)
    out_of_scope = Lesson.create!(created_at: 3.day.ago)
    assert_equal (Lesson.with_created_at_gte 2.days.ago), [in_scope]
  end

  test "it scopes by plugged versus unplugged" do
    in_scope = Lesson.create!(plugged?: false)
    out_of_scope = Lesson.create!(plugged?: true)
    assert_equal Lesson.with_plugged(false), [in_scope]
  end
end

class LessonTestSorting < ActiveSupport::TestCase
  test "it sorts by name" do
    second = Lesson.create!(name: "foo")
    first = Lesson.create!(name: "bar")
    assert_equal (Lesson.sorted_by :name_bob), [first, second]
  end

  test "it sorts by created_at" do
    second = Lesson.create!(created_at: 1.day.ago)
    first = Lesson.create!(created_at: 2.day.ago)
    assert_equal (Lesson.sorted_by :created_at_bob), [first, second]
  end
end
