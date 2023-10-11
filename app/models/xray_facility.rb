class XrayFacility < ApplicationRecord
	 belongs_to :state, class_name: 'State', foreign_key: 'state_id'
	  belongs_to :status_schedule, class_name: 'StatusSchedule', foreign_key: 'id'
    has_many :transactions, foreign_key: 'doctor_id'
end
