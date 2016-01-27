class Lesson < ActiveRecord::Base
  filterrific :default_filter_params => { :sorted_by => 'created_at_desc' },
                :available_filters => %w[
                  sorted_by
                  search_query
                  with_standard
                  with_created_at_gte
                ]

  self.per_page = 10

  # belongs_to :unit
  belongs_to :curriculum
  has_and_belongs_to_many :codes
  has_and_belongs_to_many :levels
  has_and_belongs_to_many :standards

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
    joins(:standards).where("standards.id = ?", *standards)
  }

  scope :with_created_at_gte, lambda { |ref_date|
    where('codes.created_at >= ?', ref_date)
  }

  def self.options_for_sorted_by
    [
      ['Identifier (a-z)', 'identifier_asc'],
      ['Creation date (newest first)', 'created_at_desc'],
      ['Creation date (oldest first)', 'created_at_asc'],
    ]
  end
end
