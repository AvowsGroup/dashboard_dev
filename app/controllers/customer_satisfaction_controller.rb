class CustomerSatisfactionController < ApplicationController
  def index
     @job_type = SurveyMonkeyCustomer.pluck(:which_sector_below_represents).uniq
    @gendermale = SurveyMonkeyCustomer.where(what_is_your_gender: 'Male').pluck(:what_is_your_gender).count
    @genderfemale = SurveyMonkeyCustomer.where(what_is_your_gender: 'Female').pluck(:what_is_your_gender).count
    @individual = SurveyMonkeyCustomer.where(what_is_customer_suits_you: 'Individual Employer').pluck(:what_is_customer_suits_you).count
    @customer_type = SurveyMonkeyCustomer.pluck(:what_is_customer_suits_you).uniq
    @registrationmedium = SurveyMonkeyCustomer.pluck(:where_did_you_register_your_worker).uniq
    @company = SurveyMonkeyCustomer.where(what_is_customer_suits_you: 'Company Employer').pluck(:what_is_customer_suits_you).count
    @agent = SurveyMonkeyCustomer.where(what_is_customer_suits_you: 'Agent').pluck(:what_is_customer_suits_you).count
    #@pi_chart_data = [['Task', 'Hours per Day']]
    
    #@linechart_data= Transaction.joins(:job_type).group('job_types.name').count.to_a
    @respondentsagegroup1824 = SurveyMonkeyCustomer.where(what_is_your_age: '18-24').pluck(:what_is_your_age).count

    @respondentsagegroup2534 = SurveyMonkeyCustomer.where(what_is_your_age: '25-34').pluck(:what_is_your_age).count
    @respondentsagegroup3544 = SurveyMonkeyCustomer.where(what_is_your_age: '35-44').pluck(:what_is_your_age).count
    @respondentsagegroup4554 = SurveyMonkeyCustomer.where(what_is_your_age: '45-54').pluck(:what_is_your_age).count
    @respondentsagegroup5565 = SurveyMonkeyCustomer.where(what_is_your_age: '55-65').pluck(:what_is_your_age).count
    @respondentsagegroupmore65 = SurveyMonkeyCustomer.where(what_is_your_age: 'More than 65').pluck(:what_is_your_age).count
    @webportal = SurveyMonkeyCustomer.where(where_did_you_register_your_worker: 'Web Portal').pluck(:where_did_you_register_your_worker).count
    @Rooffice = SurveyMonkeyCustomer.where(where_did_you_register_your_worker: 'Regional Office').pluck(:where_did_you_register_your_worker).count

    @facebook = SurveyMonkeyCustomer.where(facebook: 'Facebook').pluck(:facebook).count
    @twitter = SurveyMonkeyCustomer.where(twitter: 'Twitter').pluck(:twitter).count
    @instagram = SurveyMonkeyCustomer.where(instagram: 'Instagram').pluck(:instagram).count
    @telegram = SurveyMonkeyCustomer.where(telegram: 'Telegram').pluck(:telegram).count
    @OtherSM = SurveyMonkeyCustomer.where("other_social !=''").pluck(:other_social).count

    @operatingsocial = SurveyMonkeyCustomer.where(announcement_business_operator: 'Yes').pluck(:announcement_business_operator).count
    @operatingsocialNo = SurveyMonkeyCustomer.where(announcement_business_operator: 'No').pluck(:announcement_business_operator).count
    @health_awareness = SurveyMonkeyCustomer.where(delivering_health: 'Yes').pluck(:delivering_health).count
    @health_awarenessNo = SurveyMonkeyCustomer.where(delivering_health: 'No').pluck(:delivering_health).count
    @moh_moha = SurveyMonkeyCustomer.where(aligned_info_moh_MOHA: 'Yes').pluck(:aligned_info_moh_MOHA).count
    @moh_mohaNo = SurveyMonkeyCustomer.where(aligned_info_moh_MOHA: 'No').pluck(:aligned_info_moh_MOHA).count

    @panelclinic1 = SurveyMonkeyCustomer.where("location_panel_clinics=?", '1').count
    @panelclinic2 = SurveyMonkeyCustomer.where("location_panel_clinics=?", '2').count
    @panelclinic3 = SurveyMonkeyCustomer.where("location_panel_clinics=?", '3').count
    @panelclinic4 = SurveyMonkeyCustomer.where("location_panel_clinics=?", '4').count
    @panelclinic5 = SurveyMonkeyCustomer.where("location_panel_clinics=?", '5').count

    @panelclinic1all = (@panelclinic1 * 1) + (@panelclinic2 * 2) + (@panelclinic3 * 3) + (@panelclinic4 * 4) + (@panelclinic5 * 5)
    @panelclinic1count = @panelclinic1 + @panelclinic2 + @panelclinic3 + @panelclinic4 + @panelclinic5
    if (@panelclinic1all > 0)
      @panelclinics = (@panelclinic1all.to_f / @panelclinic1count).round(1)
    else
      @panelclinics = 0
    end

    @understantable1 = SurveyMonkeyCustomer.where('"Fomema_medical_examincation_are_understandable"=?', '1').count
    @understantable2 = SurveyMonkeyCustomer.where('"Fomema_medical_examincation_are_understandable"=?', '2').count
    @understantable3 = SurveyMonkeyCustomer.where('"Fomema_medical_examincation_are_understandable"=?', '3').count
    @understantable4 = SurveyMonkeyCustomer.where('"Fomema_medical_examincation_are_understandable"=?', '4').count
    @understantable5 = SurveyMonkeyCustomer.where('"Fomema_medical_examincation_are_understandable"=?', '5').count

    @understantableall = (@understantable1 * 1) + (@understantable2 * 2) + (@understantable3 * 3) + (@understantable4 * 4) + (@understantable5 * 5)
    @understantablecount = @understantable1 + @understantable2 + @understantable3 + @understantable4 + @understantable5
    if (@understantableall > 0)
      @understantable = (@understantableall.to_f / @understantablecount).round(1)
    else
      @understantable = 0
    end

    @obtainable1 = SurveyMonkeyCustomer.where("'medical_Examinations_are_easy_toobtain'=?", '1').count
    @obtainable2 = SurveyMonkeyCustomer.where("'medical_Examinations_are_easy_toobtain'=?", '2').count
    @obtainable3 = SurveyMonkeyCustomer.where("'medical_Examinations_are_easy_toobtain'=?", '3').count
    @obtainable4 = SurveyMonkeyCustomer.where("'medical_Examinations_are_easy_toobtain'=?", '4').count
    @obtainable5 = SurveyMonkeyCustomer.where("'medical_Examinations_are_easy_toobtain'=?", '5').count

    @obtainableall = (@obtainable1 * 1) + (@obtainable2 * 2) + (@obtainable3 * 3) + (@obtainable4 * 4) + (@obtainable5 * 5)
    @obtainablecount = @obtainable1 + @obtainable2 + @obtainable3 + @obtainable4 + @obtainable5
    if (@obtainableall > 0)
      @obtainable = (@obtainableall.to_f / @obtainablecount).round(1)
    else
      @obtainable = 0
    end

    @overallexp1 = SurveyMonkeyCustomer.where("'Overall_rate_experience_medical_examination'=?", '1').count
    @overallexp2 = SurveyMonkeyCustomer.where("'Overall_rate_experience_medical_examination'=?", '2').count
    @overallexp3 = SurveyMonkeyCustomer.where("'Overall_rate_experience_medical_examination'=?", '3').count
    @overallexp4 = SurveyMonkeyCustomer.where("'Overall_rate_experience_medical_examination'=?", '4').count
    @overallexp5 = SurveyMonkeyCustomer.where("'Overall_rate_experience_medical_examination'=?", '5').count

    @overallexpall = (@overallexp1 * 1) + (@overallexp2 * 2) + (@overallexp3 * 3) + (@overallexp4 * 4) + (@overallexp5 * 5)
    @overallexpcount = @overallexp1 + @overallexp2 + @overallexp3 + @overallexp4 + @overallexp5
    if (@overallexpall > 0)
      @overallexp = (@overallexpall.to_f / @overallexpcount).round(1)
    else
      @overallexp = 0
    end

    #@panelclinics=SurveyMonkeyCustomer.pluck(:location_panel_clinics).count
    #@understantable=SurveyMonkeyCustomer.pluck(:Fomema_medical_examincation_are_understandable).count
    #@obtainable=SurveyMonkeyCustomer.pluck(:medical_Examinations_are_easy_toobtain).count
    #@overallexp=SurveyMonkeyCustomer.pluck(:Overall_rate_experience_medical_examination).count

    @transaction_line_chart = SurveyMonkeyCustomer.transaction_data_1_year
    @appealworkerstatus = SurveyMonkeyCustomer.where(worker_status_found_medical_unsuitable: 'Yes').pluck(:worker_status_found_medical_unsuitable).count
    @appealworkerstatusNo = SurveyMonkeyCustomer.where(worker_status_found_medical_unsuitable: 'No').pluck(:worker_status_found_medical_unsuitable).count
    @appealundergostatus = SurveyMonkeyCustomer.where(undergo_fomema_appeal_process: 'Yes').pluck(:undergo_fomema_appeal_process).count
    @appealundergostatusNo = SurveyMonkeyCustomer.where(undergo_fomema_appeal_process: 'No').pluck(:undergo_fomema_appeal_process).count
    @appealoverall1 = SurveyMonkeyCustomer.where(tell_experience_appeal_process: '1').pluck(:tell_experience_appeal_process).count
    @appealoverall2 = SurveyMonkeyCustomer.where(tell_experience_appeal_process: '2').pluck(:tell_experience_appeal_process).count
    @appealoverall3 = SurveyMonkeyCustomer.where(tell_experience_appeal_process: '3').pluck(:tell_experience_appeal_process).count
    @appealoverall4 = SurveyMonkeyCustomer.where(tell_experience_appeal_process: '4').pluck(:tell_experience_appeal_process).count
    @appealoverall5 = SurveyMonkeyCustomer.where(tell_experience_appeal_process: '5').pluck(:tell_experience_appeal_process).count
    @appealoverall = (@appealoverall1 * 1) + (@appealoverall2 * 2) + (@appealoverall3 * 3) + (@appealoverall4 * 4) + (@appealoverall5 * 5)
    @appealoverallcount = @appealoverall1 + @appealoverall2 + @appealoverall3 + @appealoverall4 + @appealoverall5
    if (@appealoverallcount > 0)
      @appealoverallsum = (@appealoverall.to_f / @appealoverallcount).round(1)
    else
      @appealoverallsum = 0
    end
    # employee reg webportal and reg office
    @employeeregweb1 = SurveyMonkeyCustomer.where("process_emp_reg=? and where_did_you_register_your_worker=?", '1', 'Web Portal').count
    @employeeregweb2 = SurveyMonkeyCustomer.where("process_emp_reg=? and where_did_you_register_your_worker=?", '2', 'Web Portal').count
    @employeeregweb3 = SurveyMonkeyCustomer.where("process_emp_reg=? and where_did_you_register_your_worker=?", '3', 'Web Portal').count
    @employeeregweb4 = SurveyMonkeyCustomer.where("process_emp_reg=? and where_did_you_register_your_worker=?", '4', 'Web Portal').count
    @employeeregweb5 = SurveyMonkeyCustomer.where("process_emp_reg=? and where_did_you_register_your_worker=?", '5', 'Web Portal').count

    @employeeregweball = (@employeeregweb1 * 1) + (@employeeregweb2 * 2) + (@employeeregweb3 * 3) + (@employeeregweb4 * 4) + (@employeeregweb5 * 5)
    @employeeregweballcount = @employeeregweb1 + @employeeregweb2 + @employeeregweb3 + @employeeregweb4 + @employeeregweb5
    if (@employeeregweballcount > 0)
      @employeeregweballsum = (@employeeregweball.to_f / @employeeregweballcount).round(1)
    else
      @employeeregweballsum = 0
    end
    @employeeregreg1 = SurveyMonkeyCustomer.where("process_emp_reg=? and where_did_you_register_your_worker=?", '1', 'Regional Office').count
    @employeeregreg2 = SurveyMonkeyCustomer.where("process_emp_reg=? and where_did_you_register_your_worker=?", '2', 'Regional Office').count
    @employeeregreg3 = SurveyMonkeyCustomer.where("process_emp_reg=? and where_did_you_register_your_worker=?", '3', 'Regional Office').count
    @employeeregreg4 = SurveyMonkeyCustomer.where("process_emp_reg=? and where_did_you_register_your_worker=?", '4', 'Regional Office').count
    @employeeregreg5 = SurveyMonkeyCustomer.where("process_emp_reg=? and where_did_you_register_your_worker=?", '5', 'Regional Office').count

    @employeeregregall = (@employeeregreg1 * 1) + (@employeeregreg2 * 2) + (@employeeregreg3 * 3) + (@employeeregreg4 * 4) + (@employeeregreg5 * 5)
    @employeeregregcount = @employeeregreg1 + @employeeregreg2 + @employeeregreg3 + @employeeregreg4 + @employeeregreg5
    if (@employeeregregcount > 0)
      @employeeregregsum = (@employeeregregall.to_f / @employeeregregcount).round(1)
    else
      @employeeregregsum = 0
    end

    # worker reg webportal and reg office
    @workerregweb1 = SurveyMonkeyCustomer.where("process_worker_reg=? and where_did_you_register_your_worker=?", '1', 'Web Portal').count
    @workerregweb2 = SurveyMonkeyCustomer.where("process_worker_reg=? and where_did_you_register_your_worker=?", '2', 'Web Portal').count
    @workerregweb3 = SurveyMonkeyCustomer.where("process_worker_reg=? and where_did_you_register_your_worker=?", '3', 'Web Portal').count
    @workerregweb4 = SurveyMonkeyCustomer.where("process_worker_reg=? and where_did_you_register_your_worker=?", '4', 'Web Portal').count
    @workerregweb5 = SurveyMonkeyCustomer.where("process_worker_reg=? and where_did_you_register_your_worker=?", '5', 'Web Portal').count

    @workerregweball = (@workerregweb1 * 1) + (@workerregweb2 * 2) + (@workerregweb3 * 3) + (@workerregweb4 * 4) + (@workerregweb5 * 5)
    @workerregweballcount = @workerregweb1 + @workerregweb2 + @workerregweb3 + @workerregweb4 + @workerregweb5
    if (@workerregweballcount > 0)
      @workerregweballsum = (@workerregweball.to_f / @workerregweballcount).round(1)
    else
      @workerregweballsum = 0
    end
    @workerregreg1 = SurveyMonkeyCustomer.where("process_worker_reg=? and where_did_you_register_your_worker=?", '1', 'Regional Office').count
    @workerregreg2 = SurveyMonkeyCustomer.where("process_worker_reg=? and where_did_you_register_your_worker=?", '2', 'Regional Office').count
    @workerregreg3 = SurveyMonkeyCustomer.where("process_worker_reg=? and where_did_you_register_your_worker=?", '3', 'Regional Office').count
    @workerregreg4 = SurveyMonkeyCustomer.where("process_worker_reg=? and where_did_you_register_your_worker=?", '4', 'Regional Office').count
    @workerregreg5 = SurveyMonkeyCustomer.where("process_worker_reg=? and where_did_you_register_your_worker=?", '5', 'Regional Office').count

    @workerregregall = (@workerregreg1 * 1) + (@workerregreg2 * 2) + (@workerregreg3 * 3) + (@workerregreg4 * 4) + (@workerregreg5 * 5)
    @workerregregcount = @workerregreg1 + @workerregreg2 + @workerregreg3 + @workerregreg4 + @workerregreg5
    if (@workerregregcount > 0)
      @workerregregsum = (@workerregregall.to_f / @workerregregcount).round(1)
    else
      @workerregregsum = 0
    end

    # panel clinic reg webportal and reg office
    @panelregweb1 = SurveyMonkeyCustomer.where("panel_clinic_xray_facilities=? and where_did_you_register_your_worker=?", '1', 'Web Portal').count
    @panelregweb2 = SurveyMonkeyCustomer.where("panel_clinic_xray_facilities=? and where_did_you_register_your_worker=?", '2', 'Web Portal').count
    @panelregweb3 = SurveyMonkeyCustomer.where("panel_clinic_xray_facilities=? and where_did_you_register_your_worker=?", '3', 'Web Portal').count
    @panelregweb4 = SurveyMonkeyCustomer.where("panel_clinic_xray_facilities=? and where_did_you_register_your_worker=?", '4', 'Web Portal').count
    @panelregweb5 = SurveyMonkeyCustomer.where("panel_clinic_xray_facilities=? and where_did_you_register_your_worker=?", '5', 'Web Portal').count

    @panelregweball = (@panelregweb1 * 1) + (@panelregweb2 * 2) + (@panelregweb3 * 3) + (@panelregweb4 * 4) + (@panelregweb5 * 5)
    @panelregweballcount = @panelregweb1 + @panelregweb2 + @panelregweb3 + @panelregweb4 + @panelregweb5
    if (@panelregweballcount > 0)
      @panelregweballsum = (@panelregweball.to_f / @panelregweballcount).round(1)
    else
      @panelregweballsum = 0
    end

    @panelregreg1 = SurveyMonkeyCustomer.where("panel_clinic_xray_facilities=? and where_did_you_register_your_worker=?", '1', 'Regional Office').count
    @panelregreg2 = SurveyMonkeyCustomer.where("panel_clinic_xray_facilities=? and where_did_you_register_your_worker=?", '2', 'Regional Office').count
    @panelregreg3 = SurveyMonkeyCustomer.where("panel_clinic_xray_facilities=? and where_did_you_register_your_worker=?", '3', 'Regional Office').count
    @panelregreg4 = SurveyMonkeyCustomer.where("panel_clinic_xray_facilities=? and where_did_you_register_your_worker=?", '4', 'Regional Office').count
    @panelregreg5 = SurveyMonkeyCustomer.where("panel_clinic_xray_facilities=? and where_did_you_register_your_worker=?", '5', 'Regional Office').count

    @panelregregall = (@panelregreg1 * 1) + (@panelregreg2 * 2) + (@panelregreg3 * 3) + (@panelregreg4 * 4) + (@panelregreg5 * 5)
    @panelregregcount = @panelregreg1 + @panelregreg2 + @panelregreg3 + @panelregreg4 + @panelregreg5
    if (@panelregregcount > 0)
      @panelregregsum = (@panelregregall.to_f / @panelregregcount).round(1)
    else
      @panelregregsum = 0
    end

    # overall reg webportal and reg office
    @overallregweb1 = SurveyMonkeyCustomer.where("overall_experience_reg_process=? and where_did_you_register_your_worker=?", '1', 'Web Portal').count
    @overallregweb2 = SurveyMonkeyCustomer.where("overall_experience_reg_process=? and where_did_you_register_your_worker=?", '2', 'Web Portal').count
    @overallregweb3 = SurveyMonkeyCustomer.where("overall_experience_reg_process=? and where_did_you_register_your_worker=?", '3', 'Web Portal').count
    @overallregweb4 = SurveyMonkeyCustomer.where("overall_experience_reg_process=? and where_did_you_register_your_worker=?", '4', 'Web Portal').count
    @overallregweb5 = SurveyMonkeyCustomer.where("overall_experience_reg_process=? and where_did_you_register_your_worker=?", '5', 'Web Portal').count

    @overallregweball = (@overallregweb1 * 1) + (@overallregweb2 * 2) + (@overallregweb3 * 3) + (@overallregweb4 * 4) + (@overallregweb5 * 5)
    @overallregweballcount = @overallregweb1 + @overallregweb2 + @overallregweb3 + @overallregweb4 + @overallregweb5
    if (@overallregweballcount > 0)
      @overallregweballsum = (@overallregweball.to_f / @overallregweballcount).round(1)
    else
      @overallregweballsum = 0
    end

    @overallregreg1 = SurveyMonkeyCustomer.where("overall_experience_reg_process=? and where_did_you_register_your_worker=?", '1', 'Regional Office').count
    @overallregreg2 = SurveyMonkeyCustomer.where("overall_experience_reg_process=? and where_did_you_register_your_worker=?", '2', 'Regional Office').count
    @overallregreg3 = SurveyMonkeyCustomer.where("overall_experience_reg_process=? and where_did_you_register_your_worker=?", '3', 'Regional Office').count
    @overallregreg4 = SurveyMonkeyCustomer.where("overall_experience_reg_process=? and where_did_you_register_your_worker=?", '4', 'Regional Office').count
    @overallregreg5 = SurveyMonkeyCustomer.where("overall_experience_reg_process=? and where_did_you_register_your_worker=?", '5', 'Regional Office').count

    @overallregregall = (@overallregreg1 * 1) + (@overallregreg2 * 2) + (@overallregreg3 * 3) + (@overallregreg4 * 4) + (@overallregreg5 * 5)
    @overallregregcount = @overallregreg1 + @overallregreg2 + @overallregreg3 + @overallregreg4 + @overallregreg5
    if (@overallregregcount > 0)
      @overallregregsum = (@overallregregall.to_f / @overallregregcount).round(1)
    else
      @overallregregsum = 0
    end

    # NPS registration web portal
    @NPSregweb1 = SurveyMonkeyCustomer.where("process_emp_reg=? and process_worker_reg=? and panel_clinic_xray_facilities=? and overall_experience_reg_process=? and where_did_you_register_your_worker=?", '1', '1', '1', '1', 'Web Portal').count
    @NPSregweb2 = SurveyMonkeyCustomer.where("process_emp_reg=? and process_worker_reg=? and panel_clinic_xray_facilities=? and overall_experience_reg_process=? and where_did_you_register_your_worker=?", '2', '2', '2', '2', 'Web Portal').count
    @NPSregweb3 = SurveyMonkeyCustomer.where("process_emp_reg=? and process_worker_reg=? and panel_clinic_xray_facilities=? and overall_experience_reg_process=? and where_did_you_register_your_worker=?", '3', '3', '3', '3', 'Web Portal').count
    @NPSregweb4 = SurveyMonkeyCustomer.where("process_emp_reg=? and process_worker_reg=? and panel_clinic_xray_facilities=? and overall_experience_reg_process=? and where_did_you_register_your_worker=?", '4', '4', '4', '4', 'Web Portal').count
    @NPSregweb5 = SurveyMonkeyCustomer.where("process_emp_reg=? and process_worker_reg=? and panel_clinic_xray_facilities=? and overall_experience_reg_process=? and where_did_you_register_your_worker=?", '5', '5', '5', '5', 'Web Portal').count

    @NPSregweball = (@NPSregweb1 * 1) + (@NPSregweb2 * 2) + (@NPSregweb3 * 3) + (@NPSregweb4 * 4) + (@NPSregweb5 * 5)
    @NPSregwebpromoters = @NPSregweb4 + @NPSregweb5
    @NPSregwebdectoters = @NPSregweb1 + @NPSregweb2
    if (@NPSregweball > 0)
      @NPSwebpercentagepromoters = (@NPSregwebpromoters.to_f / @NPSregweball) * 100
      @NPSwebpercentagedectaters = (@NPSregwebdectoters.to_f  / @NPSregweball) * 100
      @NPSoverallpercentage = @NPSwebpercentagepromoters - @NPSwebpercentagedectaters
    else
      @NPSoverallpercentage = 0
    end
    # NPS registration regional office
    @NPSregreg1 = SurveyMonkeyCustomer.where("process_emp_reg=? and process_worker_reg=? and panel_clinic_xray_facilities=? and overall_experience_reg_process=? and where_did_you_register_your_worker=?", '1', '1', '1', '1', 'Regional Office').count
    @NPSregreg2 = SurveyMonkeyCustomer.where("process_emp_reg=? and process_worker_reg=? and panel_clinic_xray_facilities=? and overall_experience_reg_process=? and where_did_you_register_your_worker=?", '2', '2', '2', '2', 'Regional Office').count
    @NPSregreg3 = SurveyMonkeyCustomer.where("process_emp_reg=? and process_worker_reg=? and panel_clinic_xray_facilities=? and overall_experience_reg_process=? and where_did_you_register_your_worker=?", '3', '3', '3', '3', 'Regional Office').count
    @NPSregreg4 = SurveyMonkeyCustomer.where("process_emp_reg=? and process_worker_reg=? and panel_clinic_xray_facilities=? and overall_experience_reg_process=? and where_did_you_register_your_worker=?", '4', '4', '4', '4', 'Regional Office').count
    @NPSregreg5 = SurveyMonkeyCustomer.where("process_emp_reg=? and process_worker_reg=? and panel_clinic_xray_facilities=? and overall_experience_reg_process=? and where_did_you_register_your_worker=?", '5', '5', '5', '5', 'Regional Office').count

    @NPSregregall = (@NPSregreg1 * 1) + (@NPSregreg2 * 2) + (@NPSregreg3 * 3) + (@NPSregreg4 * 4) + (@NPSregreg5 * 5)
    @NPSregregpromoters = @NPSregreg4 + @NPSregreg5
    @NPSregregdectoters = @NPSregreg1 + @NPSregreg2
    if (@NPSregregall > 0)
      @NPSregpercentagepromoters = (@NPSregregpromoters.to_f / @NPSregregall) * 100
      @NPSregpercentagedectaters = (@NPSregregdectoters.to_f / @NPSregregall) * 100
      @NPSregoverallpercentage = @NPSregpercentagepromoters - @NPSregpercentagedectaters
    else
      @NPSregoverallpercentage = 0
    end
    # NPS Examination services
    @NPSExs1 = SurveyMonkeyCustomer.where("location_panel_clinics=? and 'Fomema_medical_examincation_are_understandable'=? and 'medical_Examinations_are_easy_toobtain'=? and 'Overall_rate_experience_medical_examination'=? ", '1', '1', '1', '1').count
    @NPSExs2 = SurveyMonkeyCustomer.where("location_panel_clinics=? and 'Fomema_medical_examincation_are_understandable'=? and 'medical_Examinations_are_easy_toobtain'=? and 'Overall_rate_experience_medical_examination'=? ", '2', '2', '2', '2').count
    @NPSExs3 = SurveyMonkeyCustomer.where("location_panel_clinics=? and 'Fomema_medical_examincation_are_understandable'=? and 'medical_Examinations_are_easy_toobtain'=? and 'Overall_rate_experience_medical_examination'=? ", '3', '3', '3', '3').count
    @NPSExs4 = SurveyMonkeyCustomer.where("location_panel_clinics=? and 'Fomema_medical_examincation_are_understandable'=? and 'medical_Examinations_are_easy_toobtain'=? and 'Overall_rate_experience_medical_examination'=? ", '4', '4', '4', '4').count
    @NPSExs5 = SurveyMonkeyCustomer.where("location_panel_clinics=? and 'Fomema_medical_examincation_are_understandable'=? and 'medical_Examinations_are_easy_toobtain'=? and 'Overall_rate_experience_medical_examination'=? ", '5', '5', '5', '5').count

    @NPSExsall = (@NPSExs1 * 1) + (@NPSExs2 * 2) + (@NPSExs3 * 3) + (@NPSExs4 * 4) + (@NPSExs5 * 5)
    @NPSExspromoters = @NPSExs4 + @NPSExs5
    @NPSExsdectoters = @NPSExs1 + @NPSExs2
    if (@NPSExsall > 0)
      @NPSExspercentagepromoters = (@NPSExspromoters.to_f / @NPSExsall) * 100
      @NPSExspercentagedectaters = (@NPSExsdectoters.to_f / @NPSExsall) * 100
      @NPSExsoverallpercentage = @NPSExspercentagepromoters - @NPSExspercentagedectaters
    else
      @NPSExsoverallpercentage = 0
    end

    # NPS appeal process
    @NPSappeal1 = SurveyMonkeyCustomer.where("tell_experience_appeal_process=?", '1').count
    @NPSappeal2 = SurveyMonkeyCustomer.where("tell_experience_appeal_process=?", '2').count
    @NPSappeal3 = SurveyMonkeyCustomer.where("tell_experience_appeal_process=?", '3').count
    @NPSappeal4 = SurveyMonkeyCustomer.where("tell_experience_appeal_process=?", '4').count
    @NPSappeal5 = SurveyMonkeyCustomer.where("tell_experience_appeal_process=?", '5').count

    @NPSappealall = (@NPSappeal1 * 1) + (@NPSappeal2 * 2) + (@NPSappeal3 * 3) + (@NPSappeal4 * 4) + (@NPSappeal5 * 5)
    @NPSappealpromoters = @NPSappeal4 + @NPSappeal5
    @NPSappealdectoters = @NPSappeal1 + @NPSappeal2
    if (@NPSappealall > 0)
      @NPSappealpercentagepromoters = (@NPSappealpromoters.to_f / @NPSappealall) * 100
      @NPSappealpercentagedectaters = (@NPSappealdectoters.to_f / @NPSappealall) * 100
      @NPSappealoverallpercentage = @NPSappealpercentagepromoters - @NPSappealpercentagedectaters
    else
      @NPSappealoverallpercentage = 0
    end

    # NPS Average services
    if (@NPSoverallpercentage > 0)
      @NpsAveragescore = (@NPSoverallpercentage + @NPSregoverallpercentage + @NPSExsoverallpercentage + @NPSExsoverallpercentage)
      @NPSavgscore = (@NpsAveragescore / 4).round(1)
    else
      @NPSavgscore = 0
    end

    if request.format.js? && params[:value].nil?
      @filters = JSON.parse(params.keys.first)
      @filters = convert_values_to_arrays(@filters)

      # calling filter from here
      @transactions = apply_filter(@filters)

      if @transactions.present?

        #@linechart_data = Transaction.joins(:job_type).group('job_types.name').where("job_types.name IN(?)",@transactions).count.to_a

      end
    else
    @current_year = Date.today.year
      @respondentsyear=SurveyMonkeyCustomer.where("extract(year from start_date) = ?", @current_year) 
      @linechart_data=SurveyMonkeyCustomer.group('which_sector_below_represents').count.to_a    end
  end

  def convert_values_to_arrays(hash)
    converted_hash = {}

    hash.each_with_index do |(key, value), index|
      if index == 0
        converted_hash[key] = value
      else
        converted_hash[key] = value.split(',')
      end
    end

    converted_hash
  end

  def apply_filter(filter_params)
    @transactions = Transaction.all
    @surveymonkeyfilter=SurveyMonkeyCustomer.all
      @current_year = Date.today.year
      @transaction_line_cahrt = SurveyMonkeyCustomer.transaction_data_1_year
      @respondentsyear=SurveyMonkeyCustomer.where("extract(year from start_date) = ?", @current_year) 
     @linechart_data = Transaction.joins(:job_type).group('job_types.name').count.to_a
    
    filter_params.each do |param_key, param_value|
      case param_key 
      when "DateRange"
          if param_value.present?
            start_date, end_date = param_value.split(" - ")
            @daterange=@surveymonkeyfilter.where("start_date>=? and start_date<=?",start_date,end_date)
            @respondentsagegroup1824=@daterange.where('what_is_your_age=?','18-24').all
            @respondentsagegroup2534=@daterange.where('what_is_your_age=?','25-34').all
             @respondentsagegroup3544=@daterange.where('what_is_your_age=?','35-44').all
            @respondentsagegroup4554=@daterange.where('what_is_your_age=?','45-54').all
            @respondentsagegroup5565=@daterange.where('what_is_your_age=?','55-65').all
            @respondentsagegroupmore65=@daterange.where('what_is_your_age=?','More than 65').all
            @webportal=@daterange.where('where_did_you_register_your_worker=?','Web Portal').all
            @Rooffice=@daterange.where('where_did_you_register_your_worker=?','Regional Office').all
            @gendermale=@daterange.where('what_is_your_gender=?','Male').all
            @genderfemale=@daterange.where('what_is_your_gender=?','Female').all
            @individual=@daterange.where('what_is_customer_suits_you=?','Individual Employer').all
            @company=@daterange.where('what_is_customer_suits_you=?','Company Employer').all
            @agent=@daterange.where('what_is_customer_suits_you=?','Agent').all
            @facebook=@daterange.where('facebook=?','Facebook').all
           @twitter=@daterange.where('twitter=?','Twitter').all
           @instagram=@daterange.where('instagram=?','Instagram').all
           @telegram=@daterange.where('telegram=?','Telegram').all
           @OtherSM=@daterange.where('other_social!=?','').all
          
           @operatingsocial=@daterange.where('announcement_business_operator=?','Yes').all
           @operatingsocialNo=@daterange.where('announcement_business_operator=?','No').all
           @health_awareness=@daterange.where('delivering_health=?','Yes').all
           @health_awarenessNo=@daterange.where('delivering_health=?','No').all
           @moh_moha=@daterange.where('"aligned_info_moh_MOHA"=?','Yes').all
           @moh_mohaNo=@daterange.where('"aligned_info_moh_MOHA"=?','No').all

           @employeeregweb1=@daterange.where("process_emp_reg=? and where_did_you_register_your_worker=? ", '1' ,'Web Portal').all
           @employeeregweb2=@daterange.where("process_emp_reg=? and where_did_you_register_your_worker=? ", '2' ,'Web Portal').all
           @employeeregweb3=@daterange.where("process_emp_reg=? and where_did_you_register_your_worker=? ", '3' ,'Web Portal').all
           @employeeregweb4=@daterange.where("process_emp_reg=? and where_did_you_register_your_worker=? ", '4' ,'Web Portal').all
           @employeeregweb5=@daterange.where("process_emp_reg=? and where_did_you_register_your_worker=? ", '5' ,'Web Portal').all

           @employeeregreg1=@daterange.where("process_emp_reg=? and where_did_you_register_your_worker=? ", '1' ,'Regional Office').all
           @employeeregreg2=@daterange.where("process_emp_reg=? and where_did_you_register_your_worker=? ", '2' ,'Regional Office').all
           @employeeregreg3=@daterange.where("process_emp_reg=? and where_did_you_register_your_worker=? ", '3' ,'Regional Office').all
           @employeeregreg4=@daterange.where("process_emp_reg=? and where_did_you_register_your_worker=? ", '4' ,'Regional Office').all
           @employeeregreg5=@daterange.where("process_emp_reg=? and where_did_you_register_your_worker=? ", '5' ,'Regional Office').all

           @workerregweb1=@daterange.where("process_worker_reg=? and where_did_you_register_your_worker=? ", '1' ,'Web Portal').all
           @workerregweb2=@daterange.where("process_worker_reg=? and where_did_you_register_your_worker=? ", '2' ,'Web Portal').all
           @workerregweb3=@daterange.where("process_worker_reg=? and where_did_you_register_your_worker=? ", '3' ,'Web Portal').all
           @workerregweb4=@daterange.where("process_worker_reg=? and where_did_you_register_your_worker=? ", '4' ,'Web Portal').all
           @workerregweb5=@daterange.where("process_worker_reg=? and where_did_you_register_your_worker=? ", '5' ,'Web Portal').all
          
            @workerregreg1=@daterange.where("process_worker_reg=? and where_did_you_register_your_worker=? ", '1' ,'Regional Office').all
           @workerregreg2=@daterange.where("process_worker_reg=? and where_did_you_register_your_worker=? ", '2' ,'Regional Office').all
           @workerregreg3=@daterange.where("process_worker_reg=? and where_did_you_register_your_worker=? ", '3' ,'Regional Office').all
           @workerregreg4=@daterange.where("process_worker_reg=? and where_did_you_register_your_worker=? ", '4' ,'Regional Office').all
           @workerregreg5=@daterange.where("process_worker_reg=? and where_did_you_register_your_worker=? ", '5' ,'Regional Office').all
 
            @panelregweb1=@daterange.where("panel_clinic_xray_facilities=? and where_did_you_register_your_worker=?", '1' ,'Web Portal').all
           @panelregweb2=@daterange.where("panel_clinic_xray_facilities=? and where_did_you_register_your_worker=? ", '2' ,'Web Portal').all
           @panelregweb3=@daterange.where("panel_clinic_xray_facilities=? and where_did_you_register_your_worker=? ", '3' ,'Web Portal').all
           @panelregweb4=@daterange.where("panel_clinic_xray_facilities=? and where_did_you_register_your_worker=? ", '4' ,'Web Portal').all
           @panelregweb5=@daterange.where("panel_clinic_xray_facilities=? and where_did_you_register_your_worker=? ", '5' ,'Web Portal').all
           
            @panelregreg1=@daterange.where("panel_clinic_xray_facilities=? and where_did_you_register_your_worker=? ", '1' ,'Regional Office').all
           @panelregreg2=@daterange.where("panel_clinic_xray_facilities=? and where_did_you_register_your_worker=? ", '2' ,'Regional Office').all
           @panelregreg3=@daterange.where("panel_clinic_xray_facilities=? and where_did_you_register_your_worker=? ", '3' ,'Regional Office').all
           @panelregreg4=@daterange.where("panel_clinic_xray_facilities=? and where_did_you_register_your_worker=? ", '4' ,'Regional Office').all
           @panelregreg5=@daterange.where("panel_clinic_xray_facilities=? and where_did_you_register_your_worker=? ", '5' ,'Regional Office').all
           
            @overallregweb1=@daterange.where("overall_experience_reg_process=? and where_did_you_register_your_worker=? ", '1' ,'Web Portal').all
           @overallregweb2=@daterange.where("overall_experience_reg_process=? and where_did_you_register_your_worker=? ", '2' ,'Web Portal').all
           @overallregweb3=@daterange.where("overall_experience_reg_process=? and where_did_you_register_your_worker=? ", '3' ,'Web Portal').all
           @overallregweb4=@daterange.where("overall_experience_reg_process=? and where_did_you_register_your_worker=? ", '4' ,'Web Portal').all
           @overallregweb5=@daterange.where("overall_experience_reg_process=? and where_did_you_register_your_worker=? ", '5' ,'Web Portal').all
          
           @overallregreg1=@daterange.where("overall_experience_reg_process=? and where_did_you_register_your_worker=? ", '1' ,'Regional Office').all
           @overallregreg2=@daterange.where("overall_experience_reg_process=? and where_did_you_register_your_worker=? ", '2' ,'Regional Office').all
           @overallregreg3=@daterange.where("overall_experience_reg_process=? and where_did_you_register_your_worker=? ", '3' ,'Regional Office').all
           @overallregreg4=@daterange.where("overall_experience_reg_process=? and where_did_you_register_your_worker=? ", '4' ,'Regional Office').all
           @overallregreg5=@daterange.where("overall_experience_reg_process=? and where_did_you_register_your_worker=? ", '5' ,'Regional Office').all
           
            @appealworkerstatus=@daterange.where('worker_status_found_medical_unsuitable=? ','Yes').all
           @appealworkerstatusNo=@daterange.where('worker_status_found_medical_unsuitable=? ','No').all
           @appealundergostatus=@daterange.where('undergo_fomema_appeal_process=? ','Yes').all
           @appealundergostatusNo=@daterange.where('undergo_fomema_appeal_process=? ','No').all
           @appealoverall1=  @daterange.where('tell_experience_appeal_process=? ','1').all
           @appealoverall2=  @daterange.where('tell_experience_appeal_process=? ','2').all
           @appealoverall3=  @daterange.where('tell_experience_appeal_process=? ','3').all
           @appealoverall4=  @daterange.where('tell_experience_appeal_process=? ','4').all
           @appealoverall5=  @daterange.where('tell_experience_appeal_process=? ','5').all
          
            @NPSregweb1=@daterange.where("process_emp_reg=? and process_worker_reg=? and panel_clinic_xray_facilities=? and overall_experience_reg_process=? and where_did_you_register_your_worker=? ", '1' ,'1' ,'1' ,'1'  ,'Web Portal').all
           @NPSregweb2=@daterange.where("process_emp_reg=? and process_worker_reg=? and panel_clinic_xray_facilities=? and overall_experience_reg_process=? and where_did_you_register_your_worker=? ", '2' ,'2' ,'2' ,'2'  ,'Web Portal').all
           @NPSregweb3=@daterange.where("process_emp_reg=? and process_worker_reg=? and panel_clinic_xray_facilities=? and overall_experience_reg_process=? and where_did_you_register_your_worker=? ", '3' ,'3' ,'3' ,'3'  ,'Web Portal').all
           @NPSregweb4=@daterange.where("process_emp_reg=? and process_worker_reg=? and panel_clinic_xray_facilities=? and overall_experience_reg_process=? and where_did_you_register_your_worker=? ", '4' ,'4' ,'4' ,'4'  ,'Web Portal').all
           @NPSregweb5=@daterange.where("process_emp_reg=? and process_worker_reg=? and panel_clinic_xray_facilities=? and overall_experience_reg_process=? and where_did_you_register_your_worker=? ", '5' ,'5' ,'5' ,'5'  ,'Web Portal').all

           #NPS registration regional office
           @NPSregreg1=@daterange.where("process_emp_reg=? and process_worker_reg=? and panel_clinic_xray_facilities=? and overall_experience_reg_process=? and where_did_you_register_your_worker=? ", '1' ,'1' ,'1' ,'1'  ,'Regional Office').all
           @NPSregreg2=@daterange.where("process_emp_reg=? and process_worker_reg=? and panel_clinic_xray_facilities=? and overall_experience_reg_process=? and where_did_you_register_your_worker=? ", '2' ,'2' ,'2' ,'2'  ,'Regional Office').all
           @NPSregreg3=@daterange.where("process_emp_reg=? and process_worker_reg=? and panel_clinic_xray_facilities=? and overall_experience_reg_process=? and where_did_you_register_your_worker=? ", '3' ,'3' ,'3' ,'3'  ,'Regional Office').all
           @NPSregreg4=@daterange.where("process_emp_reg=? and process_worker_reg=? and panel_clinic_xray_facilities=? and overall_experience_reg_process=? and where_did_you_register_your_worker=? ", '4' ,'4' ,'4' ,'4'  ,'Regional Office').all
           @NPSregreg5=@daterange.where("process_emp_reg=? and process_worker_reg=? and panel_clinic_xray_facilities=? and overall_experience_reg_process=? and where_did_you_register_your_worker=? ", '5' ,'5' ,'5' ,'5'  ,'Regional Office').all
           @NPSExs1=@daterange.where("location_panel_clinics=? and 'Fomema_medical_examincation_are_understandable'=? and 'medical_Examinations_are_easy_toobtain'=? and 'Overall_rate_experience_medical_examination'=? ", '1' ,'1' ,'1' ,'1').all
           @NPSExs2=@daterange.where("location_panel_clinics=? and 'Fomema_medical_examincation_are_understandable'=? and 'medical_Examinations_are_easy_toobtain'=? and 'Overall_rate_experience_medical_examination'=? ", '2' ,'2' ,'2' ,'2').all
           @NPSExs3=@daterange.where("location_panel_clinics=? and 'Fomema_medical_examincation_are_understandable'=? and 'medical_Examinations_are_easy_toobtain'=? and 'Overall_rate_experience_medical_examination'=? ", '3' ,'3' ,'3' ,'3').all
           @NPSExs4=@daterange.where("location_panel_clinics=? and 'Fomema_medical_examincation_are_understandable'=? and 'medical_Examinations_are_easy_toobtain'=? and 'Overall_rate_experience_medical_examination'=? ", '4' ,'4' ,'4' ,'4').all
           @NPSExs5=@daterange.where("location_panel_clinics=? and 'Fomema_medical_examincation_are_understandable'=? and 'medical_Examinations_are_easy_toobtain'=? and 'Overall_rate_experience_medical_examination'=? ", '5' ,'5' ,'5' ,'5').all
           
           @NPSappeal1=@daterange.where("tell_experience_appeal_process=? ", '1' ).all
           @NPSappeal2=@daterange.where("tell_experience_appeal_process=? ", '2').all
           @NPSappeal3=@daterange.where("tell_experience_appeal_process=? ", '3').all
           @NPSappeal4=@daterange.where("tell_experience_appeal_process=? ", '4').all
           @NPSappeal5=@daterange.where("tell_experience_appeal_process=? ", '5').all
           
           @panelclinic1=@daterange.where("location_panel_clinics=? ", '1').all
           @panelclinic2=@daterange.where("location_panel_clinics=? ", '2').all
           @panelclinic3=@daterange.where("location_panel_clinics=? ", '3').all
           @panelclinic4=@daterange.where("location_panel_clinics=? ", '4').all
           @panelclinic5=@daterange.where("location_panel_clinics=? ", '5').all

           @understantable1=@daterange.where("'Fomema_medical_examincation_are_understandable'=? ", '1').all
           @understantable2=@daterange.where("'Fomema_medical_examincation_are_understandable'=? ", '2').all
           @understantable3=@daterange.where("'Fomema_medical_examincation_are_understandable'=? ", '3').all
           @understantable4=@daterange.where("'Fomema_medical_examincation_are_understandable'=? ", '4').all
           @understantable5=@daterange.where("'Fomema_medical_examincation_are_understandable'=? ", '5').all

           @obtainable1=@daterange.where("'medical_Examinations_are_easy_toobtain'=? ", '1').all
           @obtainable2=@daterange.where("'medical_Examinations_are_easy_toobtain'=? ", '2').all
           @obtainable3=@daterange.where("'medical_Examinations_are_easy_toobtain'=? ", '3').all
           @obtainable4=@daterange.where("'medical_Examinations_are_easy_toobtain'=? ", '4').all
           @obtainable5=@daterange.where("'medical_Examinations_are_easy_toobtain'=? ", '5').all
           
            @overallexp1=@daterange.where("'Overall_rate_experience_medical_examination'=? ", '1').all
           @overallexp2=@daterange.where("'Overall_rate_experience_medical_examination'=? ", '2').all
           @overallexp3=@daterange.where("'Overall_rate_experience_medical_examination'=? ", '3').all
           @overallexp4=@daterange.where("'Overall_rate_experience_medical_examination'=? ", '4').all
           @overallexp5=@daterange.where("'Overall_rate_experience_medical_examination'=? ", '5').all
            
          end
      when "Sector"
        if param_value.present?
          
          @linechart_data=SurveyMonkeyCustomer.where("which_sector_below_represents IN(?)",param_value).group('which_sector_below_represents').count.to_a
          #@linechart_data = Transaction.joins(:job_type).group('job_types.name').where('job_types.id'=>param_value.split(",")).count.to_a
          
         @transaction_line_cahrt = @daterange.where('which_sector_below_represents IN(?)',param_value).transaction_data_1_year

        @respondentsagegroup1824=@respondentsagegroup1824.where('which_sector_below_represents IN(?)',param_value).all
        
        @respondentsagegroup2534=@respondentsagegroup2534.where('which_sector_below_represents IN(?)',param_value).all
        @respondentsagegroup3544=@respondentsagegroup3544.where('which_sector_below_represents IN(?)',param_value).all
        @respondentsagegroup4554=@respondentsagegroup4554.where('which_sector_below_represents IN(?)',param_value).all
        @respondentsagegroup5565=@respondentsagegroup5565.where('which_sector_below_represents IN(?)',param_value).all
        @respondentsagegroupmore65=@respondentsagegroupmore65.where('which_sector_below_represents IN(?)',param_value).all
        @webportal=@webportal.where('which_sector_below_represents IN(?)',param_value).all
        @Rooffice=@Rooffice.where('which_sector_below_represents IN(?)',param_value).all
        @gendermale=@gendermale.where('which_sector_below_represents IN(?)',param_value).all
       @genderfemale=@genderfemale.where('which_sector_below_represents IN(?)',param_value).all
       @individual=@individual.where('which_sector_below_represents IN(?)',param_value).all
       
       @company=@company.where('which_sector_below_represents IN(?)',param_value).all
       @agent=@agent.where('which_sector_below_represents IN(?)',param_value).all
       
        @facebook=@facebook.where('which_sector_below_represents IN(?)',param_value).all
        @twitter=@twitter.where('which_sector_below_represents IN(?)',param_value).all
        @instagram=@instagram.where('which_sector_below_represents IN(?)',param_value).all
        @telegram=@telegram.where('which_sector_below_represents IN(?)',param_value).all
        @OtherSM=@OtherSM.where('which_sector_below_represents IN(?)',param_value).all
       
        @operatingsocial=@operatingsocial.where('which_sector_below_represents IN(?)',param_value).all
        @operatingsocialNo=@operatingsocialNo.where('which_sector_below_represents IN(?)',param_value).all
        @health_awareness=@health_awareness.where('which_sector_below_represents IN(?)',param_value).all
        @health_awarenessNo=@health_awarenessNo.where('which_sector_below_represents IN(?)',param_value).all
        @moh_moha=@moh_moha.where('which_sector_below_represents IN(?)',param_value).all
        @moh_mohaNo=@moh_mohaNo.where('which_sector_below_represents IN(?)',param_value).all

        #employee reg webportal and reg office
        @employeeregweb1=@employeeregweb1.where("which_sector_below_represents IN(?)",param_value).all
        @employeeregweb2=@employeeregweb2.where("which_sector_below_represents IN(?)",param_value).all
        @employeeregweb3=@employeeregweb3.where("which_sector_below_represents IN(?)",param_value).all
        @employeeregweb4=@employeeregweb4.where("which_sector_below_represents IN(?)",param_value).all
        @employeeregweb5=@employeeregweb5.where("which_sector_below_represents IN(?)",param_value).all

 
        @employeeregreg1=@employeeregreg1.where("which_sector_below_represents IN(?)",param_value).all
        @employeeregreg2=@employeeregreg2.where("which_sector_below_represents IN(?)",param_value).all
        @employeeregreg3=@employeeregreg3.where("which_sector_below_represents IN(?)",param_value).all
        @employeeregreg4=@employeeregreg4.where("which_sector_below_represents IN(?)",param_value).all
        @employeeregreg5=@employeeregreg5.where("which_sector_below_represents IN(?)",param_value).all


           #worker reg webportal and reg office
        @workerregweb1=@workerregweb1.where("which_sector_below_represents IN(?)",param_value).all
        @workerregweb2=@workerregweb2.where("which_sector_below_represents IN(?)",param_value).all
        @workerregweb3=@workerregweb3.where("which_sector_below_represents IN(?)",param_value).all
        @workerregweb4=@workerregweb4.where("which_sector_below_represents IN(?)",param_value).all
        @workerregweb5=@workerregweb5.where("which_sector_below_represents IN(?)",param_value).all
       


        @workerregreg1=@workerregreg1.where("which_sector_below_represents IN(?)",param_value).all
        @workerregreg2=@workerregreg2.where("which_sector_below_represents IN(?)",param_value).all
        @workerregreg3=@workerregreg3.where("which_sector_below_represents IN(?)",param_value).all
        @workerregreg4=@workerregreg4.where("which_sector_below_represents IN(?)",param_value).all
        @workerregreg5=@workerregreg5.where("which_sector_below_represents IN(?)",param_value).all



        #panel clinic reg webportal and reg office
        @panelregweb1=@panelregweb1.where("which_sector_below_represents IN(?)",param_value).all
        @panelregweb2=@panelregweb2.where("which_sector_below_represents IN(?)",param_value).all
        @panelregweb3=@panelregweb3.where("which_sector_below_represents IN(?)",param_value).all
        @panelregweb4=@panelregweb4.where("which_sector_below_represents IN(?)",param_value).all
        @panelregweb5=@panelregweb5.where("which_sector_below_represents IN(?)",param_value).all
        


        @panelregreg1=@panelregreg1.where("which_sector_below_represents IN(?)",param_value).all
        @panelregreg2=@panelregreg2.where("which_sector_below_represents IN(?)",param_value).all
        @panelregreg3=@panelregreg3.where("which_sector_below_represents IN(?)",param_value).all
        @panelregreg4=@panelregreg4.where("which_sector_below_represents IN(?)",param_value).all
        @panelregreg5=@panelregreg5.where("which_sector_below_represents IN(?)",param_value).all
        

    

        #overall reg webportal and reg office
        @overallregweb1=@overallregweb1.where("which_sector_below_represents IN(?)",param_value).all
        @overallregweb2=@overallregweb2.where("which_sector_below_represents IN(?)",param_value).all
        @overallregweb3=@overallregweb3.where("which_sector_below_represents IN(?)",param_value).all
        @overallregweb4=@overallregweb4.where("which_sector_below_represents IN(?)",param_value).all
        @overallregweb5=@overallregweb5.where("which_sector_below_represents IN(?)",param_value).all
       
    
        
        @overallregreg1=@overallregreg1.where("which_sector_below_represents IN(?)",param_value).all
        @overallregreg2=@overallregreg2.where("which_sector_below_represents IN(?)",param_value).all
        @overallregreg3=@overallregreg3.where("which_sector_below_represents IN(?)",param_value).all
        @overallregreg4=@overallregreg4.where("which_sector_below_represents IN(?)",param_value).all
        @overallregreg5=@overallregreg5.where("which_sector_below_represents IN(?)",param_value).all

       
  

        @appealworkerstatus=@appealworkerstatus.where('which_sector_below_represents IN(?)',param_value).all
        @appealworkerstatusNo=@appealworkerstatusNo.where('which_sector_below_represents IN(?)',param_value).all
        @appealundergostatus=@appealundergostatus.where('which_sector_below_represents IN(?)',param_value).all
        @appealundergostatusNo=@appealundergostatusNo.where('which_sector_below_represents IN(?)',param_value).all
        @appealoverall1=  @appealoverall1.where('which_sector_below_represents IN(?)',param_value).all
        @appealoverall2=  @appealoverall2.where('which_sector_below_represents IN(?)',param_value).all
        @appealoverall3=  @appealoverall3.where('which_sector_below_represents IN(?)',param_value).all
        @appealoverall4=  @appealoverall4.where('which_sector_below_represents IN(?)',param_value).all
        @appealoverall5=  @appealoverall5.where('which_sector_below_represents IN(?)',param_value).all
  
        @NPSregweb1=@NPSregweb1.where("which_sector_below_represents IN(?)",param_value).all
        @NPSregweb2=@NPSregweb2.where("which_sector_below_represents IN(?)",param_value).all
        @NPSregweb3=@NPSregweb3.where("which_sector_below_represents IN(?)",param_value).all
        @NPSregweb4=@NPSregweb4.where("which_sector_below_represents IN(?)",param_value).all
        @NPSregweb5=@NPSregweb5.where("which_sector_below_represents IN(?)",param_value).all

        #NPS registration regional office
        @NPSregreg1=@NPSregreg1.where("which_sector_below_represents IN(?)",param_value).all
        @NPSregreg2=@NPSregreg2.where("which_sector_below_represents IN(?)",param_value).all
        @NPSregreg3=@NPSregreg3.where("which_sector_below_represents IN(?)",param_value).all
        @NPSregreg4=@NPSregreg4.where("which_sector_below_represents IN(?)",param_value).all
        @NPSregreg5=@NPSregreg5.where("which_sector_below_represents IN(?)",param_value).all

    
         #end
        #NPS Examination services
        @NPSExs1=@NPSExs1.where("which_sector_below_represents IN(?)",param_value).all
        @NPSExs2=@NPSExs2.where("which_sector_below_represents IN(?)",param_value).all
        @NPSExs3=@NPSExs3.where("which_sector_below_represents IN(?)",param_value).all
        @NPSExs4=@NPSExs4.where("which_sector_below_represents IN(?)",param_value).all
        @NPSExs5=@NPSExs5.where("which_sector_below_represents IN(?)",param_value).all

      
         #NPS appeal process
        @NPSappeal1=@NPSappeal1.where("which_sector_below_represents IN(?)",param_value).all
        @NPSappeal2=@NPSappeal2.where("which_sector_below_represents IN(?)",param_value).all
        @NPSappeal3=@NPSappeal3.where("which_sector_below_represents IN(?)",param_value).all
        @NPSappeal4=@NPSappeal4.where("which_sector_below_represents IN(?)",param_value).all
        @NPSappeal5=@NPSappeal5.where("which_sector_below_represents IN(?)",param_value).all

     


        @panelclinic1=@panelclinic1.where("which_sector_below_represents IN(?)",param_value).all
        @panelclinic2=@panelclinic2.where("which_sector_below_represents IN(?)",param_value).all
        @panelclinic3=@panelclinic3.where("which_sector_below_represents IN(?)",param_value).all
        @panelclinic4=@panelclinic4.where("which_sector_below_represents IN(?)",param_value).all
        @panelclinic5=@panelclinic5.where("which_sector_below_represents IN(?)",param_value).all


     
        @understantable1=@understantable1.where("which_sector_below_represents IN(?)",param_value).all
        @understantable2=@understantable2.where("which_sector_below_represents IN(?)",param_value).all
        @understantable3=@understantable3.where("which_sector_below_represents IN(?)",param_value).all
        @understantable4=@understantable4.where("which_sector_below_represents IN(?)",param_value).all
        @understantable5=@understantable5.where("which_sector_below_represents IN(?)",param_value).all


        @obtainable1=@obtainable1.where("which_sector_below_represents IN(?)",param_value).all
        @obtainable2=@obtainable2.where("which_sector_below_represents IN(?)",param_value).all
        @obtainable3=@obtainable3.where("which_sector_below_represents IN(?)",param_value).all
        @obtainable4=@obtainable4.where("which_sector_below_represents IN(?)",param_value).all
        @obtainable5=@obtainable5.where("which_sector_below_represents IN(?)",param_value).all

        @overallexp1=@overallexp1.where("which_sector_below_represents IN(?)",param_value).all
        @overallexp2=@overallexp2.where("which_sector_below_represents IN(?)",param_value).all
        @overallexp3=@overallexp3.where("which_sector_below_represents IN(?)",param_value).all
        @overallexp4=@overallexp4.where("which_sector_below_represents IN(?)",param_value).all
        @overallexp5=@overallexp5.where("which_sector_below_represents IN(?)",param_value).all
         

        end
      when "customer_type"
        if param_value.present?

        @transaction_line_cahrt = @daterange.where('what_is_customer_suits_you IN(?)',param_value).transaction_data_1_year

        @respondentsagegroup1824=@respondentsagegroup1824.where('what_is_customer_suits_you IN(?)',param_value).all
        
        @respondentsagegroup2534=@respondentsagegroup2534.where('what_is_customer_suits_you IN(?)',param_value).all
        @respondentsagegroup3544=@respondentsagegroup3544.where('what_is_customer_suits_you IN(?)',param_value).all
        @respondentsagegroup4554=@respondentsagegroup4554.where('what_is_customer_suits_you IN(?)',param_value).all
        @respondentsagegroup5565=@respondentsagegroup5565.where('what_is_customer_suits_you IN(?)',param_value).all
        @respondentsagegroupmore65=@respondentsagegroupmore65.where('what_is_customer_suits_you IN(?)',param_value).all
        @webportal=@webportal.where('what_is_customer_suits_you IN(?)',param_value).all
        @Rooffice=@Rooffice.where('what_is_customer_suits_you IN(?)',param_value).all
        @gendermale=@gendermale.where('what_is_customer_suits_you IN(?)',param_value).all
       @genderfemale=@genderfemale.where('what_is_customer_suits_you IN(?)',param_value).all
       @individual=@individual.where(' what_is_customer_suits_you IN(?)',param_value).all
       
       @company=@company.where('what_is_customer_suits_you IN(?)',param_value).all
       @agent=@agent.where(' what_is_customer_suits_you IN(?)',param_value).all
       
        @facebook=@facebook.where('what_is_customer_suits_you IN(?)',param_value).all
        @twitter=@twitter.where('what_is_customer_suits_you IN(?)',param_value).all
        @instagram=@instagram.where('what_is_customer_suits_you IN(?)',param_value).all
        @telegram=@telegram.where('what_is_customer_suits_you IN(?)',param_value).all
        @OtherSM=@OtherSM.where('what_is_customer_suits_you IN(?)',param_value).all
       
        @operatingsocial=@operatingsocial.where('what_is_customer_suits_you IN(?)',param_value).all
        @operatingsocialNo=@operatingsocialNo.where('what_is_customer_suits_you IN(?)',param_value).all
        @health_awareness=@health_awareness.where('what_is_customer_suits_you IN(?)',param_value).all
        @health_awarenessNo=@health_awarenessNo.where('what_is_customer_suits_you IN(?)',param_value).all
        @moh_moha=@moh_moha.where('what_is_customer_suits_you IN(?)',param_value).all
        @moh_mohaNo=@moh_mohaNo.where('what_is_customer_suits_you IN(?)',param_value).all

        #employee reg webportal and reg office
        @employeeregweb1=@employeeregweb1.where("what_is_customer_suits_you IN(?)",param_value).all
        @employeeregweb2=@employeeregweb2.where("what_is_customer_suits_you IN(?)",param_value).all
        @employeeregweb3=@employeeregweb3.where("what_is_customer_suits_you IN(?)",param_value).all
        @employeeregweb4=@employeeregweb4.where("what_is_customer_suits_you IN(?)",param_value).all
        @employeeregweb5=@employeeregweb5.where("what_is_customer_suits_you IN(?)",param_value).all

 
        @employeeregreg1=@employeeregreg1.where("what_is_customer_suits_you IN(?)",param_value).all
        @employeeregreg2=@employeeregreg2.where("what_is_customer_suits_you IN(?)",param_value).all
        @employeeregreg3=@employeeregreg3.where("what_is_customer_suits_you IN(?)",param_value).all
        @employeeregreg4=@employeeregreg4.where("what_is_customer_suits_you IN(?)",param_value).all
        @employeeregreg5=@employeeregreg5.where("what_is_customer_suits_you IN(?)",param_value).all


           #worker reg webportal and reg office
        @workerregweb1=@workerregweb1.where("what_is_customer_suits_you IN(?)",param_value).all
        @workerregweb2=@workerregweb2.where("what_is_customer_suits_you IN(?)",param_value).all
        @workerregweb3=@workerregweb3.where("what_is_customer_suits_you IN(?)",param_value).all
        @workerregweb4=@workerregweb4.where("what_is_customer_suits_you IN(?)",param_value).all
        @workerregweb5=@workerregweb5.where("what_is_customer_suits_you IN(?)",param_value).all
       


        @workerregreg1=@workerregreg1.where("what_is_customer_suits_you IN(?)",param_value).all
        @workerregreg2=@workerregreg2.where("what_is_customer_suits_you IN(?)",param_value).all
        @workerregreg3=@workerregreg3.where("what_is_customer_suits_you IN(?)",param_value).all
        @workerregreg4=@workerregreg4.where("what_is_customer_suits_you IN(?)",param_value).all
        @workerregreg5=@workerregreg5.where("what_is_customer_suits_you IN(?)",param_value).all



        #panel clinic reg webportal and reg office
        @panelregweb1=@panelregweb1.where("what_is_customer_suits_you IN(?)",param_value).all
        @panelregweb2=@panelregweb2.where("what_is_customer_suits_you IN(?)",param_value).all
        @panelregweb3=@panelregweb3.where("what_is_customer_suits_you IN(?)",param_value).all
        @panelregweb4=@panelregweb4.where("what_is_customer_suits_you IN(?)",param_value).all
        @panelregweb5=@panelregweb5.where("what_is_customer_suits_you IN(?)",param_value).all
        


        @panelregreg1=@panelregreg1.where("what_is_customer_suits_you IN(?)",param_value).all
        @panelregreg2=@panelregreg2.where("what_is_customer_suits_you IN(?)",param_value).all
        @panelregreg3=@panelregreg3.where("what_is_customer_suits_you IN(?)",param_value).all
        @panelregreg4=@panelregreg4.where("what_is_customer_suits_you IN(?)",param_value).all
        @panelregreg5=@panelregreg5.where("what_is_customer_suits_you IN(?)",param_value).all
        

    

        #overall reg webportal and reg office
        @overallregweb1=@overallregweb1.where("what_is_customer_suits_you IN(?)",param_value).all
        @overallregweb2=@overallregweb2.where("what_is_customer_suits_you IN(?)",param_value).all
        @overallregweb3=@overallregweb3.where("what_is_customer_suits_you IN(?)",param_value).all
        @overallregweb4=@overallregweb4.where("what_is_customer_suits_you IN(?)",param_value).all
        @overallregweb5=@overallregweb5.where("what_is_customer_suits_you IN(?)",param_value).all
       
    
        
        @overallregreg1=@overallregreg1.where("what_is_customer_suits_you IN(?)",param_value).all
        @overallregreg2=@overallregreg2.where("what_is_customer_suits_you IN(?)",param_value).all
        @overallregreg3=@overallregreg3.where("what_is_customer_suits_you IN(?)",param_value).all
        @overallregreg4=@overallregreg4.where("what_is_customer_suits_you IN(?)",param_value).all
        @overallregreg5=@overallregreg5.where("what_is_customer_suits_you IN(?)",param_value).all

       
  

        @appealworkerstatus=@appealworkerstatus.where('what_is_customer_suits_you IN(?)',param_value).all
        @appealworkerstatusNo=@appealworkerstatusNo.where('what_is_customer_suits_you IN(?)',param_value).all
        @appealundergostatus=@appealundergostatus.where('what_is_customer_suits_you IN(?)',param_value).all
        @appealundergostatusNo=@appealundergostatusNo.where('what_is_customer_suits_you IN(?)',param_value).all
        @appealoverall1=  @appealoverall1.where('what_is_customer_suits_you IN(?)',param_value).all
        @appealoverall2=  @appealoverall2.where('what_is_customer_suits_you IN(?)',param_value).all
        @appealoverall3=  @appealoverall3.where('what_is_customer_suits_you IN(?)',param_value).all
        @appealoverall4=  @appealoverall4.where('what_is_customer_suits_you IN(?)',param_value).all
        @appealoverall5=  @appealoverall5.where('what_is_customer_suits_you IN(?)',param_value).all
       
    
        


        @NPSregweb1=@NPSregweb1.where("what_is_customer_suits_you IN(?)",param_value).all
        @NPSregweb2=@NPSregweb2.where("what_is_customer_suits_you IN(?)",param_value).all
        @NPSregweb3=@NPSregweb3.where("what_is_customer_suits_you IN(?)",param_value).all
        @NPSregweb4=@NPSregweb4.where("what_is_customer_suits_you IN(?)",param_value).all
        @NPSregweb5=@NPSregweb5.where("what_is_customer_suits_you IN(?)",param_value).all

        #NPS registration regional office
        @NPSregreg1=@NPSregreg1.where("what_is_customer_suits_you IN(?)",param_value).all
        @NPSregreg2=@NPSregreg2.where("what_is_customer_suits_you IN(?)",param_value).all
        @NPSregreg3=@NPSregreg3.where("what_is_customer_suits_you IN(?)",param_value).all
        @NPSregreg4=@NPSregreg4.where("what_is_customer_suits_you IN(?)",param_value).all
        @NPSregreg5=@NPSregreg5.where("what_is_customer_suits_you IN(?)",param_value).all

    
         #end
        #NPS Examination services
        @NPSExs1=@NPSExs1.where("what_is_customer_suits_you IN(?)",param_value).all
        @NPSExs2=@NPSExs2.where("what_is_customer_suits_you IN(?)",param_value).all
        @NPSExs3=@NPSExs3.where("what_is_customer_suits_you IN(?)",param_value).all
        @NPSExs4=@NPSExs4.where("what_is_customer_suits_you IN(?)",param_value).all
        @NPSExs5=@NPSExs5.where("what_is_customer_suits_you IN(?)",param_value).all

      
         #NPS appeal process
        @NPSappeal1=@NPSappeal1.where("what_is_customer_suits_you IN(?)",param_value).all
        @NPSappeal2=@NPSappeal2.where("what_is_customer_suits_you IN(?)",param_value).all
        @NPSappeal3=@NPSappeal3.where("what_is_customer_suits_you IN(?)",param_value).all
        @NPSappeal4=@NPSappeal4.where("what_is_customer_suits_you IN(?)",param_value).all
        @NPSappeal5=@NPSappeal5.where("what_is_customer_suits_you IN(?)",param_value).all

     


        @panelclinic1=@panelclinic1.where("what_is_customer_suits_you IN(?)",param_value).all
        @panelclinic2=@panelclinic2.where("what_is_customer_suits_you IN(?)",param_value).all
        @panelclinic3=@panelclinic3.where("what_is_customer_suits_you IN(?)",param_value).all
        @panelclinic4=@panelclinic4.where("what_is_customer_suits_you IN(?)",param_value).all
        @panelclinic5=@panelclinic5.where("what_is_customer_suits_you IN(?)",param_value).all


     
        @understantable1=@understantable1.where("what_is_customer_suits_you IN(?)",param_value).all
        @understantable2=@understantable2.where("what_is_customer_suits_you IN(?)",param_value).all
        @understantable3=@understantable3.where("what_is_customer_suits_you IN(?)",param_value).all
        @understantable4=@understantable4.where("what_is_customer_suits_you IN(?)",param_value).all
        @understantable5=@understantable5.where("what_is_customer_suits_you IN(?)",param_value).all


      

        @obtainable1=@obtainable1.where("what_is_customer_suits_you IN(?)",param_value).all
        @obtainable2=@obtainable2.where("what_is_customer_suits_you IN(?)",param_value).all
        @obtainable3=@obtainable3.where("what_is_customer_suits_you IN(?)",param_value).all
        @obtainable4=@obtainable4.where("what_is_customer_suits_you IN(?)",param_value).all
        @obtainable5=@obtainable5.where("what_is_customer_suits_you IN(?)",param_value).all


       

        @overallexp1=@overallexp1.where("what_is_customer_suits_you IN(?)",param_value).all
        @overallexp2=@overallexp2.where("what_is_customer_suits_you IN(?)",param_value).all
        @overallexp3=@overallexp3.where("what_is_customer_suits_you IN(?)",param_value).all
        @overallexp4=@overallexp4.where("what_is_customer_suits_you IN(?)",param_value).all
        @overallexp5=@overallexp5.where("what_is_customer_suits_you IN(?)",param_value).all
         


        end
      when "reg"
        if param_value.present?

           @transaction_line_cahrt = @daterange.where('where_did_you_register_your_worker IN(?)',param_value).transaction_data_1_year

        @respondentsagegroup1824=@respondentsagegroup1824.where('where_did_you_register_your_worker IN(?)',param_value).all
        @respondentsagegroup2534=@respondentsagegroup2534.where('where_did_you_register_your_worker IN(?)',param_value).all
        @respondentsagegroup3544=@respondentsagegroup3544.where('where_did_you_register_your_worker IN(?)',param_value).all
        @respondentsagegroup4554=@respondentsagegroup4554.where('where_did_you_register_your_worker IN(?)',param_value).all
        @respondentsagegroup5565=@respondentsagegroup5565.where('where_did_you_register_your_worker IN(?)',param_value).all
        @respondentsagegroupmore65=@respondentsagegroupmore65.where('where_did_you_register_your_worker IN(?)',param_value).all
        @webportal=@webportal.where(' where_did_you_register_your_worker IN(?)',param_value).all
        @Rooffice=@Rooffice.where(' where_did_you_register_your_worker IN(?)',param_value).all
        @gendermale=@gendermale.where('where_did_you_register_your_worker IN(?)',param_value).all
       @genderfemale=@genderfemale.where('where_did_you_register_your_worker IN(?)',param_value).all
       @individual=@individual.where(' where_did_you_register_your_worker IN(?)',param_value).all
       
       @company=@company.where(' where_did_you_register_your_worker IN(?)',param_value).all
       @agent=@agent.where('where_did_you_register_your_worker IN(?)',param_value).all  
       
        @facebook=@facebook.where('where_did_you_register_your_worker IN(?)',param_value).all
        @twitter=@twitter.where('where_did_you_register_your_worker IN(?)',param_value).all
        @instagram=@instagram.where('where_did_you_register_your_worker IN(?)',param_value).all
        @telegram=@telegram.where('where_did_you_register_your_worker IN(?)',param_value).all
        @OtherSM=@OtherSM.where('where_did_you_register_your_worker IN(?)',param_value).all
       
        @operatingsocial=@operatingsocial.where('where_did_you_register_your_worker IN(?)',param_value).all
        @operatingsocialNo=@operatingsocialNo.where('where_did_you_register_your_worker IN(?)',param_value).all
        @health_awareness=@health_awareness.where('where_did_you_register_your_worker IN(?)',param_value).all
        @health_awarenessNo=@health_awarenessNo.where('where_did_you_register_your_worker IN(?)',param_value).all
        @moh_moha=@moh_moha.where('where_did_you_register_your_worker IN(?)',param_value).all
        @moh_mohaNo=@moh_mohaNo.where('where_did_you_register_your_worker IN(?)',param_value).all
        
         #employee reg webportal and reg office
        @employeeregweb1=@employeeregweb1.where("where_did_you_register_your_worker IN(?)",param_value).all
        @employeeregweb2=@employeeregweb2.where("where_did_you_register_your_worker IN(?)",param_value).all
        @employeeregweb3=@employeeregweb3.where("where_did_you_register_your_worker IN(?)",param_value).all
        @employeeregweb4=@employeeregweb4.where("where_did_you_register_your_worker IN(?)",param_value).all
        @employeeregweb5=@employeeregweb5.where("where_did_you_register_your_worker IN(?)",param_value).all

        #@employeeregweball= (@employeeregweb1*1)+(@employeeregweb2*2)+(@employeeregweb3*3)+(@employeeregweb4*4)+(@employeeregweb5*5)
        #@employeeregweballcount=@employeeregweb1+@employeeregweb2+@employeeregweb3+@employeeregweb4+@employeeregweb5
        #if(@employeeregweballcount>0)
        #@employeeregweballsum=@employeeregweball/@employeeregweballcount
        #else
         #@employeeregweballsum=0
        #end

        @employeeregreg1=@employeeregreg1.where("where_did_you_register_your_worker IN(?)",param_value).all
        @employeeregreg2=@employeeregreg2.where("where_did_you_register_your_worker IN(?)",param_value).all
        @employeeregreg3=@employeeregreg3.where("where_did_you_register_your_worker IN(?)",param_value).all
        @employeeregreg4=@employeeregreg4.where("where_did_you_register_your_worker IN(?)",param_value).all
        @employeeregreg5=@employeeregreg5.where("where_did_you_register_your_worker IN(?)",param_value).all


        #@employeeregregall= (@employeeregreg1*1)+(@employeeregreg2*2)+(@employeeregreg3*3)+(@employeeregreg4*4)+(@employeeregreg5*5)
        #@employeeregregcount=@employeeregreg1+@employeeregreg2+@employeeregreg3+@employeeregreg4+@employeeregreg5
        #if(@employeeregregall>0)
        #@employeeregregsum=@employeeregregall/@employeeregregcount
        #else
        #   @employeeregregsum=0
        #end
           #worker reg webportal and reg office
        @workerregweb1=@workerregweb1.where("where_did_you_register_your_worker IN(?)",param_value).all
        @workerregweb2=@workerregweb2.where("where_did_you_register_your_worker IN(?)",param_value).all
        @workerregweb3=@workerregweb3.where("where_did_you_register_your_worker IN(?)",param_value).all
        @workerregweb4=@workerregweb4.where("where_did_you_register_your_worker IN(?)",param_value).all
        @workerregweb5=@workerregweb5.where("where_did_you_register_your_worker IN(?)",param_value).all

        #@workerregweball= (@workerregweb1*1)+(@workerregweb2*2)+(@workerregweb3*3)+(@workerregweb4*4)+(@workerregweb5*5)
        #@workerregweballcount=@workerregweb1+@workerregweb2+@workerregweb3+@workerregweb4+@workerregweb5
        #if(@workerregweballcount>0)
        #@workerregweballsum=@workerregweball/@workerregweballcount
        #else
        #   @workerregweballsum=0
        #end

        @workerregreg1=@workerregreg1.where("where_did_you_register_your_worker IN(?)",param_value).all
        @workerregreg2=@workerregreg2.where("where_did_you_register_your_worker IN(?)",param_value).all
        @workerregreg3=@workerregreg3.where("where_did_you_register_your_worker IN(?)",param_value).all
        @workerregreg4=@workerregreg4.where("where_did_you_register_your_worker IN(?)",param_value).all
        @workerregreg5=@workerregreg5.where("where_did_you_register_your_worker IN(?)",param_value).all

       
        #@workerregregall= (@workerregreg1*1)+(@workerregreg2*2)+(@workerregreg3*3)+(@workerregreg4*4)+(@workerregreg5*5)
        #@workerregregcount=@workerregreg1+@workerregreg2+@workerregreg3+@workerregreg4+@workerregreg5
        #if(@workerregregcount>0)
        #@workerregregsum=@workerregregall/@workerregregcount
        #else
        #   @workerregregsum=0
        #end
        

        #panel clinic reg webportal and reg office
        @panelregweb1=@panelregweb1.where(" where_did_you_register_your_worker IN(?)",param_value).all
        @panelregweb2=@panelregweb2.where("where_did_you_register_your_worker IN(?)",param_value).all
        @panelregweb3=@panelregweb3.where("where_did_you_register_your_worker IN(?)",param_value).all
        @panelregweb4=@panelregweb4.where("where_did_you_register_your_worker IN(?)",param_value).all
        @panelregweb5=@panelregweb5.where("where_did_you_register_your_worker IN(?)",param_value).all
       
        #@panelregweball= (@panelregweb1*1)+(@panelregweb2*2)+(@panelregweb3*3)+(@panelregweb4*4)+(@panelregweb5*5)
        #@panelregweballcount=@panelregweb1+@panelregweb2+@panelregweb3+@panelregweb4+@panelregweb5
        #if(@panelregweballcount>0)
        #@panelregweballsum=@panelregweball/@panelregweballcount
        #else
        #   @panelregweballsum=0
        #end
       

        @panelregreg1=@panelregreg1.where("where_did_you_register_your_worker IN(?)",param_value).all
        @panelregreg2=@panelregreg2.where("where_did_you_register_your_worker IN(?)",param_value).all
        @panelregreg3=@panelregreg3.where("where_did_you_register_your_worker IN(?)",param_value).all
        @panelregreg4=@panelregreg4.where("where_did_you_register_your_worker IN(?)",param_value).all
        @panelregreg5=@panelregreg5.where("where_did_you_register_your_worker IN(?)",param_value).all

        
        #@panelregregall= (@panelregreg1*1)+(@panelregreg2*2)+(@panelregreg3*3)+(@panelregreg4*4)+(@panelregreg5*5)
        #@panelregregcount=@panelregreg1+@panelregreg2+@panelregreg3+@panelregreg4+@panelregreg5
        #if(@panelregregcount>0)
        #@panelregregsum=@panelregregall/@panelregregcount        
        #else
        #   @panelregregsum=0
        #end
       

        #overall reg webportal and reg office
        @overallregweb1=@overallregweb1.where("where_did_you_register_your_worker IN(?)",param_value).all
        @overallregweb2=@overallregweb2.where("where_did_you_register_your_worker IN(?)",param_value).all
        @overallregweb3=@overallregweb3.where("where_did_you_register_your_worker IN(?)",param_value).all
        @overallregweb4=@overallregweb4.where("where_did_you_register_your_worker IN(?)",param_value).all
        @overallregweb5=@overallregweb5.where("where_did_you_register_your_worker IN(?)",param_value).all

        #@overallregweball= (@overallregweb1*1)+(@overallregweb2*2)+(@overallregweb3*3)+(@overallregweb4*4)+(@overallregweb5*5)
        #@overallregweballcount=@overallregweb1+@overallregweb2+@overallregweb3+@overallregweb4+@overallregweb5
        #if(@overallregweballcount>0)
        #@overallregweballsum=@overallregweball/@overallregweballcount
        #else
        #   @overallregweballsum=0
        #end

        @overallregreg1=@overallregreg1.where("where_did_you_register_your_worker IN(?)",param_value).all
        @overallregreg2=@overallregreg2.where("where_did_you_register_your_worker IN(?)",param_value).all
        @overallregreg3=@overallregreg3.where("where_did_you_register_your_worker IN(?)",param_value).all
        @overallregreg4=@overallregreg4.where("where_did_you_register_your_worker IN(?)",param_value).all
        @overallregreg5=@overallregreg5.where("where_did_you_register_your_worker IN(?)",param_value).all


        #@overallregregall= (@overallregreg1*1)+(@overallregreg2*2)+(@overallregreg3*3)+(@overallregreg4*4)+(@overallregreg5*5)
        #@overallregregcount=@overallregreg1+@overallregreg2+@overallregreg3+@overallregreg4+@overallregreg5
        #if(@overallregregcount>0)
        #@overallregregsum=@overallregregall/@overallregregcount
        #else
         #@overallregregsum=0
        #end

        @appealworkerstatus=@appealworkerstatus.where('where_did_you_register_your_worker IN(?)',param_value).all
        @appealworkerstatusNo=@appealworkerstatusNo.where('where_did_you_register_your_worker IN(?)',param_value).all
        @appealundergostatus=@appealundergostatus.where('where_did_you_register_your_worker IN(?)',param_value).all
        @appealundergostatusNo=@appealundergostatusNo.where('where_did_you_register_your_worker IN(?)',param_value).all
        @appealoverall1=  @appealoverall1.where('where_did_you_register_your_worker IN(?)',param_value).all
        @appealoverall2=  @appealoverall2.where('where_did_you_register_your_worker IN(?)',param_value).all
        @appealoverall3=  @appealoverall3.where('where_did_you_register_your_worker IN(?)',param_value).all
        @appealoverall4=  @appealoverall4.where('where_did_you_register_your_worker IN(?)',param_value).all
        @appealoverall5=  @appealoverall5.where('where_did_you_register_your_worker IN(?)',param_value).all
        #@appealoverall= (@appealoverall1*1)+(@appealoverall2*2)+(@appealoverall3*3)+(@appealoverall4*4)+(@appealoverall5*5)
        #@appealoverallcount=@appealoverall1+@appealoverall2+@appealoverall3+@appealoverall4+@appealoverall5
        #if(@appealoverallcount>0)
        #@appealoverallsum=@appealoverall/@appealoverallcount
        #else
        #   @appealoverallsum=0
        #end

        #NPS registration web portal
        @NPSregweb1=@NPSregweb1.where("where_did_you_register_your_worker IN(?)",param_value).all
        @NPSregweb2=@NPSregweb2.where("where_did_you_register_your_worker IN(?)",param_value).all
        @NPSregweb3=@NPSregweb3.where("where_did_you_register_your_worker IN(?)",param_value).all
        @NPSregweb4=@NPSregweb4.where("where_did_you_register_your_worker IN(?)",param_value).all
        @NPSregweb5=@NPSregweb5.where("where_did_you_register_your_worker IN(?)",param_value).all

        #@NPSregweball= (@NPSregweb1*1)+(@NPSregweb2*2)+(@NPSregweb3*3)+(@NPSregweb4*4)+(@NPSregweb5*5)
        #@NPSregwebpromoters=@NPSregweb4+@NPSregweb5
        #@NPSregwebdectoters=@NPSregweb1+@NPSregweb2
        #if(@NPSregweball>0)
        #@NPSwebpercentagepromoters=(@NPSregwebpromoters*100/@NPSregweball)
        #@NPSwebpercentagedectaters=(@NPSregwebdectoters*100/@NPSregweball)
        #@NPSoverallpercentage=@NPSwebpercentagepromoters-@NPSwebpercentagedectaters
        #else
        #   @NPSoverallpercentage=0
        #end
        #NPS registration regional office
        @NPSregreg1=@NPSregreg1.where("where_did_you_register_your_worker IN(?)",param_value).all
        @NPSregreg2=@NPSregreg2.where("where_did_you_register_your_worker IN(?)",param_value).all
        @NPSregreg3=@NPSregreg3.where("where_did_you_register_your_worker IN(?)",param_value).all
        @NPSregreg4=@NPSregreg4.where("where_did_you_register_your_worker IN(?)",param_value).all
        @NPSregreg5=@NPSregreg5.where("where_did_you_register_your_worker IN(?)",param_value).all

        #@NPSregregall= (@NPSregreg1*1)+(@NPSregreg2*2)+(@NPSregreg3*3)+(@NPSregreg4*4)+(@NPSregreg5*5)
        #@NPSregregpromoters=@NPSregreg4+@NPSregreg5
        #@NPSregregdectoters=@NPSregreg1+@NPSregreg2
        #if(@NPSregregall>0)
        #@NPSregpercentagepromoters=(@NPSregregpromoters*100/@NPSregregall)
        #@NPSregpercentagedectaters=(@NPSregregdectoters*100/@NPSregregall)
        #@NPSregoverallpercentage=@NPSregpercentagepromoters-@NPSregpercentagedectaters
        # else
        #   @NPSregoverallpercentage=0
        #end
        #NPS Examination services
        @NPSExs1=@NPSExs1.where("where_did_you_register_your_worker IN(?)",param_value).all
        @NPSExs2=@NPSExs2.where("where_did_you_register_your_worker IN(?)",param_value).all
        @NPSExs3=@NPSExs3.where("where_did_you_register_your_worker IN(?)",param_value).all
        @NPSExs4=@NPSExs4.where("where_did_you_register_your_worker IN(?)",param_value).all
        @NPSExs5=@NPSExs5.where("where_did_you_register_your_worker IN(?)",param_value).all

        #@NPSExsall= (@NPSExs1*1)+(@NPSExs2*2)+(@NPSExs3*3)+(@NPSExs4*4)+(@NPSExs5*5)
        #@NPSExspromoters=@NPSExs4+@NPSExs5
        #@NPSExsdectoters=@NPSExs1+@NPSExs2
        #if(@NPSExsall>0)
         #  @NPSExspercentagepromoters=(@NPSExspromoters*100/@NPSExsall)
         #  @NPSExspercentagedectaters=(@NPSExsdectoters*100/@NPSExsall)
         #  @NPSExsoverallpercentage=@NPSExspercentagepromoters-@NPSExspercentagedectaters
        #else
        #   @NPSExsoverallpercentage=0
        #end
        #NPS appeal process
        @NPSappeal1=@NPSappeal1.where("where_did_you_register_your_worker IN(?)",param_value).all
        @NPSappeal2=@NPSappeal2.where("where_did_you_register_your_worker IN(?)",param_value).all
        @NPSappeal3=@NPSappeal3.where("where_did_you_register_your_worker IN(?)",param_value).all
        @NPSappeal4=@NPSappeal4.where("where_did_you_register_your_worker IN(?)",param_value).all
        @NPSappeal5=@NPSappeal5.where("where_did_you_register_your_worker IN(?)",param_value).all

        #@NPSappealall= (@NPSappeal1*1)+(@NPSappeal2*2)+(@NPSappeal3*3)+(@NPSappeal4*4)+(@NPSappeal5*5)
        #@NPSappealpromoters=@NPSappeal4+@NPSappeal5
        #@NPSappealdectoters=@NPSappeal1+@NPSappeal2
        #if(@NPSappealall>0)
         #  @NPSappealpercentagepromoters=(@NPSappealpromoters*100/@NPSappealall)
          # @NPSappealpercentagedectaters=(@NPSappealdectoters*100/@NPSappealall)
          # @NPSappealoverallpercentage=@NPSappealpercentagepromoters-@NPSappealpercentagedectaters
        #else
        #   @NPSappealoverallpercentage=0
        #end
       #NPS Average services
       #if(@NPSoverallpercentage>0)
       #@NpsAveragescore=(@NPSoverallpercentage+@NPSregoverallpercentage+@NPSExsoverallpercentage+@NPSExsoverallpercentage)
      #@NPSavgscore=@NpsAveragescore/4
       #else
       # @NPSavgscore=0
       #end

       @panelclinic1=@panelclinic1.where("where_did_you_register_your_worker IN(?)",param_value).all
        @panelclinic2=@panelclinic2.where("where_did_you_register_your_worker IN(?)",param_value).all
        @panelclinic3=@panelclinic3.where("where_did_you_register_your_worker IN(?)",param_value).all
        @panelclinic4=@panelclinic4.where("where_did_you_register_your_worker IN(?)",param_value).all
        @panelclinic5=@panelclinic5.where("where_did_you_register_your_worker IN(?)",param_value).all


        #@panelclinic1all= (@panelclinic1*1)+(@panelclinic2*2)+(@panelclinic3*3)+(@panelclinic4*4)+(@panelclinic5*5)
        #@panelclinic1count=@panelclinic1+@panelclinic2+@panelclinic3+@panelclinic4+@panelclinic5
        #if(@panelclinic1all>0)
        #@panelclinics=@panelclinic1all/@panelclinic1count
        #else
         #@panelclinics=0
        #end
        
        @understantable1=@understantable1.where("where_did_you_register_your_worker IN(?)",param_value).all
        @understantable2=@understantable2.where("where_did_you_register_your_worker IN(?)",param_value).all
        @understantable3=@understantable3.where("where_did_you_register_your_worker IN(?)",param_value).all
        @understantable4=@understantable4.where("where_did_you_register_your_worker IN(?)",param_value).all
        @understantable5=@understantable5.where("where_did_you_register_your_worker IN(?)",param_value).all


        #@understantableall= (@understantable1*1)+(@understantable2*2)+(@understantable3*3)+(@understantable4*4)+(@understantable5*5)
        #@understantablecount=@understantable1+@understantable2+@understantable3+@understantable4+@understantable5
        #if(@understantableall>0)
        #@understantable=@understantableall/@understantablecount
        #else
        #   @understantable=0
        #end

        @obtainable1=@obtainable1.where("where_did_you_register_your_worker IN(?)",param_value).all
        @obtainable2=@obtainable2.where("where_did_you_register_your_worker IN(?)",param_value).all
        @obtainable3=@obtainable3.where("where_did_you_register_your_worker IN(?)",param_value).all
        @obtainable4=@obtainable4.where("where_did_you_register_your_worker IN(?)",param_value).all
        @obtainable5=@obtainable5.where("where_did_you_register_your_worker IN(?)",param_value).all


        #@obtainableall= (@obtainable1*1)+(@obtainable2*2)+(@obtainable3*3)+(@obtainable4*4)+(@obtainable5*5)
        #@obtainablecount=@obtainable1+@obtainable2+@obtainable3+@obtainable4+@obtainable5
        #if(@obtainableall>0)
        #@obtainable=@obtainableall/@obtainablecount
        #else
        #   @obtainable=0
        #end

        @overallexp1=@overallexp1.where("where_did_you_register_your_worker IN(?)",param_value).all
        @overallexp2=@overallexp2.where("where_did_you_register_your_worker IN(?)",param_value).all
        @overallexp3=@overallexp3.where("where_did_you_register_your_worker IN(?)",param_value).all
        @overallexp4=@overallexp4.where("where_did_you_register_your_worker IN(?)",param_value).all
        @overallexp5=@overallexp5.where("where_did_you_register_your_worker IN(?)",param_value).all


        #@overallexpall= (@overallexp1*1)+(@overallexp2*2)+(@overallexp3*3)+(@overallexp4*4)+(@overallexp5*5)
        #@overallexpcount=@overallexp1+@overallexp2+@overallexp3+@overallexp4+@overallexp5
        #if(@overallexpall>0)
        #@overallexp=@overallexpall/@overallexpcount
        #else
         #@overallexp=0
        #end

        end
      when "agegroup"
        if param_value.present?
       @transaction_line_cahrt = @daterange.where('what_is_your_age IN(?)',param_value).transaction_data_1_year

        @respondentsagegroup1824=@respondentsagegroup1824.where(' what_is_your_age IN(?)',param_value).all
        @respondentsagegroup2534=@respondentsagegroup2534.where('what_is_your_age IN(?)',param_value).all
        @respondentsagegroup3544=@respondentsagegroup3544.where('what_is_your_age IN(?)',param_value).all
        @respondentsagegroup4554=@respondentsagegroup4554.where(' what_is_your_age IN(?)',param_value).all
        @respondentsagegroup5565=@respondentsagegroup5565.where('what_is_your_age IN(?)',param_value).all
        @respondentsagegroupmore65=@respondentsagegroupmore65.where(' what_is_your_age IN(?)',param_value).all
        @webportal=@webportal.where('what_is_your_age IN(?)',param_value).all
        @Rooffice=@Rooffice.where('what_is_your_age IN(?)',param_value).all
        @gendermale=@gendermale.where('what_is_your_age IN(?)',param_value).all
       @genderfemale=@genderfemale.where('what_is_your_age IN(?)',param_value).all
       @individual=@individual.where('what_is_your_age IN(?)',param_value).all
        @customer_type = @daterange.pluck(:what_is_customer_suits_you).uniq
        @registrationmedium = @daterange.pluck(:where_did_you_register_your_worker).uniq
       @company=@company.where(' what_is_your_age IN(?)',param_value).all
       @agent=@agent.where(' what_is_your_age IN(?)',param_value).all  
       
        @facebook=@facebook.where('what_is_your_age IN(?)',param_value).all
        @twitter=@twitter.where('what_is_your_age IN(?)',param_value).all
        @instagram=@instagram.where('what_is_your_age IN(?)',param_value).all
        @telegram=@telegram.where('what_is_your_age IN(?)',param_value).all
        @OtherSM=@OtherSM.where('what_is_your_age IN(?)',param_value).all
       
        @operatingsocial=@operatingsocial.where('what_is_your_age IN(?)',param_value).all
        @operatingsocialNo=@operatingsocialNo.where('what_is_your_age IN(?)',param_value).all
        @health_awareness=@health_awareness.where('what_is_your_age IN(?)',param_value).all
        @health_awarenessNo=@health_awarenessNo.where('what_is_your_age IN(?)',param_value).all
        @moh_moha=@moh_moha.where('what_is_your_age IN(?)',param_value).all
        @moh_mohaNo=@moh_mohaNo.where('what_is_your_age IN(?)',param_value).all
        
         #employee reg webportal and reg office
        @employeeregweb1=@employeeregweb1.where("what_is_your_age IN(?)",param_value).all
        @employeeregweb2=@employeeregweb2.where("what_is_your_age IN(?)",param_value).all
        @employeeregweb3=@employeeregweb3.where("what_is_your_age IN(?)",param_value).all
        @employeeregweb4=@employeeregweb4.where("what_is_your_age IN(?)",param_value).all
        @employeeregweb5=@employeeregweb5.where("what_is_your_age IN(?)",param_value).all

        #@employeeregweball= (@employeeregweb1*1)+(@employeeregweb2*2)+(@employeeregweb3*3)+(@employeeregweb4*4)+(@employeeregweb5*5)
        #@employeeregweballcount=@employeeregweb1+@employeeregweb2+@employeeregweb3+@employeeregweb4+@employeeregweb5
        #if(@employeeregweballcount>0)
        #@employeeregweballsum=@employeeregweball/@employeeregweballcount
        #else
        #   @employeeregweballsum=0
        #end

        @employeeregreg1=@employeeregreg1.where("what_is_your_age IN(?)",param_value).all
        @employeeregreg2=@employeeregreg2.where("what_is_your_age IN(?)",param_value).all
        @employeeregreg3=@employeeregreg3.where("what_is_your_age IN(?)",param_value).all
        @employeeregreg4=@employeeregreg4.where("what_is_your_age IN(?)",param_value).all
        @employeeregreg5=@employeeregreg5.where("what_is_your_age IN(?)",param_value).all


        #@employeeregregall= (@employeeregreg1*1)+(@employeeregreg2*2)+(@employeeregreg3*3)+(@employeeregreg4*4)+(@employeeregreg5*5)
        #@employeeregregcount=@employeeregreg1+@employeeregreg2+@employeeregreg3+@employeeregreg4+@employeeregreg5
        #if(@employeeregregcount>0)
        #@employeeregregsum=@employeeregregall/@employeeregregcount
        #else
        #   @employeeregregsum=0
        #end

           #worker reg webportal and reg office
        @workerregweb1=@workerregweb1.where("what_is_your_age IN(?)",param_value).all
        @workerregweb2=@workerregweb2.where("what_is_your_age IN(?)",param_value).all
        @workerregweb3=@workerregweb3.where("what_is_your_age IN(?)",param_value).all
        @workerregweb4=@workerregweb4.where("what_is_your_age IN(?)",param_value).all
        @workerregweb5=@workerregweb5.where("what_is_your_age IN(?)",param_value).all

        #@workerregweball= (@workerregweb1*1)+(@workerregweb2*2)+(@workerregweb3*3)+(@workerregweb4*4)+(@workerregweb5*5)
        #@workerregweballcount=@workerregweb1+@workerregweb2+@workerregweb3+@workerregweb4+@workerregweb5
        #if(@workerregweballcount>0)
        #@workerregweballsum=@workerregweball/@workerregweballcount
        #else
        #   @workerregweballsum=0
        #end

        @workerregreg1=@workerregreg1.where("what_is_your_age IN(?)",param_value).all
        @workerregreg2=@workerregreg2.where("what_is_your_age IN(?)",param_value).all
        @workerregreg3=@workerregreg3.where("what_is_your_age IN(?)",param_value).all
        @workerregreg4=@workerregreg4.where("what_is_your_age IN(?)",param_value).all
        @workerregreg5=@workerregreg5.where("what_is_your_age IN(?)",param_value).all


        #@workerregregall= (@workerregreg1*1)+(@workerregreg2*2)+(@workerregreg3*3)+(@workerregreg4*4)+(@workerregreg5*5)
        #@workerregregcount=@workerregreg1+@workerregreg2+@workerregreg3+@workerregreg4+@workerregreg5
        #if(@workerregregcount>0)
        #@workerregregsum=@workerregregall/@workerregregcount
        # else
        #   @workerregregsum=0
        #end

        #panel clinic reg webportal and reg office
        @panelregweb1=@panelregweb1.where("what_is_your_age IN(?)",param_value).all
        @panelregweb2=@panelregweb2.where("what_is_your_age IN(?)",param_value).all
        @panelregweb3=@panelregweb3.where("what_is_your_age IN(?)",param_value).all
        @panelregweb4=@panelregweb4.where("what_is_your_age IN(?)",param_value).all
        @panelregweb5=@panelregweb5.where("what_is_your_age IN(?)",param_value).all

        #@panelregweball= (@panelregweb1*1)+(@panelregweb2*2)+(@panelregweb3*3)+(@panelregweb4*4)+(@panelregweb5*5)
        #@panelregweballcount=@panelregweb1+@panelregweb2+@panelregweb3+@panelregweb4+@panelregweb5
        #if(@panelregweballcount>0)
        #@panelregweballsum=@panelregweball/@panelregweballcount
        # else
        #   @panelregweballsum=0
        #end

        @panelregreg1=@panelregreg1.where("what_is_your_age IN(?)",param_value).all
        @panelregreg2=@panelregreg2.where("what_is_your_age IN(?)",param_value).all
        @panelregreg3=@panelregreg3.where("what_is_your_age IN(?)",param_value).all
        @panelregreg4=@panelregreg4.where("what_is_your_age IN(?)",param_value).all
        @panelregreg5=@panelregreg5.where("what_is_your_age IN(?)",param_value).all


        #@panelregregall= (@panelregreg1*1)+(@panelregreg2*2)+(@panelregreg3*3)+(@panelregreg4*4)+(@panelregreg5*5)
        #@panelregregcount=@panelregreg1+@panelregreg2+@panelregreg3+@panelregreg4+@panelregreg5
        #if(@panelregregcount>0)
        #@panelregregsum=@panelregregall/@panelregregcount
        #else
        #   @panelregregsum=0
        #end

        #overall reg webportal and reg office
        @overallregweb1=@overallregweb1.where("what_is_your_age IN(?)",param_value).all
        @overallregweb2=@overallregweb2.where("what_is_your_age IN(?)",param_value).all
        @overallregweb3=@overallregweb3.where("what_is_your_age IN(?)",param_value).all
        @overallregweb4=@overallregweb4.where("what_is_your_age IN(?)",param_value).all
        @overallregweb5=@overallregweb5.where("what_is_your_age IN(?)",param_value).all

        #@overallregweball= (@overallregweb1*1)+(@overallregweb2*2)+(@overallregweb3*3)+(@overallregweb4*4)+(@overallregweb5*5)
        #@overallregweballcount=@overallregweb1+@overallregweb2+@overallregweb3+@overallregweb4+@overallregweb5
        #if(@overallregweballcount>0)
        #@overallregweballsum=@overallregweball/@overallregweballcount
        #else
        #   @overallregweballsum=0
        #end

        @overallregreg1=@overallregreg1.where("what_is_your_age IN(?)",param_value).all
        @overallregreg2=@overallregreg2.where("what_is_your_age IN(?)",param_value).all
        @overallregreg3=@overallregreg3.where("what_is_your_age IN(?)",param_value).all
        @overallregreg4=@overallregreg4.where("what_is_your_age IN(?)",param_value).all
        @overallregreg5=@overallregreg5.where("what_is_your_age IN(?)",param_value).all


        #@overallregregall= (@overallregreg1*1)+(@overallregreg2*2)+(@overallregreg3*3)+(@overallregreg4*4)+(@overallregreg5*5)
        #@overallregregcount=@overallregreg1+@overallregreg2+@overallregreg3+@overallregreg4+@overallregreg5
        #if(@overallregregcount>0)
        #@overallregregsum=@overallregregall/@overallregregcount
        #else
        #   @overallregregsum=0
        #end

        @appealworkerstatus=@appealworkerstatus.where('what_is_your_age IN(?)',param_value).all
        @appealworkerstatusNo=@appealworkerstatusNo.where('what_is_your_age IN(?)',param_value).all
        @appealundergostatus=@appealundergostatus.where('what_is_your_age IN(?)',param_value).all
        @appealundergostatusNo=@appealundergostatusNo.where('what_is_your_age IN(?)',param_value).all
        @appealoverall1=  @appealoverall1.where('what_is_your_age IN(?)',param_value).all
        @appealoverall2=  @appealoverall2.where('what_is_your_age IN(?)',param_value).all
        @appealoverall3=  @appealoverall3.where('what_is_your_age IN(?)',param_value).all
        @appealoverall4=  @appealoverall4.where('what_is_your_age IN(?)',param_value).all
        @appealoverall5=  @appealoverall5.where('what_is_your_age IN(?)',param_value).all
        #@appealoverall= (@appealoverall1*1)+(@appealoverall2*2)+(@appealoverall3*3)+(@appealoverall4*4)+(@appealoverall5*5)
        #@appealoverallcount=@appealoverall1+@appealoverall2+@appealoverall3+@appealoverall4+@appealoverall5
        #if(@appealoverallcount>0)
        #@appealoverallsum=@appealoverall/@appealoverallcount
        #else
        #   @appealoverallsum=0
        #end


         #NPS registration web portal
        @NPSregweb1=@NPSregweb1.where("what_is_your_age IN(?)",param_value).all
        @NPSregweb2=@NPSregweb2.where("what_is_your_age IN(?)",param_value).all
        @NPSregweb3=@NPSregweb3.where("what_is_your_age IN(?)",param_value).all
        @NPSregweb4=@NPSregweb4.where("what_is_your_age IN(?)",param_value).all
        @NPSregweb5=@NPSregweb5.where("what_is_your_age IN(?)",param_value).all

        #@NPSregweball= (@NPSregweb1*1)+(@NPSregweb2*2)+(@NPSregweb3*3)+(@NPSregweb4*4)+(@NPSregweb5*5)
        #@NPSregwebpromoters=@NPSregweb4+@NPSregweb5
        #@NPSregwebdectoters=@NPSregweb1+@NPSregweb2
        #if(@NPSregweball>0)
        #@NPSwebpercentagepromoters=(@NPSregwebpromoters*100/@NPSregweball)
        #@NPSwebpercentagedectaters=(@NPSregwebdectoters*100/@NPSregweball)
        #@NPSoverallpercentage=@NPSwebpercentagepromoters-@NPSwebpercentagedectaters
        #else
        #   @NPSoverallpercentage=0
        #end
        #NPS registration regional office
        @NPSregreg1=@NPSregreg1.where("what_is_your_age IN(?)",param_value).all
        @NPSregreg2=@NPSregreg2.where("what_is_your_age IN(?)",param_value).all
        @NPSregreg3=@NPSregreg3.where("what_is_your_age IN(?)",param_value).all
        @NPSregreg4=@NPSregreg4.where("what_is_your_age IN(?)",param_value).all
        @NPSregreg5=@NPSregreg5.where("what_is_your_age IN(?)",param_value).all

        #@NPSregregall= (@NPSregreg1*1)+(@NPSregreg2*2)+(@NPSregreg3*3)+(@NPSregreg4*4)+(@NPSregreg5*5)
        #@NPSregregpromoters=@NPSregreg4+@NPSregreg5
        #@NPSregregdectoters=@NPSregreg1+@NPSregreg2
        #if(@NPSregregall>0)
        #@NPSregpercentagepromoters=(@NPSregregpromoters*100/@NPSregregall)
        #@NPSregpercentagedectaters=(@NPSregregdectoters*100/@NPSregregall)
        #@NPSregoverallpercentage=@NPSregpercentagepromoters-@NPSregpercentagedectaters
        #else
        #   @NPSregoverallpercentage=0
        #end
        #NPS Examination services
        @NPSExs1=@NPSExs1.where("what_is_your_age IN(?)",param_value).all
        @NPSExs2=@NPSExs2.where("what_is_your_age IN(?)",param_value).all
        @NPSExs3=@NPSExs3.where("what_is_your_age IN(?)",param_value).all
        @NPSExs4=@NPSExs4.where("what_is_your_age IN(?)",param_value).all
        @NPSExs5=@NPSExs5.where("what_is_your_age IN(?)",param_value).all

        #@NPSExsall= (@NPSExs1*1)+(@NPSExs2*2)+(@NPSExs3*3)+(@NPSExs4*4)+(@NPSExs5*5)
        #@NPSExspromoters=@NPSExs4+@NPSExs5
        #@NPSExsdectoters=@NPSExs1+@NPSExs2
        #if(@NPSExsall>0)
        #   @NPSExspercentagepromoters=(@NPSExspromoters*100/@NPSExsall)
        #   @NPSExspercentagedectaters=(@NPSExsdectoters*100/@NPSExsall)
        #   @NPSExsoverallpercentage=@NPSExspercentagepromoters-@NPSExspercentagedectaters
        #else
        #   @NPSExsoverallpercentage=0
        #end
          #NPS appeal process
        @NPSappeal1=@NPSappeal1.where("what_is_your_age IN(?)",param_value).all
        @NPSappeal2=@NPSappeal2.where("what_is_your_age IN(?)",param_value).all
        @NPSappeal3=@NPSappeal3.where("what_is_your_age IN(?)",param_value).all
        @NPSappeal4=@NPSappeal4.where("what_is_your_age IN(?)",param_value).all
        @NPSappeal5=@NPSappeal5.where("what_is_your_age IN(?)",param_value).all

        #@NPSappealall= (@NPSappeal1*1)+(@NPSappeal2*2)+(@NPSappeal3*3)+(@NPSappeal4*4)+(@NPSappeal5*5)
        #@NPSappealpromoters=@NPSappeal4+@NPSappeal5
        #@NPSappealdectoters=@NPSappeal1+@NPSappeal2
        #if(@NPSappealall>0)
        #   @NPSappealpercentagepromoters=(@NPSappealpromoters*100/@NPSappealall)
        #   @NPSappealpercentagedectaters=(@NPSappealdectoters*100/@NPSappealall)
        #   @NPSappealoverallpercentage=@NPSappealpercentagepromoters-@NPSappealpercentagedectaters
        #else
        #   @NPSappealoverallpercentage=0
        #end

       #NPS Average services
       #if(@NPSoverallpercentage>0)
       #@NpsAveragescore=(@NPSoverallpercentage+@NPSregoverallpercentage+@NPSExsoverallpercentage+@NPSExsoverallpercentage)
      #@NPSavgscore=@NpsAveragescore/4
       #else
       # @NPSavgscore=0
       #end

        @panelclinic1=@panelclinic1.where("what_is_your_age IN(?)",param_value).all
        @panelclinic2=@panelclinic2.where("what_is_your_age IN(?)",param_value).all
        @panelclinic3=@panelclinic3.where("what_is_your_age IN(?)",param_value).all
        @panelclinic4=@panelclinic4.where("what_is_your_age IN(?)",param_value).all
        @panelclinic5=@panelclinic5.where("what_is_your_age IN(?)",param_value).all


        #@panelclinic1all= (@panelclinic1*1)+(@panelclinic2*2)+(@panelclinic3*3)+(@panelclinic4*4)+(@panelclinic5*5)
        #@panelclinic1count=@panelclinic1+@panelclinic2+@panelclinic3+@panelclinic4+@panelclinic5
        #if(@panelclinic1all>0)
        #@panelclinics=@panelclinic1all/@panelclinic1count
        #else
        #   @panelclinics=0
        #end
        
        @understantable1=@understantable1.where("what_is_your_age IN(?)",param_value).all
        @understantable2=@understantable2.where("what_is_your_age IN(?)",param_value).all
        @understantable3=@understantable3.where("what_is_your_age IN(?)",param_value).all
        @understantable4=@understantable4.where("what_is_your_age IN(?)",param_value).all
        @understantable5=@understantable5.where("what_is_your_age IN(?)",param_value).all


        #@understantableall= (@understantable1*1)+(@understantable2*2)+(@understantable3*3)+(@understantable4*4)+(@understantable5*5)
        #@understantablecount=@understantable1+@understantable2+@understantable3+@understantable4+@understantable5
        #if(@understantableall>0)
        #@understantable=@understantableall/@understantablecount
        #else
        #   @understantable=0
        #end

        @obtainable1=@obtainable1.where("what_is_your_age IN(?)",param_value).all
        @obtainable2=@obtainable2.where("what_is_your_age IN(?)",param_value).all
        @obtainable3=@obtainable3.where("what_is_your_age IN(?)",param_value).all
        @obtainable4=@obtainable4.where("what_is_your_age IN(?)",param_value).all
        @obtainable5=@obtainable5.where("what_is_your_age IN(?)",param_value).all


        #@obtainableall= (@obtainable1*1)+(@obtainable2*2)+(@obtainable3*3)+(@obtainable4*4)+(@obtainable5*5)
        #@obtainablecount=@obtainable1+@obtainable2+@obtainable3+@obtainable4+@obtainable5
        #if(@obtainableall>0)
        #@obtainable=@obtainableall/@obtainablecount
        #else
        #   @obtainable=0
        #end

        @overallexp1=@overallexp1.where("what_is_your_age IN(?)",param_value).all
        @overallexp2=@overallexp2.where("what_is_your_age IN(?)",param_value).all
        @overallexp3=@overallexp3.where("what_is_your_age IN(?)",param_value).all
        @overallexp4=@overallexp4.where("what_is_your_age IN(?)",param_value).all
        @overallexp5=@overallexp5.where("what_is_your_age IN(?)",param_value).all


        #@overallexpall= (@overallexp1*1)+(@overallexp2*2)+(@overallexp3*3)+(@overallexp4*4)+(@overallexp5*5)
        #@overallexpcount=@overallexp1+@overallexp2+@overallexp3+@overallexp4+@overallexp5
        #if(@overallexpall>0)
        #@overallexp=@overallexpall/@overallexpcount
        #else
        #   @overallexp=0
        #end

        end
     when "gender"
        if param_value.present?
        @transaction_line_cahrt = @daterange.where('what_is_your_gender IN(?)',param_value).transaction_data_1_year

        @respondentsagegroup1824=@respondentsagegroup1824.where('what_is_your_gender IN(?)',param_value).all
        @respondentsagegroup2534=@respondentsagegroup2534.where(' what_is_your_gender IN(?)',param_value).all
        @respondentsagegroup3544=@respondentsagegroup3544.where('what_is_your_gender IN(?)',param_value).all
        @respondentsagegroup4554=@respondentsagegroup4554.where('what_is_your_gender IN(?)',param_value).all
        @respondentsagegroup5565=@respondentsagegroup5565.where('what_is_your_gender IN(?)',param_value).all
        @respondentsagegroupmore65=@respondentsagegroupmore65.where('what_is_your_gender IN(?)',param_value).all
        @webportal=@webportal.where('what_is_your_gender IN(?)',param_value).all
        @Rooffice=@Rooffice.where('what_is_your_gender IN(?)',param_value).all
        @gendermale=@gendermale.where('what_is_your_gender IN(?)',param_value).all
       @genderfemale=@genderfemale.where('what_is_your_gender IN(?)',param_value).all
       @individual=@individual.where('what_is_your_gender IN(?)',param_value).all
        
       @company=@company.where('what_is_your_gender IN(?)',param_value).all
       @agent=@agent.where('what_is_your_gender IN(?)',param_value).all  
       
        @facebook=@facebook.where('what_is_your_gender IN(?)',param_value).all
        @twitter=@twitter.where('what_is_your_gender IN(?)',param_value).all
        @instagram=@instagram.where('what_is_your_gender IN(?)',param_value).all
        @telegram=@telegram.where('what_is_your_gender IN(?)',param_value).all
        @OtherSM=@OtherSM.where('what_is_your_gender IN(?)',param_value).all
       
        @operatingsocial=@operatingsocial.where('what_is_your_gender IN(?)',param_value).all
        @operatingsocialNo=@operatingsocialNo.where('what_is_your_gender IN(?)',param_value).all
        @health_awareness=@health_awareness.where('what_is_your_gender IN(?)',param_value).all
        @health_awarenessNo=@health_awarenessNo.where('what_is_your_gender IN(?)',param_value).all
        @moh_moha=@moh_moha.where('what_is_your_gender IN(?)',param_value).all
        @moh_mohaNo=@moh_mohaNo.where('what_is_your_gender IN(?)',param_value).all
        
        #employee reg webportal and reg office
        @employeeregweb1=@employeeregweb1.where("what_is_your_gender IN(?)",param_value).all
        @employeeregweb2=@employeeregweb2.where("what_is_your_gender IN(?)",param_value).all
        @employeeregweb3=@employeeregweb3.where("what_is_your_gender IN(?)",param_value).all
        @employeeregweb4=@employeeregweb4.where("what_is_your_gender IN(?)",param_value).all
        @employeeregweb5=@employeeregweb5.where("what_is_your_gender IN(?)",param_value).all

        #@employeeregweball= (@employeeregweb1*1)+(@employeeregweb2*2)+(@employeeregweb3*3)+(@employeeregweb4*4)+(@employeeregweb5*5)
        #@employeeregweballcount=@employeeregweb1+@employeeregweb2+@employeeregweb3+@employeeregweb4+@employeeregweb5
        #if(@employeeregweballcount>0)
        #@employeeregweballsum=@employeeregweball/@employeeregweballcount
        #else
        #   @employeeregweballsum=0
        #end

        @employeeregreg1=@employeeregreg1.where("what_is_your_gender IN(?)",param_value).all
        @employeeregreg2=@employeeregreg2.where("what_is_your_gender IN(?)",param_value).all
        @employeeregreg3=@employeeregreg3.where("what_is_your_gender IN(?)",param_value).all
        @employeeregreg4=@employeeregreg4.where("what_is_your_gender IN(?)",param_value).all
        @employeeregreg5=@employeeregreg5.where("what_is_your_gender IN(?)",param_value).all


        #@employeeregregall= (@employeeregreg1*1)+(@employeeregreg2*2)+(@employeeregreg3*3)+(@employeeregreg4*4)+(@employeeregreg5*5)
        #@employeeregregcount=@employeeregreg1+@employeeregreg2+@employeeregreg3+@employeeregreg4+@employeeregreg5
        #if(@employeeregregcount>0)
        #@employeeregregsum=@employeeregregall/@employeeregregcount
        #else
        #   @employeeregregsum=0
        #end

           #worker reg webportal and reg office
        @workerregweb1=@workerregweb1.where("what_is_your_gender IN(?)",param_value).all
        @workerregweb2=@workerregweb2.where("what_is_your_gender IN(?)",param_value).all
        @workerregweb3=@workerregweb3.where("what_is_your_gender IN(?)",param_value).all
        @workerregweb4=@workerregweb4.where("what_is_your_gender IN(?)",param_value).all
        @workerregweb5=@workerregweb5.where("what_is_your_gender IN(?)",param_value).all

        #@workerregweball= (@workerregweb1*1)+(@workerregweb2*2)+(@workerregweb3*3)+(@workerregweb4*4)+(@workerregweb5*5)
        #@workerregweballcount=@workerregweb1+@workerregweb2+@workerregweb3+@workerregweb4+@workerregweb5
        #if(@workerregweballcount>0)
        #@workerregweballsum=@workerregweball/@workerregweballcount
        #else
        #   @workerregweballsum=0
        #end
        @workerregreg1=@workerregreg1.where("what_is_your_gender IN(?)",param_value).all
        @workerregreg2=@workerregreg2.where("what_is_your_gender IN(?)",param_value).all
        @workerregreg3=@workerregreg3.where("what_is_your_gender IN(?)",param_value).all
        @workerregreg4=@workerregreg4.where("what_is_your_gender IN(?)",param_value).all
        @workerregreg5=@workerregreg5.where("what_is_your_gender IN(?)",param_value).all


        #@workerregregall= (@workerregreg1*1)+(@workerregreg2*2)+(@workerregreg3*3)+(@workerregreg4*4)+(@workerregreg5*5)
        #@workerregregcount=@workerregreg1+@workerregreg2+@workerregreg3+@workerregreg4+@workerregreg5
        #if(@workerregregcount>0)
        #@workerregregsum=@workerregregall/@workerregregcount
        #else
        #   @workerregregsum=0
        #end
        #panel clinic reg webportal and reg office
        @panelregweb1=@panelregweb1.where("what_is_your_gender IN(?)",param_value).all
        @panelregweb2=@panelregweb2.where("what_is_your_gender IN(?)",param_value).all
        @panelregweb3=@panelregweb3.where("what_is_your_gender IN(?)",param_value).all
        @panelregweb4=@panelregweb4.where("what_is_your_gender IN(?)",param_value).all
        @panelregweb5=@panelregweb5.where("what_is_your_gender IN(?)",param_value).all

        #@panelregweball= (@panelregweb1*1)+(@panelregweb2*2)+(@panelregweb3*3)+(@panelregweb4*4)+(@panelregweb5*5)
        #@panelregweballcount=@panelregweb1+@panelregweb2+@panelregweb3+@panelregweb4+@panelregweb5
        #if(@panelregweballcount>0)
        #@panelregweballsum=@panelregweball/@panelregweballcount
        #else
        #   @panelregweballsum=0
        #end

        @panelregreg1=@panelregreg1.where("what_is_your_gender IN(?)",param_value).all
        @panelregreg2=@panelregreg2.where("what_is_your_gender IN(?)",param_value).all
        @panelregreg3=@panelregreg3.where("what_is_your_gender IN(?)",param_value).all
        @panelregreg4=@panelregreg4.where("what_is_your_gender IN(?)",param_value).all
        @panelregreg5=@panelregreg5.where("what_is_your_gender IN(?)",param_value).all


        #@panelregregall= (@panelregreg1*1)+(@panelregreg2*2)+(@panelregreg3*3)+(@panelregreg4*4)+(@panelregreg5*5)
        #@panelregregcount=@panelregreg1+@panelregreg2+@panelregreg3+@panelregreg4+@panelregreg5
        #if(@panelregregcount>0)
        #@panelregregsum=@panelregregall/@panelregregcount
        #else
        #   @panelregregsum=0
        #end

        #overall reg webportal and reg office
        @overallregweb1=@overallregweb1.where(" what_is_your_gender IN(?)",param_value).all
        @overallregweb2=@overallregweb2.where("what_is_your_gender IN(?)",param_value).all
        @overallregweb3=@overallregweb3.where("what_is_your_gender IN(?)",param_value).all
        @overallregweb4=@overallregweb4.where("what_is_your_gender IN(?)",param_value).all
        @overallregweb5=@overallregweb5.where("what_is_your_gender IN(?)",param_value).all

        #@overallregweball= (@overallregweb1*1)+(@overallregweb2*2)+(@overallregweb3*3)+(@overallregweb4*4)+(@overallregweb5*5)
        #@overallregweballcount=@overallregweb1+@overallregweb2+@overallregweb3+@overallregweb4+@overallregweb5
        #if(@overallregweballcount>0)
        #@overallregweballsum=@overallregweball/@overallregweballcount
        #else
        #   @overallregweballsum=0
        #end
        @overallregreg1=@overallregreg1.where("what_is_your_gender IN(?)",param_value).all
        @overallregreg2=@overallregreg2.where("what_is_your_gender IN(?)",param_value).all
        @overallregreg3=@overallregreg3.where("what_is_your_gender IN(?)",param_value).all
        @overallregreg4=@overallregreg4.where("what_is_your_gender IN(?)",param_value).all
        @overallregreg5=@overallregreg5.where("what_is_your_gender IN(?)",param_value).all


        #@overallregregall= (@overallregreg1*1)+(@overallregreg2*2)+(@overallregreg3*3)+(@overallregreg4*4)+(@overallregreg5*5)
        #@overallregregcount=@overallregreg1+@overallregreg2+@overallregreg3+@overallregreg4+@overallregreg5
        #if(@overallregregcount>0)
        #@overallregregsum=@overallregregall/@overallregregcount
        #else
        #   @overallregregsum=0
        #end

        @appealworkerstatus=@appealworkerstatus.where('what_is_your_gender IN(?)',param_value).all
        @appealworkerstatusNo=@appealworkerstatusNo.where('what_is_your_gender IN(?)',param_value).all
        @appealundergostatus=@appealundergostatus.where('what_is_your_gender IN(?)',param_value).all
        @appealundergostatusNo=@appealundergostatusNo.where('what_is_your_gender IN(?)',param_value).all
        @appealoverall1=  @appealoverall1.where('what_is_your_gender IN(?)',param_value).all
        @appealoverall2=  @appealoverall2.where('what_is_your_gender IN(?)',param_value).all
        @appealoverall3=  @appealoverall3.where('what_is_your_gender IN(?)',param_value).all
        @appealoverall4=  @appealoverall4.where('what_is_your_gender IN(?)',param_value).all
        @appealoverall5=  @appealoverall5.where('what_is_your_gender IN(?)',param_value).all
        #@appealoverall= (@appealoverall1*1)+(@appealoverall2*2)+(@appealoverall3*3)+(@appealoverall4*4)+(@appealoverall5*5)
        #@appealoverallcount=@appealoverall1+@appealoverall2+@appealoverall3+@appealoverall4+@appealoverall5
        #if(@appealoverallcount>0)
        #@appealoverallsum=@appealoverall/@appealoverallcount
        #else
        #   @appealoverallsum=0
        #end

        #NPS registration web portal
        @NPSregweb1=@NPSregweb1.where("what_is_your_gender IN(?)",param_value).all
        @NPSregweb2=@NPSregweb2.where("what_is_your_gender IN(?)",param_value).all
        @NPSregweb3=@NPSregweb3.where("what_is_your_gender IN(?)",param_value).all
        @NPSregweb4=@NPSregweb4.where("what_is_your_gender IN(?)",param_value).all
        @NPSregweb5=@NPSregweb5.where("what_is_your_gender IN(?)",param_value).all

        #@NPSregweball= (@NPSregweb1*1)+(@NPSregweb2*2)+(@NPSregweb3*3)+(@NPSregweb4*4)+(@NPSregweb5*5)
        #@NPSregwebpromoters=@NPSregweb4+@NPSregweb5
        #@NPSregwebdectoters=@NPSregweb1+@NPSregweb2
        #if(@NPSregweball>0)
        #@NPSwebpercentagepromoters=(@NPSregwebpromoters*100/@NPSregweball)
        #@NPSwebpercentagedectaters=(@NPSregwebdectoters*100/@NPSregweball)
        #@NPSoverallpercentage=@NPSwebpercentagepromoters-@NPSwebpercentagedectaters
        #else
        #   @NPSoverallpercentage=0
        #end
        #NPS registration regional office
        @NPSregreg1=@NPSregreg1.where("what_is_your_gender IN(?)",param_value).all
        @NPSregreg2=@NPSregreg2.where("what_is_your_gender IN(?)",param_value).all
        @NPSregreg3=@NPSregreg3.where("what_is_your_gender IN(?)",param_value).all
        @NPSregreg4=@NPSregreg4.where("what_is_your_gender IN(?)",param_value).all
        @NPSregreg5=@NPSregreg5.where("what_is_your_gender IN(?)",param_value).all

        #@NPSregregall= (@NPSregreg1*1)+(@NPSregreg2*2)+(@NPSregreg3*3)+(@NPSregreg4*4)+(@NPSregreg5*5)
        #@NPSregregpromoters=@NPSregreg4+@NPSregreg5
        #@NPSregregdectoters=@NPSregreg1+@NPSregreg2
        #if(@NPSregregall>0)
        #@NPSregpercentagepromoters=(@NPSregregpromoters*100/@NPSregregall)
        #@NPSregpercentagedectaters=(@NPSregregdectoters*100/@NPSregregall)
        #@NPSregoverallpercentage=@NPSregpercentagepromoters-@NPSregpercentagedectaters
        # else
        #   @NPSregoverallpercentage=0
        #end
        #NPS Examination services
        @NPSExs1=@NPSExs1.where("what_is_your_gender IN(?)",param_value).all
        @NPSExs2=@NPSExs2.where("what_is_your_gender IN(?)",param_value).all
        @NPSExs3=@NPSExs3.where("what_is_your_gender IN(?)",param_value).all
        @NPSExs4=@NPSExs4.where("what_is_your_gender IN(?)",param_value).all
        @NPSExs5=@NPSExs5.where("what_is_your_gender IN(?)",param_value).all

        #@NPSExsall= (@NPSExs1*1)+(@NPSExs2*2)+(@NPSExs3*3)+(@NPSExs4*4)+(@NPSExs5*5)
        #@NPSExspromoters=@NPSExs4+@NPSExs5
        #@NPSExsdectoters=@NPSExs1+@NPSExs2
        #if(@NPSExsall>0)
        #   @NPSExspercentagepromoters=(@NPSExspromoters*100/@NPSExsall)
        #   @NPSExspercentagedectaters=(@NPSExsdectoters*100/@NPSExsall)
        #   @NPSExsoverallpercentage=@NPSExspercentagepromoters-@NPSExspercentagedectaters
        #else
        #   @NPSExsoverallpercentage=0
        #end
         #NPS appeal process
        @NPSappeal1=@NPSappeal1.where("what_is_your_gender IN(?)",param_value).all
        @NPSappeal2=@NPSappeal2.where("what_is_your_gender IN(?)",param_value).all
        @NPSappeal3=@NPSappeal3.where("what_is_your_gender IN(?)",param_value).all
        @NPSappeal4=@NPSappeal4.where("what_is_your_gender IN(?)",param_value).all
        @NPSappeal5=@NPSappeal5.where("what_is_your_gender IN(?)",param_value).all

        #@NPSappealall= (@NPSappeal1*1)+(@NPSappeal2*2)+(@NPSappeal3*3)+(@NPSappeal4*4)+(@NPSappeal5*5)
        #@NPSappealpromoters=@NPSappeal4+@NPSappeal5
        #@NPSappealdectoters=@NPSappeal1+@NPSappeal2
        #if(@NPSappealall>0)
        #   @NPSappealpercentagepromoters=(@NPSappealpromoters*100/@NPSappealall)
        #   @NPSappealpercentagedectaters=(@NPSappealdectoters*100/@NPSappealall)
        #   @NPSappealoverallpercentage=@NPSappealpercentagepromoters-@NPSappealpercentagedectaters
        #else
        #   @NPSappealoverallpercentage=0
        #end

       #NPS Average services
       #if(@NPSoverallpercentage>0)
       #@NpsAveragescore=(@NPSoverallpercentage+@NPSregoverallpercentage+@NPSExsoverallpercentage+@NPSExsoverallpercentage)
      #@NPSavgscore=@NpsAveragescore/4
       #else
       # @NPSavgscore=0
       #end

                     @panelclinic1=@panelclinic1.where("what_is_your_gender IN(?)",param_value).all
        @panelclinic2=@panelclinic2.where("what_is_your_gender IN(?)",param_value).all
        @panelclinic3=@panelclinic3.where("what_is_your_gender IN(?)",param_value).all
        @panelclinic4=@panelclinic4.where("what_is_your_gender IN(?)",param_value).all
        @panelclinic5=@panelclinic5.where("what_is_your_gender IN(?)",param_value).all


        #@panelclinic1all= (@panelclinic1*1)+(@panelclinic2*2)+(@panelclinic3*3)+(@panelclinic4*4)+(@panelclinic5*5)
        #@panelclinic1count=@panelclinic1+@panelclinic2+@panelclinic3+@panelclinic4+@panelclinic5
        #if(@panelclinic1all>0)
        #@panelclinics=@panelclinic1all/@panelclinic1count
        #else
        #   @panelclinics=0
        #end
        
        @understantable1=@understantable1.where("what_is_your_gender IN(?)",param_value).all
        @understantable2=@understantable2.where("what_is_your_gender IN(?)",param_value).all
        @understantable3=@understantable3.where("what_is_your_gender IN(?)",param_value).all
        @understantable4=@understantable4.where("what_is_your_gender IN(?)",param_value).all
        @understantable5=@understantable5.where("what_is_your_gender IN(?)",param_value).all


        #@understantableall= (@understantable1*1)+(@understantable2*2)+(@understantable3*3)+(@understantable4*4)+(@understantable5*5)
        #@understantablecount=@understantable1+@understantable2+@understantable3+@understantable4+@understantable5
        #if(@understantableall>0)
        #@understantable=@understantableall/@understantablecount
        #else
        #   @understantable=0
        #end

        @obtainable1=@obtainable1.where("what_is_your_gender IN(?)",param_value).all
        @obtainable2=@obtainable2.where("what_is_your_gender IN(?)",param_value).all
        @obtainable3=@obtainable3.where("what_is_your_gender IN(?)",param_value).all
        @obtainable4=@obtainable4.where("what_is_your_gender IN(?)",param_value).all
        @obtainable5=@obtainable5.where("what_is_your_gender IN(?)",param_value).all


        #@obtainableall= (@obtainable1*1)+(@obtainable2*2)+(@obtainable3*3)+(@obtainable4*4)+(@obtainable5*5)
        #@obtainablecount=@obtainable1+@obtainable2+@obtainable3+@obtainable4+@obtainable5
        #if(@obtainableall>0)
        #@obtainable=@obtainableall/@obtainablecount
        #else
        #   @obtainable=0
        #end

        @overallexp1=@overallexp1.where("what_is_your_gender IN(?)",param_value).all
        @overallexp2=@overallexp2.where("what_is_your_gender IN(?)",param_value).all
        @overallexp3=@overallexp3.where("what_is_your_gender IN(?)",param_value).all
        @overallexp4=@overallexp4.where("what_is_your_gender IN(?)",param_value).all
        @overallexp5=@overallexp5.where("what_is_your_gender IN(?)",param_value).all


        #@overallexpall= (@overallexp1*1)+(@overallexp2*2)+(@overallexp3*3)+(@overallexp4*4)+(@overallexp5*5)
        #@overallexpcount=@overallexp1+@overallexp2+@overallexp3+@overallexp4+@overallexp5
        #if(@overallexpall>0)
        #@overallexp=@overallexpall/@overallexpcount
        #else
        #   @overallexp=0
        #end
        end
     
    @respondentsagegroup1824=@respondentsagegroup1824.count
    @respondentsagegroup2534=@respondentsagegroup2534.count
    @respondentsagegroup3544=@respondentsagegroup3544.count
    @respondentsagegroup4554=@respondentsagegroup4554.count
    @respondentsagegroup5565=@respondentsagegroup5565.count
    @respondentsagegroupmore65=@respondentsagegroupmore65.count
    @webportal=@webportal.count
    @Rooffice=@Rooffice.count
    @gendermale=@gendermale.count
    @genderfemale= @genderfemale.count
    @individual=@individual.count
    @customer_type= @customer_type.count
    @registrationmedium=@registrationmedium.count
    @company=@company.count
    @agent=@agent.count
    @facebook=@facebook.count
    @twitter=@twitter.count
    @instagram=@instagram.count
    @telegram=@telegram.count
    @OtherSM=@OtherSM.count
    @operatingsocial=@operatingsocial.count
    @operatingsocialNo=@operatingsocialNo.count
    @health_awareness=@health_awareness.count
    @health_awarenessNo= @health_awarenessNo.count
    @moh_moha=@moh_moha.count
    @moh_mohaNo=@moh_mohaNo.count
    @employeeregweb1=@employeeregweb1.count
    @employeeregweb2=@employeeregweb2.count
    @employeeregweb3= @employeeregweb3.count
    @employeeregweb4=@employeeregweb4.count
    @employeeregweb5=@employeeregweb5.count

    @employeeregweball= (@employeeregweb1*1)+(@employeeregweb2*2)+(@employeeregweb3*3)+(@employeeregweb4*4)+(@employeeregweb5*5)
    @employeeregweballcount=@employeeregweb1+@employeeregweb2+@employeeregweb3+@employeeregweb4+@employeeregweb5
    if(@employeeregweballcount>0)
    @employeeregweballsum=@employeeregweball/@employeeregweballcount
    else
    @employeeregweballsum=0
    end

    @employeeregreg1=@employeeregreg1.count
    @employeeregreg2=@employeeregreg2.count
    @employeeregreg3=@employeeregreg3.count
    @employeeregreg4=@employeeregreg4.count
    @employeeregreg5=@employeeregreg5.count

     @employeeregregall= (@employeeregreg1*1)+(@employeeregreg2*2)+(@employeeregreg3*3)+(@employeeregreg4*4)+(@employeeregreg5*5)
     @employeeregregcount=@employeeregreg1+@employeeregreg2+@employeeregreg3+@employeeregreg4+@employeeregreg5
     if(@employeeregregcount>0)
     @employeeregregsum=@employeeregregall/@employeeregregcount
     else
     @employeeregregsum=0
     end

     @workerregweb1=@workerregweb1.count
     @workerregweb2=@workerregweb2.count
     @workerregweb3=@workerregweb3.count
     @workerregweb4=@workerregweb4.count
     @workerregweb5=@workerregweb5.count

     @workerregweball= (@workerregweb1*1)+(@workerregweb2*2)+(@workerregweb3*3)+(@workerregweb4*4)+(@workerregweb5*5)
     @workerregweballcount=@workerregweb1+@workerregweb2+@workerregweb3+@workerregweb4+@workerregweb5
     if(@workerregweballcount>0)
     @workerregweballsum=@workerregweball/@workerregweballcount
     else
     @workerregweballsum=0
     end
     @workerregreg1=@workerregreg1.count
     @workerregreg2=@workerregreg2.count
     @workerregreg3=@workerregreg3.count
     @workerregreg4=@workerregreg4.count
     @workerregreg5=@workerregreg5.count

     @workerregregall= (@workerregreg1*1)+(@workerregreg2*2)+(@workerregreg3*3)+(@workerregreg4*4)+(@workerregreg5*5)
     @workerregregcount=@workerregreg1+@workerregreg2+@workerregreg3+@workerregreg4+@workerregreg5
     if(@workerregregcount>0)
     @workerregregsum=@workerregregall/@workerregregcount
     else
     @workerregregsum=0
     end

     @panelregweb1=@panelregweb1.count
     @panelregweb2=@panelregweb2.count
     @panelregweb3=@panelregweb3.count
     @panelregweb4=@panelregweb4.count
     @panelregweb5=@panelregweb5.count

     @panelregweball= (@panelregweb1*1)+(@panelregweb2*2)+(@panelregweb3*3)+(@panelregweb4*4)+(@panelregweb5*5)
     @panelregweballcount=@panelregweb1+@panelregweb2+@panelregweb3+@panelregweb4+@panelregweb5
     if(@panelregweballcount>0)
     @panelregweballsum=@panelregweball/@panelregweballcount
     else
     @panelregweballsum=0
     end

     @panelregreg1=@panelregreg1.count
     @panelregreg2=@panelregreg2.count
     @panelregreg3=@panelregreg3.count
     @panelregreg4=@panelregreg4.count
     @panelregreg5=@panelregreg5.count

      @panelregregall= (@panelregreg1*1)+(@panelregreg2*2)+(@panelregreg3*3)+(@panelregreg4*4)+(@panelregreg5*5)
      @panelregregcount=@panelregreg1+@panelregreg2+@panelregreg3+@panelregreg4+@panelregreg5
      if(@panelregregcount>0)
      @panelregregsum=@panelregregall/@panelregregcount
      else
      @panelregregsum=0
      end

      @overallregweb1=@overallregweb1.count
      @overallregweb2=@overallregweb2.count
      @overallregweb3=@overallregweb3.count
      @overallregweb4=@overallregweb4.count
      @overallregweb5=@overallregweb5.count

      @overallregweball= (@overallregweb1*1)+(@overallregweb2*2)+(@overallregweb3*3)+(@overallregweb4*4)+(@overallregweb5*5)
      @overallregweballcount=@overallregweb1+@overallregweb2+@overallregweb3+@overallregweb4+@overallregweb5
      if(@overallregweballcount>0)
      @overallregweballsum=@overallregweball/@overallregweballcount
      else
      @overallregweballsum=0
      end

       @overallregreg1= @overallregreg1.count
       @overallregreg2= @overallregreg2.count
       @overallregreg3= @overallregreg3.count
       @overallregreg4= @overallregreg4.count
       @overallregreg5= @overallregreg5.count

       @overallregregall= (@overallregreg1*1)+(@overallregreg2*2)+(@overallregreg3*3)+(@overallregreg4*4)+(@overallregreg5*5)
       @overallregregcount=@overallregreg1+@overallregreg2+@overallregreg3+@overallregreg4+@overallregreg5
       if(@overallregregcount>0)
       @overallregregsum=@overallregregall/@overallregregcount
       else
       @overallregregsum=0
       end

       @appealworkerstatus=@appealworkerstatus.count
       @appealworkerstatusNo=@appealworkerstatusNo.count
       @appealundergostatus=@appealundergostatus.count
       @appealundergostatusNo=@appealundergostatusNo.count
       @appealoverall1=@appealoverall1.count
       @appealoverall2=@appealoverall2.count
       @appealoverall3=@appealoverall3.count
       @appealoverall4=@appealoverall4.count
       @appealoverall5=@appealoverall5.count

        @appealoverall= (@appealoverall1*1)+(@appealoverall2*2)+(@appealoverall3*3)+(@appealoverall4*4)+(@appealoverall5*5)
        @appealoverallcount=@appealoverall1+@appealoverall2+@appealoverall3+@appealoverall4+@appealoverall5
        if(@appealoverallcount>0)
        @appealoverallsum=@appealoverall/@appealoverallcount
        else
           @appealoverallsum=0
        end

         @NPSregweb1= @NPSregweb1.count
         @NPSregweb2= @NPSregweb2.count
         @NPSregweb3= @NPSregweb3.count
         @NPSregweb4= @NPSregweb4.count
         @NPSregweb5= @NPSregweb5.count

         @NPSregweball= (@NPSregweb1*1)+(@NPSregweb2*2)+(@NPSregweb3*3)+(@NPSregweb4*4)+(@NPSregweb5*5)
        @NPSregwebpromoters=@NPSregweb4+@NPSregweb5
        @NPSregwebdectoters=@NPSregweb1+@NPSregweb2
        if(@NPSregweball>0)
        @NPSwebpercentagepromoters=(@NPSregwebpromoters*100/@NPSregweball)
        @NPSwebpercentagedectaters=(@NPSregwebdectoters*100/@NPSregweball)
        @NPSoverallpercentage=@NPSwebpercentagepromoters-@NPSwebpercentagedectaters
        else
           @NPSoverallpercentage=0
        end

        @NPSregreg1=@NPSregreg1.count
        @NPSregreg2=@NPSregreg2.count
        @NPSregreg3=@NPSregreg3.count
        @NPSregreg4=@NPSregreg4.count
        @NPSregreg5=@NPSregreg5.count

        @NPSregregall= (@NPSregreg1*1)+(@NPSregreg2*2)+(@NPSregreg3*3)+(@NPSregreg4*4)+(@NPSregreg5*5)
        @NPSregregpromoters=@NPSregreg4+@NPSregreg5
        @NPSregregdectoters=@NPSregreg1+@NPSregreg2
        if(@NPSregregall>0)
        @NPSregpercentagepromoters=(@NPSregregpromoters*100/@NPSregregall)
        @NPSregpercentagedectaters=(@NPSregregdectoters*100/@NPSregregall)
        @NPSregoverallpercentage=@NPSregpercentagepromoters-@NPSregpercentagedectaters
         else
           @NPSregoverallpercentage=0
        end
        @NPSExs1=@NPSExs1.count
        @NPSExs2=@NPSExs2.count
        @NPSExs3=@NPSExs3.count
        @NPSExs4=@NPSExs4.count
        @NPSExs5=@NPSExs5.count

        @NPSExsall= (@NPSExs1*1)+(@NPSExs2*2)+(@NPSExs3*3)+(@NPSExs4*4)+(@NPSExs5*5)
        @NPSExspromoters=@NPSExs4+@NPSExs5
        @NPSExsdectoters=@NPSExs1+@NPSExs2
        if(@NPSExsall>0)
           @NPSExspercentagepromoters=(@NPSExspromoters*100/@NPSExsall)
           @NPSExspercentagedectaters=(@NPSExsdectoters*100/@NPSExsall)
           @NPSExsoverallpercentage=@NPSExspercentagepromoters-@NPSExspercentagedectaters
        else
           @NPSExsoverallpercentage=0
        end

        @NPSappeal1=@NPSappeal1.count
        @NPSappeal2=@NPSappeal2.count
        @NPSappeal3=@NPSappeal3.count
        @NPSappeal4=@NPSappeal4.count
        @NPSappeal5=@NPSappeal5.count

        @NPSappealall= (@NPSappeal1*1)+(@NPSappeal2*2)+(@NPSappeal3*3)+(@NPSappeal4*4)+(@NPSappeal5*5)
        @NPSappealpromoters=@NPSappeal4+@NPSappeal5
        @NPSappealdectoters=@NPSappeal1+@NPSappeal2
        if(@NPSappealall>0)
           @NPSappealpercentagepromoters=(@NPSappealpromoters*100/@NPSappealall)
           @NPSappealpercentagedectaters=(@NPSappealdectoters*100/@NPSappealall)
           @NPSappealoverallpercentage=@NPSappealpercentagepromoters-@NPSappealpercentagedectaters
        else
           @NPSappealoverallpercentage=0
        end

       if(@NPSoverallpercentage>0)
       @NpsAveragescore=(@NPSoverallpercentage+@NPSregoverallpercentage+@NPSExsoverallpercentage+@NPSExsoverallpercentage)
      @NPSavgscore=@NpsAveragescore/4
      else
       @NPSavgscore=0
      end

      @panelclinic1=@panelclinic1.count
      @panelclinic2=@panelclinic2.count
      @panelclinic3=@panelclinic3.count
      @panelclinic4=@panelclinic4.count
      @panelclinic5=@panelclinic5.count

        @panelclinic1all= (@panelclinic1*1)+(@panelclinic2*2)+(@panelclinic3*3)+(@panelclinic4*4)+(@panelclinic5*5)
        @panelclinic1count=@panelclinic1+@panelclinic2+@panelclinic3+@panelclinic4+@panelclinic5
        if(@panelclinic1all>0)
        @panelclinics=@panelclinic1all/@panelclinic1count
        else
           @panelclinics=0
        end
         @understantable1= @understantable1.count
         @understantable2= @understantable2.count
         @understantable3= @understantable3.count
         @understantable4= @understantable4.count
          @understantable5= @understantable5.count
          @understantableall= (@understantable1*1)+(@understantable2*2)+(@understantable3*3)+(@understantable4*4)+(@understantable5*5)
        @understantablecount=@understantable1+@understantable2+@understantable3+@understantable4+@understantable5
        if(@understantableall>0)
        @understantable=@understantableall/@understantablecount
        else
           @understantable=0
        end
        @obtainable1=@obtainable1.count
        @obtainable2=@obtainable2.count
        @obtainable3=@obtainable3.count
        @obtainable4=@obtainable4.count
        @obtainable5=@obtainable5.count
        @obtainableall= (@obtainable1*1)+(@obtainable2*2)+(@obtainable3*3)+(@obtainable4*4)+(@obtainable5*5)
        @obtainablecount=@obtainable1+@obtainable2+@obtainable3+@obtainable4+@obtainable5
        if(@obtainableall>0)
        @obtainable=@obtainableall/@obtainablecount
        else
           @obtainable=0
        end
        @overallexp1=@overallexp1.count
        @overallexp2=@overallexp2.count
        @overallexp3=@overallexp3.count
        @overallexp4=@overallexp4.count
        @overallexp5=@overallexp5.count

        @overallexpall= (@overallexp1*1)+(@overallexp2*2)+(@overallexp3*3)+(@overallexp4*4)+(@overallexp5*5)
        @overallexpcount=@overallexp1+@overallexp2+@overallexp3+@overallexp4+@overallexp5
        if(@overallexpall>0)
        @overallexp=@overallexpall/@overallexpcount
        else
           @overallexp=0
        end
    end
    
   

    @transactions
    end

    def filterapply

      #@sectorids = params[:sector_id]
      #@linechart_data= Transaction.joins(:job_type).group('job_types.name').where("fw_job_type_id IN (?)",@sectorids.to_i).count.to_a
      sector_names = JobType.pluck(:id)
      selected_sector_names = params[:sector_id]

      @linechart_data = Transaction.joins(:job_type).group('job_types.name').where("job_types.id" => selected_sector_names).count.to_a
    end

    def filter
      params = JSON.parse(params.keys.first)
    end

    def convert_values_to_arrays(hash)
      converted_hash = {}

      hash.each_with_index do |(key, value), index|
        if index == 0
          converted_hash[key] = value
        else
          converted_hash[key] = value.split(',')
        end
      end

      converted_hash
    end
  end

end