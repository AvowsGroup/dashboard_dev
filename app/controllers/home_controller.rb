class HomeController < ApplicationController

  def index
    @doctors=Doctor.where(status:'ACTIVE')
    @xray=XrayFacility.where(status:'ACTIVE')
    @laboratories=Laboratory.where(status:'ACTIVE')
    # @employer=Employer.where(status:'ACTIVE')
    @current_year = Date.today.year
    @transactions = Transaction.where("extract(year from created_at) = ?", @current_year)
    @foreignworkers=ForeignWorker.where(status:"ACTIVE") 
    @states=State.count
    if @doctors.present?
     @tot_no_of_doctors=@doctors.joins(:state).joins(:town).count.to_a   
    end
    if @xray.present?
     @tot_no_of_xray=@xray.joins(:state).joins(:town).count.to_a
    end
    if@laboratories.present?
      @tot_no_of_lab=@laboratories.join(:state).joins(:town).count.to_a
    end
    if@employer.present?
      @tot_no_of_employer=@employer.joins(:state).joins(@transactions).joins(:town).count.to_a
    end
    if @foreignworkers.present?
      @tot_no_of_foreignworker=@foreignworkers.joins(@transactions).joins(:doctor).joins(:state).joins(:town).count.to_a    
    end
  if request.format.js? && params[:value].nil?
      @filters = JSON.parse(params.keys.first)
      @filters = convert_values_to_arrays(@filters)
    
      #calling filter from here 
      @filtersdata = apply_filter(@filters)  
       
      if @transactions.present?
          @tot_no_of_doctors=@doctors.joins(:state).joins(:town).where(state_id:@filtersdata.states,town_id:@filtersdata.towns).count.to_a 
          @tot_no_of_xray=@xray.joins(:state).joins(:town).where(state_id:@filtersdata.states,town_id:@filtersdata.towns).count.to_a
          @tot_no_of_lab=@laboratories.join(:state).joins(:town).where(state_id:@filtersdata.states,town_id:@filtersdata.towns).count.to_a
          @tot_no_of_employer=@employer.joins(:state).joins(@transactions).joins(:town).where(state_id:@filtersdata.states,town_id:@filtersdata.towns).count.to_a
          @tot_no_of_foreignworker=@foreignworkers.joins(@transactions).joins(:doctor).joins(:state).joins(:town).where(state_id:@filtersdata.states,town_id:@filtersdata.towns).count.to_a    
      end
  end
  def convert_values_to_arrays(hash)
    converted_hash = {}

    hash.each_with_index do |(key, value), index|
      if index == 0
        converted_hash[key] = value
      else
        converted_hash[key] = value.split(' ')
      end
    end

    converted_hash
  end
    def apply_filter(filter_params)
      states=State.all
      towns=Town.all
     filter_params.each do |param_key, param_value|
      case param_key
      when "State"
        if param_value.present?
          states = State.where(code: param_value).pluck(:id)         
        end
        when "Town"
        if param_value.present?
          towns = Town.where(name: param_value).pluck(:id)
        end
    end

end
end
    end
    
  
def cities
 render json: Town.where(state_id:params[:state_id])
end
end