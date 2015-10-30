require 'csv'

# def resource_path(resource)
#   'db/mappings' + resource
# end

# def parser(file, resource)
#   CSV.foreach(Rails.root.join(resource_path(resource), file)) do |result|
#     info = result.split(",")
#     curriculum_info = info[0]
#     standard_info = info[1].split(".")

#     standard = Standard.find_or_create_by(name:resource)
#     proficiency = standard.proficiencies.find_or_create_by(name:standard_info[0])
#     level = proficiency.levels.find_or_create_by(name:standard_info[1])
#     code = Level.find_or_create_by(code:standard_info[2])
#   end
# end