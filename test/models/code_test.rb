require 'test_helper'

class CodeTestScopes < ActiveSupport::TestCase
  test "it scopes by standard_id" do
    in_scope = Code.create!(standard_id: 1)
    out_of_scope = Code.create!(standard_id: 2)
    assert_equal (Code.with_standard_id [1]), [in_scope]
  end

  test "it scopes by created_at time greater than a number" do
    in_scope = Code.create!(created_at: 1.day.ago)
    out_of_scope = Code.create!(created_at: 3.day.ago)
    assert_equal (Code.with_created_at_gte 2.days.ago), [in_scope]
  end
end

class CodeTestSorting < ActiveSupport::TestCase
  test "it sorts by created_at" do
    second = Code.create!(created_at: 1.day.ago)
    first = Code.create!(created_at: 2.day.ago)
    assert_equal (Code.sorted_by :created_at_bob), [first, second]
  end

  test "it sorts by name" do
    second = Code.create!(identifier: "foo")
    first = Code.create!(identifier: "bar")
    assert_equal (Code.sorted_by :name_bob), [first, second]
  end

  test "it sorts by the standard's abbreviation" do
    second = Code.create!(standard: standards(:defence))
    first = Code.create!(standard: standards(:abacore))
    assert_equal (Code.sorted_by :standard_abbreviation_bob), [first, second]
  end

  test "it otherwise raises an error" do
    #assert_error (Code.sorted_by :asdasdsadsadsa), [first, second]
  end

  test "it reverses the sort if passed the desc flag" do
    10.times { Code.create!(identifier: Random.rand) }
    assert_equal (Code.sorted_by :name_desc),
                 (Code.sorted_by :name_asc).reverse 
  end
end
