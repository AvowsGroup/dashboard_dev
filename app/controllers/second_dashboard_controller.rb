class SecondDashboardController < ApplicationController
  def index
    index_data
  end
  
  def index_test 
    index_data
  end 
  
  def towns
    id = JSON.parse( params.keys.first)["id"]
    state = State.find_by_id(id) rescue nil
    @towns = state.nil? ? Town.pluck(:name) : state.towns.pluck(:name,:id) 
  end 
  
  def filter
    params = JSON.parse( params.keys.first)
  end

  private
    def index_data
      if request.format.js? 
        filter JSON.parse( params.keys.first)
      else
        @employer_count = Employer.count
        @doctor_count = Doctor.count
        @states_count = State.count
        @xray_facility_count = XrayFacility.count
        @xray_count = Laboratory.count
        @fw_worker = Transaction.count
      end
      @states = State.pluck(:id,:name)
      @towns = Town.pluck(:name,:id)
    end

    def filter filter_params
      if filter_params["state"] == "All" || filter_params["state"] == "Select State"
        @doctor_count = Doctor.count
        @states_count = State.count
        @xray_facility_count = XrayFacility.count
        @xray_count = Laboratory.count
        @fw_worker = Transaction.where("final_result_date = ?",Date.today).count
        @employer_count = Employer.count
      else
        filter_params["district"] = nil if filter_params["district"] == "Select District"
        filter_params["district"] = Town.ids if filter_params["district"] == "All"
        @doctor = Doctor.where("state_id = ? OR town_id = ?",filter_params["state"],filter_params["district"])
        @doctor_count = @doctor.count

        unless filter_params["dateRange"].nil?
          start_date_str, end_date_str = filter_params["dateRange"].split(' - ')
          # Parse the start_date and end_date as Date objects
          start_date = Date.strptime(start_date_str, '%d/%m/%Y')
          end_date = Date.strptime(end_date_str, '%d/%m/%Y')
          @fw_worker = @doctor.map{|i| i.transactions.where(transactions: {final_result_date: start_date..end_date}).count}.sum 
        else
          @fw_worker = @doctor.map{|i| i.transactions.where(transactions: {final_result_date: Date.new(Date.today.year, 1, 1)..Date.today}).count}.sum 
        end 
  
        @xray_facility_count = XrayFacility.where("state_id = ? OR town_id = ?",filter_params["state"],filter_params["district"]).count
        @xray_count = Laboratory.where("state_id = ? OR town_id = ?",filter_params["state"],filter_params["district"]).count
        @employer_count = Employer.where("state_id = ? OR town_id = ?",filter_params["state"],filter_params["district"]).count
        @states_count = State.where(id: filter_params["state"]).count
      end 
    end 
    
 

  # def data
  #   @doctors=Doctor.where(status:'ACTIVE')
  #   @xray=XrayFacility.where(status:'ACTIVE')
  #   @laboratories=Laboratory.where(status:'ACTIVE')
  #   # @employer=Employer.where(status:'ACTIVE')
  #   @current_year = Date.today.year
  #   @transactions = Transaction.where("extract(year from created_at) = ?", @current_year)
  #   @foreignworkers=ForeignWorker.where(status:"ACTIVE") 
  #   @states=State.count
  #   if @doctors.present?
  #    @tot_no_of_doctors=@doctors.joins(:state).joins(:town).count.to_a   
  #   end
    
  #   if @xray.present?
  #    @tot_no_of_xray=@xray.joins(:state).joins(:town).count.to_a
  #   end
    
  #   if@laboratories.present?
  #     @tot_no_of_lab=@laboratories.join(:state).joins(:town).count.to_a
  #   end
    
  #   # if@employer.present?
  #   #   @tot_no_of_employer=@employer.joins(:state).joins(@transactions).joins(:town).count.to_a
  #   # end
    
  #   if @foreignworkers.present?
  #     @tot_no_of_foreignworker=@foreignworkers.joins(@transactions).joins(:doctor).joins(:state).joins(:town).count.to_a    
  #   end
    
  #   # if request.format.js? && params[:value].nil?
  #   #   @filters = JSON.parse(params.keys.first)
  #   #   @filters = convert_values_to_arrays(@filters)
    
  #   #   #calling filter from here 
  #   #   @filtersdata = apply_filter(@filters)  
       
  #   #   if @transactions.present?
  #   #       @tot_no_of_doctors=@doctors.joins(:state).joins(:town).where(state_id:@filtersdata.states,town_id:@filtersdata.towns).count.to_a 
  #   #       @tot_no_of_xray=@xray.joins(:state).joins(:town).where(state_id:@filtersdata.states,town_id:@filtersdata.towns).count.to_a
  #   #       @tot_no_of_lab=@laboratories.join(:state).joins(:town).where(state_id:@filtersdata.states,town_id:@filtersdata.towns).count.to_a
  #   #       @tot_no_of_employer=@employer.joins(:state).joins(@transactions).joins(:town).where(state_id:@filtersdata.states,town_id:@filtersdata.towns).count.to_a
  #   #       @tot_no_of_foreignworker=@foreignworkers.joins(@transactions).joins(:doctor).joins(:state).joins(:town).where(state_id:@filtersdata.states,town_id:@filtersdata.towns).count.to_a    
  #   #   end
  #   # end
  # end 
end
