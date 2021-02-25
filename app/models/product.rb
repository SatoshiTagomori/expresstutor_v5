class Product < ApplicationRecord
    validates :prod_id,presence: true,uniqueness: true
    validates :price_id,presence: true,uniqueness: true
end
