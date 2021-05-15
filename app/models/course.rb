class Course < ApplicationRecord
  validates :name, :code, :price, 
             presence: { message: 'não pode ficar em branco' }, 
             uniqueness: { scope: :code, message: 'já está em uso' }
end
