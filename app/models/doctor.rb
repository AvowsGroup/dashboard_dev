class Doctor < ApplicationRecord
    belongs_to :state, class_name: 'State', foreign_key: 'state_id'
    has_many :transactions, foreign_key: 'doctor_id'
end
