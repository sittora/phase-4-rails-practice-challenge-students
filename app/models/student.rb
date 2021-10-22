class Student < ApplicationRecord
   belongs_to :instructor 

   validates :name, presence: true
   validate :over_18

   def over_18
    unless(age >= 18) 
        errors.add(:age, "Must be 18 or over to register")
    end
   end
end
