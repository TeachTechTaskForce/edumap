class Code < ActiveRecord::Base
  belongs_to :standard
  has_and_belongs_to_many :lessons

  filterrific(
  default_filter_params: { sorted_by: 'created_at_desc' },
  available_filters: [
    :sorted_by,
    :with_standard_id
  ]
  )

  self.per_page = 10

  scope :sorted_by, lambda { |sort_option|
    # extract the sort direction from the param value.
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
    when /^created_at_/
      order("codes.created_at #{ direction }")
    else
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }

  scope :with_standard_id, lambda { |standard_ids|
    where(:standard_id => [*standard_ids])
  }

  def self.options_for_sorted_by
    [
      ['Creation date (newest first)', 'created_at_desc'],
    ]
  end
end
