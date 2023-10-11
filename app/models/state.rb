class State < ApplicationRecord
  has_many :doctors, foreign_key: 'state_id'
  has_many :transactions, through: :doctors
  has_many :towns,class_name: 'Town'
end
