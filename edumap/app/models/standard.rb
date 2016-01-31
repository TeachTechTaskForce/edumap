class Standard < ActiveRecord::Base
  # has_many :proficiencies
  has_many :codes
  has_and_belongs_to_many :lessons

  def self.options_for_select
    order('LOWER(abbreviation)').map { |e| [e.abbreviation, e.id] }
  end
end
