class Level < ActiveRecord::Base
   has_and_belongs_to_many :lessons

   def self.options_for_select
     order('id').map { |e| [e.grade, e.id] }
   end
end
