class Standard < ActiveRecord::Base
  # has_many :proficiencies
  has_many :codes

  def self.options_for_select
    order('LOWER(abbreviation)').map { |e| [e.abbreviation, e.id] }
  end
end
