# Loading New Curricula & Standards

## Lesson Steps

* Create file with these names for all the columns which have information for the
given set of lessons:
   * `name`
   * `url`
   * `time`
   * `description`
   * `plugged`
     * Note for this one, it's only checking if it's empty, or if there is an "N"
     in the column indicating it's unplugged.
   * `grade`
   * `code`
   * `standard`
* Add the file to `db/seeds/lessons`
* At the end of `seeds.rb`, add a line that calls the function `lesson_parser`
with the filename (prefaced by `lessons/` so `lesssons/FILENAME.csv`) as the first
argument, the curriculum name that the lessons come from as the second argument,
and the curriculum URL as the third argument. EX: `lesson_parser('lessons/test.csv', 'Test Lessons', 'http://test.lessons')`
* Locally, run `rake db:seed`, and on Heroku you should be able to run
`heroku run rake db:seed`, and it should only load new data so you don't have to
worry about clearing out old data beforehand.

### Lesson Loading Notes

In order to make loading as simple as possible, you can only include one standard,
code, or grade per lesson per row, i.e. if a single lesson is for both 5th and 6th
grade, you'll have two rows with the same information where only the grade is changed.
This applies to standards and codes as well.
