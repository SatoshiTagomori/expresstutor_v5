class Pref < ApplicationRecord
    validates :name, uniqueness: true
end
