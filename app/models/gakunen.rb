class Gakunen < ApplicationRecord
    validates :name,uniqueness: true
end
