class SecondDashboardController < ApplicationController
 def index
    index_data
    
  end
  
  def index_test 
    index_data
  end 
  
  def towns
    
    id = JSON.parse( params.keys.first)["id"]
    state = State.where('name=?',id).pluck(:id) rescue nil
    
    @towns = Town.where("state_id=?",state).pluck(:name,:id)
  end 
  
  def filter
    params = JSON.parse( params.keys.first)
  end

  
    def index_data
      if request.format.js? 
         if(params.values.first!=nil)
           district JSON.parse(params.values.first)
         end
        #filter JSON.parse( params.keys.first)

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
    
    def district filter_params
      if(filter_params=="SABAH")
        @doctor_count=Doctor.joins(:state).where("states.name=?",filter_params).count
        @doctorxray_count=XrayFacility.joins(:state).where("states.name=?",filter_params).count
        @doctorlab_count=Laboratory.joins(:state).where("states.name=?",filter_params).count
        #@doctoremp_count=Employer.joins(:state).where("states.name=?",filter_params).count
        #@doctorfw_count=Transaction.joins(:doctor).joins(:state).where("states.name=?",filter_params).count
      end
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
  def statevalues
   
    foo = params[:districtname]
    @doctorsabah_count=Doctor.joins(:state).where("states.name=?",foo).count
    @doctorxray_count=XrayFacility.joins(:state).where("states.name=?",foo).count
    @doctorlab_count=Laboratory.joins(:state).where("states.name=?",foo).count
    @doctoremp_count=Employer.joins(:state).where("states.name=?",foo).count
    @doctorfw_count=ForeignWorker.joins(:state).where("states.name=?",foo).count
    @detectdiseaseoverall=Transaction.joins(:medical_examination_detail).joins(:medical_examination).joins(:doctor).joins(:doctor_examination_detail).all
    @detectdisease=Doctor.joins(@detectdiseaseoverall).joins(:state).where("states.name=?",foo).all
    @detectdiseasecommunicable=Doctor.joins(@detectdiseaseoverall).joins(:state).where("states.name=?",foo).all
    @dtectcommunicable=MedicalExaminationDetail.joins(@detectdiseasecommunicable).where("medical_examination_details.condition_id IN('3501','3502','3503','3504','3505','3506')").count
    @dtectnoncommunicable=MedicalExaminationDetail.joins(@detectdiseasecommunicable).where("medical_examination_details.condition_id IN('3507','3508','3509','3510','3511','3512','3514','3515','3516','3517','3518','3519','3520','3513')").count
    @dtectcommunicabletuber=MedicalExaminationDetail.joins(@detectdiseasecommunicable).where("medical_examination_details.condition_id IN('3501')").count
    @dtectcommunicablehepa=MedicalExaminationDetail.joins(@detectdiseasecommunicable).where("medical_examination_details.condition_id IN('3502')").count
    @dtectcommunicablesyphilis=MedicalExaminationDetail.joins(@detectdiseasecommunicable).where("medical_examination_details.condition_id IN('3503')").count
    @dtectcommunicablehiv=MedicalExaminationDetail.joins(@detectdiseasecommunicable).where("medical_examination_details.condition_id IN('3504')").count
    @dtectcommunicablemalaria=MedicalExaminationDetail.joins(@detectdiseasecommunicable).where("medical_examination_details.condition_id IN('3505')").count
    @dtectcommunicableleprosy=MedicalExaminationDetail.joins(@detectdiseasecommunicable).where("medical_examination_details.condition_id IN('3506')").count
    
    @dtectnoncommunicablepreg=MedicalExaminationDetail.joins(@detectdiseasecommunicable).where("medical_examination_details.condition_id IN('3507')").count
    @dtectnoncommunicableurine=MedicalExaminationDetail.joins(@detectdiseasecommunicable).where("medical_examination_details.condition_id IN('3508')").count
    @dtectnoncommunicablecannabis=MedicalExaminationDetail.joins(@detectdiseasecommunicable).where("medical_examination_details.condition_id IN('3509')").count
    @dtectnoncommunicableillness=MedicalExaminationDetail.joins(@detectdiseasecommunicable).where("medical_examination_details.condition_id IN('3510')").count
    @dtectnoncommunicableepilesy=MedicalExaminationDetail.joins(@detectdiseasecommunicable).where("medical_examination_details.condition_id IN('3511')").count
    @dtectnoncommunicablecancer=MedicalExaminationDetail.joins(@detectdiseasecommunicable).where("medical_examination_details.condition_id IN('3512')").count
    @dtectnoncommunicablehypertens=MedicalExaminationDetail.joins(@detectdiseasecommunicable).where("medical_examination_details.condition_id IN('3513')").count
    @dtectnoncommunicablediabetes=MedicalExaminationDetail.joins(@detectdiseasecommunicable).where("medical_examination_details.condition_id IN('3514')").count
    @dtectnoncommunicablekidney=MedicalExaminationDetail.joins(@detectdiseasecommunicable).where("medical_examination_details.condition_id IN('3515')").count
    @dtectnoncommunicableheart=MedicalExaminationDetail.joins(@detectdiseasecommunicable).where("medical_examination_details.condition_id IN('3516')").count
    @dtectnoncommunicableulcer=MedicalExaminationDetail.joins(@detectdiseasecommunicable).where("medical_examination_details.condition_id IN('3517')").count
    @dtectnoncommunicableasthama=MedicalExaminationDetail.joins(@detectdiseasecommunicable).where("medical_examination_details.condition_id IN('3518')").count
    @dtectnoncommunicableothers=MedicalExaminationDetail.joins(@detectdiseasecommunicable).where("medical_examination_details.condition_id IN('3519')").count
       


    
    render json:{"noofdoctors":@doctorsabah_count,"noofxray":@doctorxray_count,"nooflab":@doctorlab_count,"empcount":@doctoremp_count,"fwcount":@doctorfw_count,"detectdisease":@detectdisease,"commcount":@dtectcommunicable,"noncommcount":@dtectnoncommunicable,"tuberculosis":@dtectcommunicabletuber,"hepatisis":@dtectcommunicablehepa,"syphilis":@dtectcommunicablesyphilis,"hiv":@dtectcommunicablehiv,"malaria":@dtectcommunicablemalaria,"leporacy":@dtectcommunicableleprosy,"pregnancy":@dtectnoncommunicablepreg,"urine":@dtectnoncommunicableurine,"cannabis":@dtectnoncommunicablecannabis,"illness":@dtectnoncommunicableillness,"epilsey":@dtectnoncommunicableepilesy,"cancer":@dtectnoncommunicablecancer,"hypertension":@dtectnoncommunicablehypertens,"diabetes":@dtectnoncommunicablediabetes,"kidney":@dtectnoncommunicablediabetes,"heart":@dtectnoncommunicableheart,"ulcer":@dtectnoncommunicableulcer,"asthama":@dtectnoncommunicableasthama,"others":@dtectnoncommunicableothers}
  end
  def districtvalues
     foo = params[:districtvalue]
    @doctorsabah_count=Doctor.joins(:town).where("towns.name=?",foo).count
    @doctorxray_count=XrayFacility.joins(:town).where("towns.name=?",foo).count
    @doctorlab_count=Laboratory.joins(:town).where("towns.name=?",foo).count
    @doctoremp_count=Employer.joins(:town).where("towns.name=?",foo).count
    @doctorfw_count=ForeignWorker.joins(:town).where("towns.name=?",foo).count
    @detectdiseaseoverall=Transaction.joins(:medical_examination_detail).joins(:medical_examination).joins(:doctor).joins(:doctor_examination_detail).all
    @detectdisease=Doctor.joins(@detectdiseaseoverall).joins(:town).where("towns.name=?",foo).count
    @detectdiseasecommunicable=Doctor.joins(@detectdiseaseoverall).joins(:state).where("states.name=?",foo).all
    @dtectcommunicable=MedicalExaminationDetail.joins(@detectdiseasecommunicable).where("medical_examination_details.condition_id IN('3501','3502','3503','3504','3505','3506')").count
    @dtectnoncommunicable=MedicalExaminationDetail.joins(@detectdiseasecommunicable).where("medical_examination_details.condition_id IN('3507','3508','3509','3510','3511','3512','3514','3515','3516','3517','3518','3519','3520','3513')").count
    
    @dtectcommunicabletuber=MedicalExaminationDetail.joins(@detectdiseasecommunicable).where("medical_examination_details.condition_id IN('3501')").count
    @dtectcommunicablehepa=MedicalExaminationDetail.joins(@detectdiseasecommunicable).where("medical_examination_details.condition_id IN('3502')").count
    @dtectcommunicablesyphilis=MedicalExaminationDetail.joins(@detectdiseasecommunicable).where("medical_examination_details.condition_id IN('3503')").count
    @dtectcommunicablehiv=MedicalExaminationDetail.joins(@detectdiseasecommunicable).where("medical_examination_details.condition_id IN('3504')").count
    @dtectcommunicablemalaria=MedicalExaminationDetail.joins(@detectdiseasecommunicable).where("medical_examination_details.condition_id IN('3505')").count
    @dtectcommunicableleprosy=MedicalExaminationDetail.joins(@detectdiseasecommunicable).where("medical_examination_details.condition_id IN('3506')").count
    
    @dtectnoncommunicablepreg=MedicalExaminationDetail.joins(@detectdiseasecommunicable).where("medical_examination_details.condition_id IN('3507')").count
    @dtectnoncommunicableurine=MedicalExaminationDetail.joins(@detectdiseasecommunicable).where("medical_examination_details.condition_id IN('3508')").count
    @dtectnoncommunicablecannabis=MedicalExaminationDetail.joins(@detectdiseasecommunicable).where("medical_examination_details.condition_id IN('3509')").count
    @dtectnoncommunicableillness=MedicalExaminationDetail.joins(@detectdiseasecommunicable).where("medical_examination_details.condition_id IN('3510')").count
    @dtectnoncommunicableepilesy=MedicalExaminationDetail.joins(@detectdiseasecommunicable).where("medical_examination_details.condition_id IN('3511')").count
    @dtectnoncommunicablecancer=MedicalExaminationDetail.joins(@detectdiseasecommunicable).where("medical_examination_details.condition_id IN('3512')").count
    @dtectnoncommunicablehypertens=MedicalExaminationDetail.joins(@detectdiseasecommunicable).where("medical_examination_details.condition_id IN('3513')").count
    @dtectnoncommunicablediabetes=MedicalExaminationDetail.joins(@detectdiseasecommunicable).where("medical_examination_details.condition_id IN('3514')").count
    @dtectnoncommunicablekidney=MedicalExaminationDetail.joins(@detectdiseasecommunicable).where("medical_examination_details.condition_id IN('3515')").count
    @dtectnoncommunicableheart=MedicalExaminationDetail.joins(@detectdiseasecommunicable).where("medical_examination_details.condition_id IN('3516')").count
    @dtectnoncommunicableulcer=MedicalExaminationDetail.joins(@detectdiseasecommunicable).where("medical_examination_details.condition_id IN('3517')").count
    @dtectnoncommunicableasthama=MedicalExaminationDetail.joins(@detectdiseasecommunicable).where("medical_examination_details.condition_id IN('3518')").count
    @dtectnoncommunicableothers=MedicalExaminationDetail.joins(@detectdiseasecommunicable).where("medical_examination_details.condition_id IN('3519')").count
       

    render json:{"noofdoctors":@doctorsabah_count,"noofxray":@doctorxray_count,"nooflab":@doctorlab_count,"empcount":@doctoremp_count,"fwcount":@doctorfw_count,"detectdisease":@detectdisease,"commcount":@dtectcommunicable,"noncommcount":@dtectnoncommunicable,"tuberculosis":@dtectcommunicabletuber,"hepatisis":@dtectcommunicablehepa,"syphilis":@dtectcommunicablesyphilis,"hiv":@dtectcommunicablehiv,"malaria":@dtectcommunicablemalaria,"leporacy":@dtectcommunicableleprosy,"pregnancy":@dtectnoncommunicablepreg,"urine":@dtectnoncommunicableurine,"cannabis":@dtectnoncommunicablecannabis,"illness":@dtectnoncommunicableillness,"epilsey":@dtectnoncommunicableepilesy,"cancer":@dtectnoncommunicablecancer,"hypertension":@dtectnoncommunicablehypertens,"diabetes":@dtectnoncommunicablediabetes,"kidney":@dtectnoncommunicablediabetes,"heart":@dtectnoncommunicableheart,"ulcer":@dtectnoncommunicableulcer,"asthama":@dtectnoncommunicableasthama,"others":@dtectnoncommunicableothers}
  end
end
