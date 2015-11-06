require 'csv'

def resource_path(resource)
  'db/mappings/' + resource
end


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

# write code to get the standard in the file