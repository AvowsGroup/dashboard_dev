class Employer < ApplicationRecord
	belongs_to :state, class_name: 'State', foreign_key: 'state_id'
	belongs_to :town, class_name: 'Town', foreign_key: 'town_id'
end
