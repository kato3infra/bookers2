class Book < ApplicationRecord
  
  has_one_attached :imag
  
  belongs_to :user
  
end
