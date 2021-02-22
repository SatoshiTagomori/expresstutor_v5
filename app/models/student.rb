class Student < ApplicationRecord
    has_one :personal
    validates :lineid ,presence: true,uniqueness: true
    validates :name,presence: true
end
