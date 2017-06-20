class Event < ApplicationRecord

 validates_presence_of :name

 def to_param
   "#{self.id}-#{self.name}"
 end
end
