class Lesson < ActiveRecord::Base
  filterrific :default_filter_params => { :sorted_by => 'created_at_desc' },
                :available_filters => %w[
                  sorted_by
                  search_query
                  with_standard
                  with_grade
                  with_created_at_gte
                  with_plugged
                ]

  self.per_page = 10

  belongs_to :curriculum
  has_and_belongs_to_many :codes
  has_and_belongs_to_many :levels
  has_and_belongs_to_many :standards

  scope :search_query, lambda { |query|
    return nil if query.blank?
    # most people use * for wildcard searches
    # MySQL uses % instead for reasons
    terms = query.downcase.split(/\s+/)
                 .map{|e| e.gsub('*', '%')}
                 .map{|e| "%#{e}%"}

    terms.inject(self) do |current_scope, term|
      current_scope.where(
          "LOWER(lessons.name) LIKE :term OR LOWER(lessons.lesson_url) LIKE :term",
          term: term
      )
    end
  }


  scope :with_created_at_gte, -> (ref_date) { where('created_at >= ?', ref_date) }

  scope :with_standard, -> (standards) { with_association(:standards, standards) }
  scope :with_grade, -> (level) do
    where(id: joins(:levels).where("levels.id <= ?", level))
      .where(id: joins(:levels).where("levels.id >= ?", level))
  end
  scope :with_association, -> (assoc, assoc_ids) do
    joins(assoc).where(assoc => {id: assoc_ids}).group("lessons.id")
  end
  scope :with_plugged, -> (value) { where(plugged?: value) }

  scope :sorted_by, -> sort_option do
    # extract the sort direction from the param value.
    output = case sort_option.to_s
    when /^created_at_/
      order(:created_at)
    when /^name_/
      order("LOWER(lessons.name)")
    else
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
    output = output.reverse_order if sort_option =~ /desc$/
    output
  end

  def self.options_for_sorted_by
    [
      ['Name (a-z)', 'name_asc'],
      ['Creation date (newest first)', 'created_at_desc'],
      ['Creation date (oldest first)', 'created_at_asc'],
    ]
  end

  def level_list
    if levels.blank?
      "No data"
    elsif levels.length == 1
      levels.first.grade
    else
      levels_ordered = levels.order(:id)
      "#{levels_ordered.first.grade}-#{levels_ordered.last.grade}"
    end
  end

end
