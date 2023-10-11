class StatusSchedule < ApplicationRecord
	belongs_to :doctor, class_name: 'Doctor', foreign_key: 'status_schedule_id'
end
