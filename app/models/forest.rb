class Forest < ApplicationRecord
  has_many :trails

  validates :name, presence: true
  validates :state, presence: true
end
