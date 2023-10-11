# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



country_names = [
  'United States', 'Canada', 'United Kingdom', 'Australia', 'Germany',
  'France', 'India', 'Japan', 'Brazil', 'Mexico', 'China', 'South Africa'
]

country_names.each { |name|Country.create(name: name)}


malaysian_states = [
  'Johor', 'Kedah', 'Kelantan', 'Melaka', 'Negeri Sembilan',
  'Pahang', 'Perak', 'Perlis', 'Pulau Pinang', 'Sabah', 'Sarawak', 'Selangor', 'Terengganu'
]
malaysian_states.each { |name| State.create(name: name) }

sector_names = [
  'Technology', 'Finance', 'Healthcare', 'Education', 'Manufacturing',
  'Retail', 'Hospitality', 'Transportation', 'Energy', 'Entertainment'
]
sector_names.each { |name| JobType.create(name: name) }

["northern","central","southern","east_coast","agency","web_portal"].each do |name|
  Organization.create(name: name)
end

100.times {Doctor.create(state_id: State.ids.shuffle.first,town_id: Town.ids.shuffle.first)}
100.times {XrayFacility.create(state_id: State.ids.shuffle.first,town_id: Town.ids.shuffle.first)}
100.times {Laboratory.create(state_id: State.ids.shuffle.first,town_id: Town.ids.shuffle.first)}
100.times {Employer.create(state_id: State.ids.shuffle.first,town_id: Town.ids.shuffle.first)}

100.times 
XrayReview.create(created_at: (Date.today - (rand(1.1000)).days) + rand(1..10).days)
end 

#pcr review creation
100.times do |i|
  PcrReview.create(created_at: (Date.today - (rand(1.1000)).days) + rand(1..10).days)
end 

1000.times do |i| 
  foreignWorker = ForeignWorker.create()
  Transaction.create!(foreign_worker_id: foreignWorker.id,fw_job_type_id: JobType.ids.shuffle.first,fw_country_id: Country.ids.shuffle.first,doctor_id: Doctor.ids.shuffle.first,fw_gender: ["male","female"].shuffle.first,fw_date_of_birth: Faker::Date.birthday,created_at: Date.today - rand(1..1000).days,medical_examination_date:Date.today - rand(1..1000).days ,organization_id: Organization.ids.shuffle.first,registration_type: ["new_registration","renewal"].shuffle.first,certification_date: (Date.today - (rand(1.1000)).days),pcr_review_id: PcrReview.ids.sample ,xray_review_id: XrayReview.ids.sample )
  InsurancePurchase.create!(foreign_worker_id: foreignWorker.id)
  puts "#{i} records created"
end 
# Transaction.all.map{|i| i.update(created_at: Date.today - rand(1..1000).days,medical_examination_date:Date.today - rand(1..1000).days ,organization_id: Organization.ids.shuffle.first,registration_type: ["new","renewal"].shuffle.first)}

puts "created ForeignWorker, transaction, InsurancePurchase"


puts "created Organization"

# Transaction.all.each {|i| i.update(organization_id: Organization.ids.shuffle.first,registration_type: ["new","renewal"].shuffle.first))}

# Transaction.all.each {|i| i.update(registration_type: ["new","renewal"].shuffle.first)}


Transaction.ids.each do |i|
  a = MedicalAppeal.new()
  a.transaction_id = i
  a.save!(validate: false)
  MyimmsTransaction.create(transaction_id: i,status: ["0","1","96","97","98","99"].shuffle.first) rescue nil
  XqccPool.create(transaction_id: i)
  XrayPendingReview.create(transaction_id:i)
end

puts "created XqccPool"
# Transaction.ids.each {|i|  MyimmsTransaction.create(transaction_id: i,status: ["0","1","96","97","98","99"].shuffle.first)}






malaysia_cities_by_state = {"Johor"=>["Johor Bahru", "Batu Pahat", "Muar", "Kluang", "Segamat", "Pontian", "Kulai"], "Kedah"=>["Alor Setar", "Sungai Petani", "Kulim", "Langkawi", "Padang Terap"], "Kelantan"=>["Kota Bharu", "Kuala Krai", "Tumpat", "Pengkalan Chepa"], "Kuala Lumpur"=>["Kuala Lumpur"], "Labuan"=>["Labuan"], "Melaka"=>["Malacca", "Ayer Keroh"], "Negeri Sembilan"=>["Seremban", "Port Dickson", "Nilai"], "Pahang"=>["Kuantan", "Temerloh", "Bentong", "Mentakab", "Raub", "Jerantut"], "Penang"=>["George Town", "Butterworth", "Seberang Perai"], "Perak"=>["Ipoh", "Taiping", "Sitiawan", "Teluk Intan", "Lumut", "Kampar"], "Perlis"=>["Kangar"], "Putrajaya"=>["Putrajaya"], "Sabah"=>["Kota Kinabalu", "Sandakan", "Tawau", "Lahad Datu", "Keningau", "Donggongon"], "Sarawak"=>["Kuching", "Miri", "Sibu", "Bintulu", "Kapit"], "Selangor"=>["Shah Alam", "Petaling Jaya", "Subang Jaya", "Klang", "Selayang", "Sungai Buloh"], "Terengganu"=>["Kuala Terengganu", "Kemaman", "Dungun", "Marang"]} 


malaysia_cities_by_state.keys.each_with_index do |index,val|
  State.find_or_create(val+1).update(name: index)
end 

malaysia_cities_by_state.keys.each do |i|
  malaysia_cities_by_state[i].each do |town|
    Town.create(state_id: State.find_by_name(i).id,name:town,code:rand(1000..4934))
  end 
end 

#create user
10.times do 
User.create!(email:Faker::Internet.email,name: Faker::Name.name,designation: Faker::Job.title)
end


#approval request creation
100.times do |count|
  ApprovalRequest.create(
    requested_at: Date.today - count.day,
    approved_at: Date.today - (count+2).day,
    category: Faker::Lorem.word,
    approval_decision: Faker::Lorem.word,
    approval_user_id: rand(1..10),
    approval2_decision: Faker::Lorem.word,
    approval2_user_id: rand(1..10)
  )
end


#approval request creation
100.times do |count|
  FwChangeEmployer.create(
    requested_at: Date.today - count.day,
    approval_at: Date.today - (count+2).day
  )
end

#xray_review creation
Transaction.ids.each do |i|
  XrayReview.create(created_at: Transaction.find(i).certification_date + rand(1..10).days)
end 

xray_review_ids = XrayReview.ids 
Transaction.find_each do |t|
  t.update(xray_review_id: xray_review_ids.sample)
end 



pcr_review_ids = PcrReview.ids 
Transaction.find_each do |t|
  t.update(pcr_review_id: pcr_review_ids.sample)
end 


# update pending_review model

xray_pending_review_ids = XrayPendingReview.ids 
Transaction.find_each do |t|
  t.update(xray_pending_review_id: xray_pending_review_ids.sample)
end 

# update pending_Decision model
Transaction.find_each do |i|
  XrayPendingDecision.create(transaction_id: i.id)
end