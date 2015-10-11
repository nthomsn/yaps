class Course < ActiveRecord::Base
  has_and_belongs_to_many :programs

  validates :name, uniqueness: true
end
