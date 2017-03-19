require 'csv'
=begin
def resource_path(resource)
  'db/mappings/seed' + resource
end
=end

def standard_parser(file)
  resource_path = 'db/seeds'
  CSV.foreach(Rails.root.join(resource_path, file)) do |result|
    standard = Standard.find_or_create_by(name: result[0], abbreviation: result[1])
  end
end

def code_parser(file)
  resource_path = 'db/seeds'
  CSV.foreach(Rails.root.join(resource_path, file)) do |result|
    standard = Standard.find_or_create_by(abbreviation: result[2])
    code = Code.find_or_create_by(identifier: result[0], description: result[1], standard: standard)
  end
end

def level_parser(file)
  resource_path = 'db/seeds'
  CSV.foreach(Rails.root.join(resource_path, file)) do |result|
    level = Level.find_or_create_by(grade: result[0])
  end
end

# Kludge: all of our seed files are in different formats
# TODO make all scrapers use the same data template-thingy
def code_org_parser(file)
  resource_path = 'db/seeds'
  CSV.foreach(Rails.root.join(resource_path, file)) do |result|
    curriculum = Curriculum.find_or_create_by(name: result[1])
    standard = Standard.find_or_create_by(abbreviation: result[3])
    code = Code.find_or_create_by(identifier: result[4], standard: standard)
    lesson = Lesson.find_or_create_by(name: result[2], curriculum: curriculum, lesson_url: result[0])
    unless lesson.codes.exists?(identifier: result[4])
      lesson.codes << code
    end
    unless lesson.standards.exists?(abbreviation: result[3])
      lesson.standards << standard
    end
    unless lesson.levels.exists?(grade: result[5].to_i.ordinalize)
      unless result[5] == 'K'
        lesson.levels << Level.find_or_create_by(grade: result[5].to_i.ordinalize)
      else
        lesson.levels << Level.find_or_create_by(grade: result[5])
      end
    end
  end
end

def bootstrap_parser(file)
  resource_path = "db/seeds"
  CSV.foreach(Rails.root.join(resource_path, file)) do |result|
    curriculum = Curriculum.find_or_create_by(name: "Bootstrap World")
    bootstrap_standard = Standard.find_or_create_by(abbreviation: "Bootstrap")
    ccmath = Standard.find_or_create_by(abbreviation: "CC Math")
    if result[1].start_with?('BS')
      code = Code.find_or_create_by(identifier: result[1], standard: bootstrap_standard)
      standard = bootstrap_standard
    else
      code = Code.find_or_create_by(identifier: result[1], standard: ccmath)
      standard = ccmath
    end
    lesson = Lesson.find_or_create_by(name: result[4], curriculum: curriculum, lesson_url: result[0], description: result[5], time: result[-1])
    unless lesson.codes.exists?(identifier: result[1])
      lesson.codes << code
    end
    unless lesson.standards.exists?(abbreviation: result[3])
      lesson.standards << standard
    end
  end
end

def cs_first_parser(file)
  resource_path = "db/seeds"
  CSV.foreach(Rails.root.join(resource_path, file)) do |result|
    curriculum = Curriculum.find_or_create_by(name: result[1])
    lesson = Lesson.find_or_create_by(name: result[2], curriculum: curriculum, lesson_url: result[0], description: result[3])
  end
end

def ct_stem_parser(file)
  resource_path = 'db/mappings/seed'
  CSV.foreach(Rails.root.join(resource_path, file)) do |result|
    curriculum = Curriculum.find_or_create_by(name: "Northwestern CT-STEM", curriculum_url: "http://ct-stem.northwestern.edu/lesson-plans/")
    lesson = Lesson.find_or_create_by(name: result[0], curriculum: curriculum)
    lesson.lesson_url = result.last
  end
end

# Assumes that the column names match their names in the database
=begin
Lesson
 - name
 - url
 - time
 - description
 - plugged
 - grade
 - code
 - standard
=end
def lesson_parser(file, curr_name, curr_url)
  resource_path = 'db/seeds'
  curriculum = Curriculum.find_or_create_by(name: curr_name, curriculum_url: curr_url)
  CSV.foreach(Rails.root.join(resource_path, file), headers: true) do |result|
    # Checking if plugged column exists, only process if not nil
    unless result["plugged"]
      plugged = true
    else
      # Checks if N/n/No/no is in col, otherwise follows default of true
      plugged = (result["plugged"].downcase.include? "n") ? false : true
    end
    lesson = Lesson.find_or_create_by(
      name: result["name"],
      lesson_url: result["url"],
      time: result["time"],
      description: result["description"],
      plugged?: plugged,
      curriculum: curriculum
    )
    # In order to make loading as simple as possible, will only add one code,
    # standard, or grade/level per row, so because using find_or_create_by,
    # should have multiple rows for one lesson to reflect multiple standards
    standard = Standard.find_or_create_by(abbreviation: result["standard"])
    code = Code.find_or_create_by(identifier: result["code"], standard: standard)
    unless lesson.codes.exists?(identifier: result["code"])
      lesson.codes << code
    end
    unless lesson.standards.exists?(abbreviation: result["standard"])
      lesson.standards << standard
    end
    if result["grade"]
      unless lesson.levels.exists?(grade: result["grade"].to_i.ordinalize)
        unless result["grade"] == 'K'
          lesson.levels << Level.find_or_create_by(grade: result["grade"].to_i.ordinalize)
        else
          lesson.levels << Level.find_or_create_by(grade: result["grade"])
        end
      end
    end
  end
end

=begin
def parser(file, resource)
  standard_parser = file.split(".")[0]
  curriculum = Curriculum.find_or_create_by(name: resource)
  standard = Standard.find_or_create_by(name: standard_parser)
  CSV.foreach(Rails.root.join(resource_path(resource), file)) do |result|
    lesson = curriculum.lessons.find_or_create_by(name: result[0])
    code = lesson.codes.find_or_create_by(name:result[1])
    standard.codes << code

    # standard_info = info[1].split(".")
    # standard = Standard.find_or_create_by(name:resource)
    # proficiency = standard.proficiencies.find_or_create_by(name:standard_info[0])
    # level = proficiency.levels.find_or_create_by(name:standard_info[1])
  end
end

parser("CSTA.csv","code.org")
=end

standard_parser("standards/standards.csv")
code_parser("standards/ngss_topics.csv")
code_parser("standards/CSTA_codes.csv")
code_parser("standards/CC_Codes.csv")
code_parser("standards/ISTE_codes.csv")
level_parser("levels/levels.csv")
code_org_parser("lessons/code_org_lessons.csv")
# ct_stem_parser("ct_stem.csv")
bootstrap_parser("lessons/bootstrap_world.csv")
cs_first_parser("lessons/cs_first_lessons.csv")

# write code to get the standard in the file
