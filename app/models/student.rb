class Student < ApplicationRecord
    validates :lineid ,presence: true,uniqueness: true
    validates :name,presence: true
end
