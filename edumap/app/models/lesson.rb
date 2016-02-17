class Lesson < ActiveRecord::Base
  filterrific :default_filter_params => { :sorted_by => 'created_at_desc' },
                :available_filters => %w[
                  sorted_by
                  search_query
                  with_standard
                  with_grade
                  with_created_at_gte
                ]

  self.per_page = 10

  # belongs_to :unit
  belongs_to :curriculum
  has_and_belongs_to_many :codes
  has_and_belongs_to_many :levels
  has_and_belongs_to_many :standards

  scope :search_query, lambda { |query|
    return nil  if query.blank?
    # condition query, parse into individual keywords
    terms = query.downcase.split(/\s+/)
    # replace "*" with "%" for wildcard searches,
    # append '%', remove duplicate '%'s
    terms = terms.map { |e|
      ("%" + e.gsub('*', '%') + '%').gsub(/%+/, '%')
    }
    # configure number of OR conditions for provision
    # of interpolation arguments. Adjust this if you
    # change the number of OR conditions.
    num_or_conditions = 2
    where(
      terms.map {
        or_clauses = [
          "LOWER(lessons.name) LIKE ?",
          "LOWER(lessons.lesson_url) LIKE ?",
        ].join(' OR ')
        "(#{ or_clauses })"
      }.join(' AND '),
      *terms.map { |e| [e] * num_or_conditions }.flatten
    )
  }

  scope :sorted_by, lambda { |sort_option|
    # extract the sort direction from the param value.
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
    when /^created_at_/
      order("lessons.created_at #{ direction }")
    when /^name_/
      order("LOWER(lessons.name) #{ direction }")
    else
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }

  scope :with_standard, lambda { |standards|
    joins(:standards).where("standards.id = ?", *standards).group('lessons.id')
  }

  scope :with_grade, lambda { |grade|
    joins(:levels).where("levels.id = ?", *grade).group('lessons.id')
  }

  scope :with_created_at_gte, lambda { |ref_date|
    where('codes.created_at >= ?', ref_date)
  }

  def self.options_for_sorted_by
    [
      ['Name (a-z)', 'name_asc'],
      ['Creation date (newest first)', 'created_at_desc'],
      ['Creation date (oldest first)', 'created_at_asc'],
    ]
  end

  def level_list
    if self.levels.blank?
      "No data"
    elsif self.levels.length < 2
      self.levels[0].grade
    else
      levels_ordered = self.levels.order(:id)
      "#{levels_ordered[0].grade}-#{levels_ordered.last.grade}"
    end
  end

end
