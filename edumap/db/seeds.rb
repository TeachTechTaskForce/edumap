require 'csv'

# def resource_path(resource)
#   'db/mappings' + resource
# end

def parser(file, resource)
  CSV.foreach(Rails.root.join(resource_path(resource), file)) do |result|
    curriculum = Curriculum.new(name: resource)
    lesson = curriculum.lessons.find_or_create_by(name: result[0])
    code = lesson.codes.find_or_create_by(name:result[1])


    # standard_info = info[1].split(".")
    # standard = Standard.find_or_create_by(name:resource)
    # proficiency = standard.proficiencies.find_or_create_by(name:standard_info[0])
    # level = proficiency.levels.find_or_create_by(name:standard_info[1])
  end
# end

# write code to get the standard in the file