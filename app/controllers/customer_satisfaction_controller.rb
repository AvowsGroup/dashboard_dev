class CustomerSatisfactionController < ApplicationController
  def index
    @job_type = JobType.all
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

    @understantable1 = SurveyMonkeyCustomer.where("'Fomema_medical_examincation_are_understandable'=?", '1').count
    @understantable2 = SurveyMonkeyCustomer.where("'Fomema_medical_examincation_are_understandable'=?", '2').count
    @understantable3 = SurveyMonkeyCustomer.where("'Fomema_medical_examincation_are_understandable'=?", '3').count
    @understantable4 = SurveyMonkeyCustomer.where("'Fomema_medical_examincation_are_understandable'=?", '4').count
    @understantable5 = SurveyMonkeyCustomer.where("'Fomema_medical_examincation_are_understandable'=?", '5').count

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
      @respondentsyear = SurveyMonkeyCustomer.where("extract(year from start_date) = ?", @current_year)
      @linechart_data = Transaction.joins(:job_type).group('job_types.name').count.to_a
    end
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
    @current_year = Date.today.year
    @transaction_line_chart = SurveyMonkeyCustomer.transaction_data_1_year
    @respondentsyear = SurveyMonkeyCustomer.where("extract(year from start_date) = ?", @current_year)
    @linechart_data = Transaction.joins(:job_type).group('job_types.name').count.to_a
    filter_params.each do |param_key, param_value|
      case param_key
      when "Sector"
        if param_value.present?
          sector_names = JobType.pluck(:name)
          sector_ids = JobType.where(name: param_value).pluck(:id)

          @linechart_data = Transaction.joins(:job_type).group('job_types.name').where('job_types.id' => param_value.split(",")).count.to_a
        end
      when "customer_type"
        if param_value.present?

          @transaction_line_chart = SurveyMonkeyCustomer.where('what_is_customer_suits_you IN(?)', param_value).transaction_data_1_year

          @respondentsagegroup1824 = SurveyMonkeyCustomer.where('what_is_your_age=? and what_is_customer_suits_you IN(?)', '18-24', param_value).pluck(:what_is_your_age).count
          @respondentsagegroup2534 = SurveyMonkeyCustomer.where('what_is_your_age=? and what_is_customer_suits_you IN(?)', '25-34', param_value).pluck(:what_is_your_age).count
          @respondentsagegroup3544 = SurveyMonkeyCustomer.where('what_is_your_age=? and what_is_customer_suits_you IN(?)', '35-44', param_value).pluck(:what_is_your_age).count
          @respondentsagegroup4554 = SurveyMonkeyCustomer.where('what_is_your_age=? and what_is_customer_suits_you IN(?)', '45-54', param_value).pluck(:what_is_your_age).count
          @respondentsagegroup5565 = SurveyMonkeyCustomer.where('what_is_your_age=? and what_is_customer_suits_you IN(?)', '55-65', param_value).pluck(:what_is_your_age).count
          @respondentsagegroupmore65 = SurveyMonkeyCustomer.where('what_is_your_age=? and what_is_customer_suits_you IN(?)', 'More than 65', param_value).pluck(:what_is_your_age).count
          @webportal = SurveyMonkeyCustomer.where('where_did_you_register_your_worker=? and what_is_customer_suits_you IN(?)', 'Web Portal', param_value).pluck(:where_did_you_register_your_worker).count
          @Rooffice = SurveyMonkeyCustomer.where('where_did_you_register_your_worker=? and what_is_customer_suits_you IN(?)', 'Regional Office', param_value).pluck(:where_did_you_register_your_worker).count
          @gendermale = SurveyMonkeyCustomer.where('what_is_your_gender=? and what_is_customer_suits_you IN(?)', 'Male', param_value).pluck(:what_is_your_gender).count
          @genderfemale = SurveyMonkeyCustomer.where('what_is_your_gender=? and what_is_customer_suits_you IN(?)', 'Female', param_value).pluck(:what_is_your_gender).count
          @individual = SurveyMonkeyCustomer.where('what_is_customer_suits_you=? and what_is_customer_suits_you IN(?)', 'Individual Employer', param_value).pluck(:what_is_customer_suits_you).count
          @customer_type = SurveyMonkeyCustomer.pluck(:what_is_customer_suits_you).uniq
          @registrationmedium = SurveyMonkeyCustomer.pluck(:where_did_you_register_your_worker).uniq
          @company = SurveyMonkeyCustomer.where('what_is_customer_suits_you=? and what_is_customer_suits_you IN(?)', 'Company Employer', param_value).pluck(:what_is_customer_suits_you).count
          @agent = SurveyMonkeyCustomer.where(' what_is_customer_suits_you=? and what_is_customer_suits_you IN(?)', 'Agent', param_value).pluck(:what_is_customer_suits_you).count

          @facebook = SurveyMonkeyCustomer.where('facebook=? and what_is_customer_suits_you IN(?)', 'Facebook', param_value).pluck(:facebook).count
          @twitter = SurveyMonkeyCustomer.where('twitter=? and what_is_customer_suits_you IN(?)', 'Twitter', param_value).pluck(:twitter).count
          @instagram = SurveyMonkeyCustomer.where('instagram=? and what_is_customer_suits_you IN(?)', 'Instagram', param_value).pluck(:instagram).count
          @telegram = SurveyMonkeyCustomer.where('telegram=? and what_is_customer_suits_you IN(?)', 'Telegram', param_value).pluck(:telegram).count
          @OtherSM = SurveyMonkeyCustomer.where('other_social!=? and what_is_customer_suits_you IN(?)', '', param_value).pluck(:other_social).count

          @operatingsocial = SurveyMonkeyCustomer.where('announcement_business_operator=? and what_is_customer_suits_you IN(?)', 'Yes', param_value).pluck(:announcement_business_operator).count
          @operatingsocialNo = SurveyMonkeyCustomer.where('announcement_business_operator=? and what_is_customer_suits_you IN(?)', 'No', param_value).pluck(:announcement_business_operator).count
          @health_awareness = SurveyMonkeyCustomer.where('delivering_health=? and what_is_customer_suits_you IN(?)', 'Yes', param_value).pluck(:delivering_health).count
          @health_awarenessNo = SurveyMonkeyCustomer.where('delivering_health=? and what_is_customer_suits_you IN(?)', 'No', param_value).pluck(:delivering_health).count
          @moh_moha = SurveyMonkeyCustomer.where('"aligned_info_moh_MOHA"=? and what_is_customer_suits_you IN(?)', 'Yes', param_value).pluck(:aligned_info_moh_MOHA).count
          @moh_mohaNo = SurveyMonkeyCustomer.where('"aligned_info_moh_MOHA"=? and what_is_customer_suits_you IN(?)', 'No', param_value).pluck(:aligned_info_moh_MOHA).count

          # employee reg webportal and reg office
          @employeeregweb1 = SurveyMonkeyCustomer.where("process_emp_reg=? and where_did_you_register_your_worker=? and what_is_customer_suits_you IN(?)", '1', 'Web Portal', param_value).count
          @employeeregweb2 = SurveyMonkeyCustomer.where("process_emp_reg=? and where_did_you_register_your_worker=? and what_is_customer_suits_you IN(?)", '2', 'Web Portal', param_value).count
          @employeeregweb3 = SurveyMonkeyCustomer.where("process_emp_reg=? and where_did_you_register_your_worker=? and what_is_customer_suits_you IN(?)", '3', 'Web Portal', param_value).count
          @employeeregweb4 = SurveyMonkeyCustomer.where("process_emp_reg=? and where_did_you_register_your_worker=? and what_is_customer_suits_you IN(?)", '4', 'Web Portal', param_value).count
          @employeeregweb5 = SurveyMonkeyCustomer.where("process_emp_reg=? and where_did_you_register_your_worker=? and what_is_customer_suits_you IN(?)", '5', 'Web Portal', param_value).count

          @employeeregweball = (@employeeregweb1 * 1) + (@employeeregweb2 * 2) + (@employeeregweb3 * 3) + (@employeeregweb4 * 4) + (@employeeregweb5 * 5)
          @employeeregweballcount = @employeeregweb1 + @employeeregweb2 + @employeeregweb3 + @employeeregweb4 + @employeeregweb5
          @employeeregweballsum = @employeeregweball / @employeeregweballcount

          @employeeregreg1 = SurveyMonkeyCustomer.where("process_emp_reg=? and where_did_you_register_your_worker=? and what_is_customer_suits_you IN(?)", '1', 'Regional Office', param_value).count
          @employeeregreg2 = SurveyMonkeyCustomer.where("process_emp_reg=? and where_did_you_register_your_worker=? and what_is_customer_suits_you IN(?)", '2', 'Regional Office', param_value).count
          @employeeregreg3 = SurveyMonkeyCustomer.where("process_emp_reg=? and where_did_you_register_your_worker=? and what_is_customer_suits_you IN(?)", '3', 'Regional Office', param_value).count
          @employeeregreg4 = SurveyMonkeyCustomer.where("process_emp_reg=? and where_did_you_register_your_worker=? and what_is_customer_suits_you IN(?)", '4', 'Regional Office', param_value).count
          @employeeregreg5 = SurveyMonkeyCustomer.where("process_emp_reg=? and where_did_you_register_your_worker=? and what_is_customer_suits_you IN(?)", '5', 'Regional Office', param_value).count

          @employeeregregall = (@employeeregreg1 * 1) + (@employeeregreg2 * 2) + (@employeeregreg3 * 3) + (@employeeregreg4 * 4) + (@employeeregreg5 * 5)
          @employeeregregcount = @employeeregreg1 + @employeeregreg2 + @employeeregreg3 + @employeeregreg4 + @employeeregreg5
          if (@employeeregregcount > 0)
            @employeeregregsum = @employeeregregall / @employeeregregcount
          else
            @employeeregregsum = 0
          end

          # worker reg webportal and reg office
          @workerregweb1 = SurveyMonkeyCustomer.where("process_worker_reg=? and where_did_you_register_your_worker=? and what_is_customer_suits_you IN(?)", '1', 'Web Portal', param_value).count
          @workerregweb2 = SurveyMonkeyCustomer.where("process_worker_reg=? and where_did_you_register_your_worker=? and what_is_customer_suits_you IN(?)", '2', 'Web Portal', param_value).count
          @workerregweb3 = SurveyMonkeyCustomer.where("process_worker_reg=? and where_did_you_register_your_worker=? and what_is_customer_suits_you IN(?)", '3', 'Web Portal', param_value).count
          @workerregweb4 = SurveyMonkeyCustomer.where("process_worker_reg=? and where_did_you_register_your_worker=? and what_is_customer_suits_you IN(?)", '4', 'Web Portal', param_value).count
          @workerregweb5 = SurveyMonkeyCustomer.where("process_worker_reg=? and where_did_you_register_your_worker=? and what_is_customer_suits_you IN(?)", '5', 'Web Portal', param_value).count

          @workerregweball = (@workerregweb1 * 1) + (@workerregweb2 * 2) + (@workerregweb3 * 3) + (@workerregweb4 * 4) + (@workerregweb5 * 5)
          @workerregweballcount = @workerregweb1 + @workerregweb2 + @workerregweb3 + @workerregweb4 + @workerregweb5
          if (@workerregweballcount > 0)
            @workerregweballsum = @workerregweball / @workerregweballcount
          else
            @workerregweballsum = 0
          end

          @workerregreg1 = SurveyMonkeyCustomer.where("process_worker_reg=? and where_did_you_register_your_worker=? and what_is_customer_suits_you IN(?)", '1', 'Regional Office', param_value).count
          @workerregreg2 = SurveyMonkeyCustomer.where("process_worker_reg=? and where_did_you_register_your_worker=? and what_is_customer_suits_you IN(?)", '2', 'Regional Office', param_value).count
          @workerregreg3 = SurveyMonkeyCustomer.where("process_worker_reg=? and where_did_you_register_your_worker=? and what_is_customer_suits_you IN(?)", '3', 'Regional Office', param_value).count
          @workerregreg4 = SurveyMonkeyCustomer.where("process_worker_reg=? and where_did_you_register_your_worker=? and what_is_customer_suits_you IN(?)", '4', 'Regional Office', param_value).count
          @workerregreg5 = SurveyMonkeyCustomer.where("process_worker_reg=? and where_did_you_register_your_worker=? and what_is_customer_suits_you IN(?)", '5', 'Regional Office', param_value).count

          @workerregregall = (@workerregreg1 * 1) + (@workerregreg2 * 2) + (@workerregreg3 * 3) + (@workerregreg4 * 4) + (@workerregreg5 * 5)
          @workerregregcount = @workerregreg1 + @workerregreg2 + @workerregreg3 + @workerregreg4 + @workerregreg5
          if (@workerregregcount > 0)
            @workerregregsum = @workerregregall / @workerregregcount
          else
            @workerregregsum = 0
          end

          # panel clinic reg webportal and reg office
          @panelregweb1 = SurveyMonkeyCustomer.where("panel_clinic_xray_facilities=? and where_did_you_register_your_worker=? and what_is_customer_suits_you IN(?)", '1', 'Web Portal', param_value).count
          @panelregweb2 = SurveyMonkeyCustomer.where("panel_clinic_xray_facilities=? and where_did_you_register_your_worker=? and what_is_customer_suits_you IN(?)", '2', 'Web Portal', param_value).count
          @panelregweb3 = SurveyMonkeyCustomer.where("panel_clinic_xray_facilities=? and where_did_you_register_your_worker=? and what_is_customer_suits_you IN(?)", '3', 'Web Portal', param_value).count
          @panelregweb4 = SurveyMonkeyCustomer.where("panel_clinic_xray_facilities=? and where_did_you_register_your_worker=? and what_is_customer_suits_you IN(?)", '4', 'Web Portal', param_value).count
          @panelregweb5 = SurveyMonkeyCustomer.where("panel_clinic_xray_facilities=? and where_did_you_register_your_worker=? and what_is_customer_suits_you IN(?)", '5', 'Web Portal', param_value).count

          @panelregweball = (@panelregweb1 * 1) + (@panelregweb2 * 2) + (@panelregweb3 * 3) + (@panelregweb4 * 4) + (@panelregweb5 * 5)
          @panelregweballcount = @panelregweb1 + @panelregweb2 + @panelregweb3 + @panelregweb4 + @panelregweb5
          if (@panelregweballcount > 0)
            @panelregweballsum = @panelregweball / @panelregweballcount
          else
            @panelregweballsum = 0
          end

          @panelregreg1 = SurveyMonkeyCustomer.where("panel_clinic_xray_facilities=? and where_did_you_register_your_worker=? and what_is_customer_suits_you IN(?)", '1', 'Regional Office', param_value).count
          @panelregreg2 = SurveyMonkeyCustomer.where("panel_clinic_xray_facilities=? and where_did_you_register_your_worker=? and what_is_customer_suits_you IN(?)", '2', 'Regional Office', param_value).count
          @panelregreg3 = SurveyMonkeyCustomer.where("panel_clinic_xray_facilities=? and where_did_you_register_your_worker=? and what_is_customer_suits_you IN(?)", '3', 'Regional Office', param_value).count
          @panelregreg4 = SurveyMonkeyCustomer.where("panel_clinic_xray_facilities=? and where_did_you_register_your_worker=? and what_is_customer_suits_you IN(?)", '4', 'Regional Office', param_value).count
          @panelregreg5 = SurveyMonkeyCustomer.where("panel_clinic_xray_facilities=? and where_did_you_register_your_worker=? and what_is_customer_suits_you IN(?)", '5', 'Regional Office', param_value).count

          @panelregregall = (@panelregreg1 * 1) + (@panelregreg2 * 2) + (@panelregreg3 * 3) + (@panelregreg4 * 4) + (@panelregreg5 * 5)
          @panelregregcount = @panelregreg1 + @panelregreg2 + @panelregreg3 + @panelregreg4 + @panelregreg5
          if (@panelregregcount > 0)
            @panelregregsum = @panelregregall / @panelregregcount
          else
            @panelregregsum = 0
          end

          # overall reg webportal and reg office
          @overallregweb1 = SurveyMonkeyCustomer.where("overall_experience_reg_process=? and where_did_you_register_your_worker=? and what_is_customer_suits_you IN(?)", '1', 'Web Portal', param_value).count
          @overallregweb2 = SurveyMonkeyCustomer.where("overall_experience_reg_process=? and where_did_you_register_your_worker=? and what_is_customer_suits_you IN(?)", '2', 'Web Portal', param_value).count
          @overallregweb3 = SurveyMonkeyCustomer.where("overall_experience_reg_process=? and where_did_you_register_your_worker=? and what_is_customer_suits_you IN(?)", '3', 'Web Portal', param_value).count
          @overallregweb4 = SurveyMonkeyCustomer.where("overall_experience_reg_process=? and where_did_you_register_your_worker=? and what_is_customer_suits_you IN(?)", '4', 'Web Portal', param_value).count
          @overallregweb5 = SurveyMonkeyCustomer.where("overall_experience_reg_process=? and where_did_you_register_your_worker=? and what_is_customer_suits_you IN(?)", '5', 'Web Portal', param_value).count

          @overallregweball = (@overallregweb1 * 1) + (@overallregweb2 * 2) + (@overallregweb3 * 3) + (@overallregweb4 * 4) + (@overallregweb5 * 5)
          @overallregweballcount = @overallregweb1 + @overallregweb2 + @overallregweb3 + @overallregweb4 + @overallregweb5
          if (@overallregweballcount > 0)
            @overallregweballsum = @overallregweball / @overallregweballcount
          else
            @overallregweballsum = 0
          end

          @overallregreg1 = SurveyMonkeyCustomer.where("overall_experience_reg_process=? and where_did_you_register_your_worker=? and what_is_customer_suits_you IN(?)", '1', 'Regional Office', param_value).count
          @overallregreg2 = SurveyMonkeyCustomer.where("overall_experience_reg_process=? and where_did_you_register_your_worker=? and what_is_customer_suits_you IN(?)", '2', 'Regional Office', param_value).count
          @overallregreg3 = SurveyMonkeyCustomer.where("overall_experience_reg_process=? and where_did_you_register_your_worker=? and what_is_customer_suits_you IN(?)", '3', 'Regional Office', param_value).count
          @overallregreg4 = SurveyMonkeyCustomer.where("overall_experience_reg_process=? and where_did_you_register_your_worker=? and what_is_customer_suits_you IN(?)", '4', 'Regional Office', param_value).count
          @overallregreg5 = SurveyMonkeyCustomer.where("overall_experience_reg_process=? and where_did_you_register_your_worker=? and what_is_customer_suits_you IN(?)", '5', 'Regional Office', param_value).count

          @overallregregall = (@overallregreg1 * 1) + (@overallregreg2 * 2) + (@overallregreg3 * 3) + (@overallregreg4 * 4) + (@overallregreg5 * 5)
          @overallregregcount = @overallregreg1 + @overallregreg2 + @overallregreg3 + @overallregreg4 + @overallregreg5
          if (@overallregregcount > 0)
            @overallregregsum = @overallregregall / @overallregregcount
          else
            @overallregregsum = 0
          end

          @appealworkerstatus = SurveyMonkeyCustomer.where('worker_status_found_medical_unsuitable=? and what_is_customer_suits_you IN(?)', 'Yes', param_value).pluck(:worker_status_found_medical_unsuitable).count
          @appealworkerstatusNo = SurveyMonkeyCustomer.where('worker_status_found_medical_unsuitable=? and what_is_customer_suits_you IN(?)', 'No', param_value).pluck(:worker_status_found_medical_unsuitable).count
          @appealundergostatus = SurveyMonkeyCustomer.where('undergo_fomema_appeal_process=? and what_is_customer_suits_you IN(?)', 'Yes', param_value).pluck(:undergo_fomema_appeal_process).count
          @appealundergostatusNo = SurveyMonkeyCustomer.where('undergo_fomema_appeal_process=? and what_is_customer_suits_you IN(?)', 'No', param_value).pluck(:undergo_fomema_appeal_process).count
          @appealoverall1 = SurveyMonkeyCustomer.where('tell_experience_appeal_process=? and what_is_customer_suits_you IN(?)', '1', param_value).pluck(:tell_experience_appeal_process).count
          @appealoverall2 = SurveyMonkeyCustomer.where('tell_experience_appeal_process=? and what_is_customer_suits_you IN(?)', '2', param_value).pluck(:tell_experience_appeal_process).count
          @appealoverall3 = SurveyMonkeyCustomer.where('tell_experience_appeal_process=? and what_is_customer_suits_you IN(?)', '3', param_value).pluck(:tell_experience_appeal_process).count
          @appealoverall4 = SurveyMonkeyCustomer.where('tell_experience_appeal_process=? and what_is_customer_suits_you IN(?)', '4', param_value).pluck(:tell_experience_appeal_process).count
          @appealoverall5 = SurveyMonkeyCustomer.where('tell_experience_appeal_process=? and what_is_customer_suits_you IN(?)', '5', param_value).pluck(:tell_experience_appeal_process).count

          @appealoverall = (@appealoverall1 * 1) + (@appealoverall2 * 2) + (@appealoverall3 * 3) + (@appealoverall4 * 4) + (@appealoverall5 * 5)
          @appealoverallcount = @appealoverall1 + @appealoverall2 + @appealoverall3 + @appealoverall4 + @appealoverall5
          if (@appealoverallcount > 0)
            @appealoverallsum = @appealoverall / @appealoverallcount
          else
            @appealoverallsum = 0
          end

          # employee reg webportal and reg office
          @employeeregweb1 = SurveyMonkeyCustomer.where("process_emp_reg=? and where_did_you_register_your_worker=? and what_is_customer_suits_you IN(?)", '1', 'Web Portal', param_value).count
          @employeeregweb2 = SurveyMonkeyCustomer.where("process_emp_reg=? and where_did_you_register_your_worker=? and what_is_customer_suits_you IN(?)", '2', 'Web Portal', param_value).count
          @employeeregweb3 = SurveyMonkeyCustomer.where("process_emp_reg=? and where_did_you_register_your_worker=? and what_is_customer_suits_you IN(?)", '3', 'Web Portal', param_value).count
          @employeeregweb4 = SurveyMonkeyCustomer.where("process_emp_reg=? and where_did_you_register_your_worker=? and what_is_customer_suits_you IN(?)", '4', 'Web Portal', param_value).count
          @employeeregweb5 = SurveyMonkeyCustomer.where("process_emp_reg=? and where_did_you_register_your_worker=? and what_is_customer_suits_you IN(?)", '5', 'Web Portal', param_value).count

          @employeeregweball = (@employeeregweb1 * 1) + (@employeeregweb2 * 2) + (@employeeregweb3 * 3) + (@employeeregweb4 * 4) + (@employeeregweb5 * 5)
          @employeeregweballcount = @employeeregweb1 + @employeeregweb2 + @employeeregweb3 + @employeeregweb4 + @employeeregweb5
          if (@employeeregweballcount > 0)
            @employeeregweballsum = @employeeregweball / @employeeregweballcount
          else
            @employeeregweballsum = 0
          end

          # NPS registration regional office
          @NPSregreg1 = SurveyMonkeyCustomer.where("process_emp_reg=? and process_worker_reg=? and panel_clinic_xray_facilities=? and overall_experience_reg_process=? and where_did_you_register_your_worker=? and what_is_customer_suits_you IN(?)", '1', '1', '1', '1', 'Regional Office', param_value).count
          @NPSregreg2 = SurveyMonkeyCustomer.where("process_emp_reg=? and process_worker_reg=? and panel_clinic_xray_facilities=? and overall_experience_reg_process=? and where_did_you_register_your_worker=? and what_is_customer_suits_you IN(?)", '2', '2', '2', '2', 'Regional Office', param_value).count
          @NPSregreg3 = SurveyMonkeyCustomer.where("process_emp_reg=? and process_worker_reg=? and panel_clinic_xray_facilities=? and overall_experience_reg_process=? and where_did_you_register_your_worker=? and what_is_customer_suits_you IN(?)", '3', '3', '3', '3', 'Regional Office', param_value).count
          @NPSregreg4 = SurveyMonkeyCustomer.where("process_emp_reg=? and process_worker_reg=? and panel_clinic_xray_facilities=? and overall_experience_reg_process=? and where_did_you_register_your_worker=? and what_is_customer_suits_you IN(?)", '4', '4', '4', '4', 'Regional Office', param_value).count
          @NPSregreg5 = SurveyMonkeyCustomer.where("process_emp_reg=? and process_worker_reg=? and panel_clinic_xray_facilities=? and overall_experience_reg_process=? and where_did_you_register_your_worker=? and what_is_customer_suits_you IN(?)", '5', '5', '5', '5', 'Regional Office', param_value).count

          @NPSregregall = (@NPSregreg1 * 1) + (@NPSregreg2 * 2) + (@NPSregreg3 * 3) + (@NPSregreg4 * 4) + (@NPSregreg5 * 5)
          @NPSregregpromoters = @NPSregreg4 + @NPSregreg5
          @NPSregregdectoters = @NPSregreg1 + @NPSregreg2
          if (@NPSregregall > 0)
            @NPSregpercentagepromoters = (@NPSregregpromoters / @NPSregregall) * 100
            @NPSregpercentagedectaters = (@NPSregregdectoters / @NPSregregall) * 100
            @NPSregoverallpercentage = @NPSregpercentagepromoters - @NPSregpercentagedectaters
          end
          # NPS Examination services
          @NPSExs1 = SurveyMonkeyCustomer.where("location_panel_clinics=? and 'Fomema_medical_examincation_are_understandable'=? and 'medical_Examinations_are_easy_toobtain'=? and 'Overall_rate_experience_medical_examination'=? and what_is_customer_suits_you IN(?)", '1', '1', '1', '1', param_value).count
          @NPSExs2 = SurveyMonkeyCustomer.where("location_panel_clinics=? and 'Fomema_medical_examincation_are_understandable'=? and 'medical_Examinations_are_easy_toobtain'=? and 'Overall_rate_experience_medical_examination'=? and what_is_customer_suits_you IN(?)", '2', '2', '2', '2', param_value).count
          @NPSExs3 = SurveyMonkeyCustomer.where("location_panel_clinics=? and 'Fomema_medical_examincation_are_understandable'=? and 'medical_Examinations_are_easy_toobtain'=? and 'Overall_rate_experience_medical_examination'=? and what_is_customer_suits_you IN(?)", '3', '3', '3', '3', param_value).count
          @NPSExs4 = SurveyMonkeyCustomer.where("location_panel_clinics=? and 'Fomema_medical_examincation_are_understandable'=? and 'medical_Examinations_are_easy_toobtain'=? and 'Overall_rate_experience_medical_examination'=? and what_is_customer_suits_you IN(?)", '4', '4', '4', '4', param_value).count
          @NPSExs5 = SurveyMonkeyCustomer.where("location_panel_clinics=? and 'Fomema_medical_examincation_are_understandable'=? and 'medical_Examinations_are_easy_toobtain'=? and 'Overall_rate_experience_medical_examination'=? and what_is_customer_suits_you IN(?)", '5', '5', '5', '5', param_value).count

          @NPSExsall = (@NPSExs1 * 1) + (@NPSExs2 * 2) + (@NPSExs3 * 3) + (@NPSExs4 * 4) + (@NPSExs5 * 5)
          @NPSExspromoters = @NPSExs4 + @NPSExs5
          @NPSExsdectoters = @NPSExs1 + @NPSExs2
          if (@NPSExsall > 0)
            @NPSExspercentagepromoters = (@NPSExspromoters / @NPSExsall) * 100
            @NPSExspercentagedectaters = (@NPSExsdectoters / @NPSExsall) * 100
            @NPSExsoverallpercentage = @NPSExspercentagepromoters - @NPSExspercentagedectaters
          else
            @NPSExsoverallpercentage = 0
          end
          # NPS appeal process
          @NPSappeal1 = SurveyMonkeyCustomer.where("tell_experience_appeal_process=? and what_is_customer_suits_you IN(?)", '1', param_value).count
          @NPSappeal2 = SurveyMonkeyCustomer.where("tell_experience_appeal_process=? and what_is_customer_suits_you IN(?)", '2', param_value).count
          @NPSappeal3 = SurveyMonkeyCustomer.where("tell_experience_appeal_process=? and what_is_customer_suits_you IN(?)", '3', param_value).count
          @NPSappeal4 = SurveyMonkeyCustomer.where("tell_experience_appeal_process=? and what_is_customer_suits_you IN(?)", '4', param_value).count
          @NPSappeal5 = SurveyMonkeyCustomer.where("tell_experience_appeal_process=? and what_is_customer_suits_you IN(?)", '5', param_value).count

          @NPSappealall = (@NPSappeal1 * 1) + (@NPSappeal2 * 2) + (@NPSappeal3 * 3) + (@NPSappeal4 * 4) + (@NPSappeal5 * 5)
          @NPSappealpromoters = @NPSappeal4 + @NPSappeal5
          @NPSappealdectoters = @NPSappeal1 + @NPSappeal2
          if (@NPSappealall > 0)
            @NPSappealpercentagepromoters = (@NPSappealpromoters / @NPSappealall) * 100
            @NPSappealpercentagedectaters = (@NPSappealdectoters / @NPSappealall) * 100
            @NPSappealoverallpercentage = @NPSappealpercentagepromoters - @NPSappealpercentagedectaters
          else
            @NPSappealoverallpercentage = 0
          end
          # NPS Average services
          if (@NPSoverallpercentage > 0)
            @NpsAveragescore = (@NPSoverallpercentage + @NPSregoverallpercentage + @NPSExsoverallpercentage + @NPSExsoverallpercentage)
            @NPSavgscore = @NpsAveragescore / 4
          else
            @NPSavgscore = 0
          end

          @panelclinic1 = SurveyMonkeyCustomer.where("location_panel_clinics=? and what_is_customer_suits_you IN(?)", '1', param_value).count
          @panelclinic2 = SurveyMonkeyCustomer.where("location_panel_clinics=? and what_is_customer_suits_you IN(?)", '2', param_value).count
          @panelclinic3 = SurveyMonkeyCustomer.where("location_panel_clinics=? and what_is_customer_suits_you IN(?)", '3', param_value).count
          @panelclinic4 = SurveyMonkeyCustomer.where("location_panel_clinics=? and what_is_customer_suits_you IN(?)", '4', param_value).count
          @panelclinic5 = SurveyMonkeyCustomer.where("location_panel_clinics=? and what_is_customer_suits_you IN(?)", '5', param_value).count

          @panelclinic1all = (@panelclinic1 * 1) + (@panelclinic2 * 2) + (@panelclinic3 * 3) + (@panelclinic4 * 4) + (@panelclinic5 * 5)
          @panelclinic1count = @panelclinic1 + @panelclinic2 + @panelclinic3 + @panelclinic4 + @panelclinic5
          if (@panelclinic1count > 0)
            @panelclinics = @panelclinic1all / @panelclinic1count
          else
            @panelclinics = 0
          end

          @understantable1 = SurveyMonkeyCustomer.where("'Fomema_medical_examincation_are_understandable'=? and what_is_customer_suits_you IN(?)", '1', param_value).count
          @understantable2 = SurveyMonkeyCustomer.where("'Fomema_medical_examincation_are_understandable'=? and what_is_customer_suits_you IN(?)", '2', param_value).count
          @understantable3 = SurveyMonkeyCustomer.where("'Fomema_medical_examincation_are_understandable'=? and what_is_customer_suits_you IN(?)", '3', param_value).count
          @understantable4 = SurveyMonkeyCustomer.where("'Fomema_medical_examincation_are_understandable'=? and what_is_customer_suits_you IN(?)", '4', param_value).count
          @understantable5 = SurveyMonkeyCustomer.where("'Fomema_medical_examincation_are_understandable'=? and what_is_customer_suits_you IN(?)", '5', param_value).count

          @understantableall = (@understantable1 * 1) + (@understantable2 * 2) + (@understantable3 * 3) + (@understantable4 * 4) + (@understantable5 * 5)
          @understantablecount = @understantable1 + @understantable2 + @understantable3 + @understantable4 + @understantable5
          if (@understantablecount > 0)
            @understantable = @understantableall / @understantablecount
          else
            @understantable = 0
          end

          @obtainable1 = SurveyMonkeyCustomer.where("'medical_Examinations_are_easy_toobtain'=? and what_is_customer_suits_you IN(?)", '1', param_value).count
          @obtainable2 = SurveyMonkeyCustomer.where("'medical_Examinations_are_easy_toobtain'=? and what_is_customer_suits_you IN(?)", '2', param_value).count
          @obtainable3 = SurveyMonkeyCustomer.where("'medical_Examinations_are_easy_toobtain'=? and what_is_customer_suits_you IN(?)", '3', param_value).count
          @obtainable4 = SurveyMonkeyCustomer.where("'medical_Examinations_are_easy_toobtain'=? and what_is_customer_suits_you IN(?)", '4', param_value).count
          @obtainable5 = SurveyMonkeyCustomer.where("'medical_Examinations_are_easy_toobtain'=? and what_is_customer_suits_you IN(?)", '5', param_value).count

          @obtainableall = (@obtainable1 * 1) + (@obtainable2 * 2) + (@obtainable3 * 3) + (@obtainable4 * 4) + (@obtainable5 * 5)
          @obtainablecount = @obtainable1 + @obtainable2 + @obtainable3 + @obtainable4 + @obtainable5
          if (@obtainablecount > 0)
            @obtainable = @obtainableall / @obtainablecount
          else
            @obtainable = 0
          end

          @overallexp1 = SurveyMonkeyCustomer.where("'Overall_rate_experience_medical_examination'=? and what_is_customer_suits_you IN(?)", '1', param_value).count
          @overallexp2 = SurveyMonkeyCustomer.where("'Overall_rate_experience_medical_examination'=? and what_is_customer_suits_you IN(?)", '2', param_value).count
          @overallexp3 = SurveyMonkeyCustomer.where("'Overall_rate_experience_medical_examination'=? and what_is_customer_suits_you IN(?)", '3', param_value).count
          @overallexp4 = SurveyMonkeyCustomer.where("'Overall_rate_experience_medical_examination'=? and what_is_customer_suits_you IN(?)", '4', param_value).count
          @overallexp5 = SurveyMonkeyCustomer.where("'Overall_rate_experience_medical_examination'=? and what_is_customer_suits_you IN(?)", '5', param_value).count

          @overallexpall = (@overallexp1 * 1) + (@overallexp2 * 2) + (@overallexp3 * 3) + (@overallexp4 * 4) + (@overallexp5 * 5)
          @overallexpcount = @overallexp1 + @overallexp2 + @overallexp3 + @overallexp4 + @overallexp5
          if (@overallexpcount > 0)
            @overallexp = @overallexpall / @overallexpcount
          else
            @overallexp = 0
          end

        end
      when "reg"
        if param_value.present?
          @transaction_line_chart = SurveyMonkeyCustomer.where('where_did_you_register_your_worker IN(?)', param_value).transaction_data_1_year

          @respondentsagegroup1824 = SurveyMonkeyCustomer.where('what_is_your_age=? and where_did_you_register_your_worker IN(?)', '18-24', param_value).pluck(:what_is_your_age).count
          @respondentsagegroup2534 = SurveyMonkeyCustomer.where('what_is_your_age=? and where_did_you_register_your_worker IN(?)', '25-34', param_value).pluck(:what_is_your_age).count
          @respondentsagegroup3544 = SurveyMonkeyCustomer.where('what_is_your_age=? and where_did_you_register_your_worker IN(?)', '35-44', param_value).pluck(:what_is_your_age).count
          @respondentsagegroup4554 = SurveyMonkeyCustomer.where('what_is_your_age=? and where_did_you_register_your_worker IN(?)', '45-54', param_value).pluck(:what_is_your_age).count
          @respondentsagegroup5565 = SurveyMonkeyCustomer.where('what_is_your_age=? and where_did_you_register_your_worker IN(?)', '55-65', param_value).pluck(:what_is_your_age).count
          @respondentsagegroupmore65 = SurveyMonkeyCustomer.where('what_is_your_age=? and where_did_you_register_your_worker IN(?)', 'More than 65', param_value).pluck(:what_is_your_age).count
          @webportal = SurveyMonkeyCustomer.where('where_did_you_register_your_worker=? and where_did_you_register_your_worker IN(?)', 'Web Portal', param_value).pluck(:where_did_you_register_your_worker).count
          @Rooffice = SurveyMonkeyCustomer.where('where_did_you_register_your_worker=? and where_did_you_register_your_worker IN(?)', 'Regional Office', param_value).pluck(:where_did_you_register_your_worker).count
          @gendermale = SurveyMonkeyCustomer.where('what_is_your_gender=? and where_did_you_register_your_worker IN(?)', 'Male', param_value).pluck(:what_is_your_gender).count
          @genderfemale = SurveyMonkeyCustomer.where('what_is_your_gender=? and where_did_you_register_your_worker IN(?)', 'Female', param_value).pluck(:what_is_your_gender).count
          @individual = SurveyMonkeyCustomer.where('what_is_customer_suits_you=? and where_did_you_register_your_worker IN(?)', 'Individual Employer', param_value).pluck(:what_is_customer_suits_you).count
          @customer_type = SurveyMonkeyCustomer.pluck(:what_is_customer_suits_you).uniq
          @registrationmedium = SurveyMonkeyCustomer.pluck(:where_did_you_register_your_worker).uniq
          @company = SurveyMonkeyCustomer.where('what_is_customer_suits_you=? and where_did_you_register_your_worker IN(?)', 'Company Employer', param_value).pluck(:what_is_customer_suits_you).count
          @agent = SurveyMonkeyCustomer.where(' what_is_customer_suits_you=? and where_did_you_register_your_worker IN(?)', 'Agent', param_value).pluck(:what_is_customer_suits_you).count

          @facebook = SurveyMonkeyCustomer.where('facebook=? and where_did_you_register_your_worker IN(?)', 'Facebook', param_value).pluck(:facebook).count
          @twitter = SurveyMonkeyCustomer.where('twitter=? and where_did_you_register_your_worker IN(?)', 'Twitter', param_value).pluck(:twitter).count
          @instagram = SurveyMonkeyCustomer.where('instagram=? and where_did_you_register_your_worker IN(?)', 'Instagram', param_value).pluck(:instagram).count
          @telegram = SurveyMonkeyCustomer.where('telegram=? and where_did_you_register_your_worker IN(?)', 'Telegram', param_value).pluck(:telegram).count
          @OtherSM = SurveyMonkeyCustomer.where('other_social!=? and where_did_you_register_your_worker IN(?)', '', param_value).pluck(:other_social).count

          @operatingsocial = SurveyMonkeyCustomer.where('announcement_business_operator=? and where_did_you_register_your_worker IN(?)', 'Yes', param_value).pluck(:announcement_business_operator).count
          @operatingsocialNo = SurveyMonkeyCustomer.where('announcement_business_operator=? and where_did_you_register_your_worker IN(?)', 'No', param_value).pluck(:announcement_business_operator).count
          @health_awareness = SurveyMonkeyCustomer.where('delivering_health=? and where_did_you_register_your_worker IN(?)', 'Yes', param_value).pluck(:delivering_health).count
          @health_awarenessNo = SurveyMonkeyCustomer.where('delivering_health=? and where_did_you_register_your_worker IN(?)', 'No', param_value).pluck(:delivering_health).count
          @moh_moha = SurveyMonkeyCustomer.where('"aligned_info_moh_MOHA"=? and where_did_you_register_your_worker IN(?)', 'Yes', param_value).pluck(:aligned_info_moh_MOHA).count
          @moh_mohaNo = SurveyMonkeyCustomer.where('"aligned_info_moh_MOHA"=? and where_did_you_register_your_worker IN(?)', 'No', param_value).pluck(:aligned_info_moh_MOHA).count

          # employee reg webportal and reg office
          @employeeregweb1 = SurveyMonkeyCustomer.where("process_emp_reg=? and where_did_you_register_your_worker=? and where_did_you_register_your_worker IN(?)", '1', 'Web Portal', param_value).count
          @employeeregweb2 = SurveyMonkeyCustomer.where("process_emp_reg=? and where_did_you_register_your_worker=? and where_did_you_register_your_worker IN(?)", '2', 'Web Portal', param_value).count
          @employeeregweb3 = SurveyMonkeyCustomer.where("process_emp_reg=? and where_did_you_register_your_worker=? and where_did_you_register_your_worker IN(?)", '3', 'Web Portal', param_value).count
          @employeeregweb4 = SurveyMonkeyCustomer.where("process_emp_reg=? and where_did_you_register_your_worker=? and where_did_you_register_your_worker IN(?)", '4', 'Web Portal', param_value).count
          @employeeregweb5 = SurveyMonkeyCustomer.where("process_emp_reg=? and where_did_you_register_your_worker=? and where_did_you_register_your_worker IN(?)", '5', 'Web Portal', param_value).count

          @employeeregweball = (@employeeregweb1 * 1) + (@employeeregweb2 * 2) + (@employeeregweb3 * 3) + (@employeeregweb4 * 4) + (@employeeregweb5 * 5)
          @employeeregweballcount = @employeeregweb1 + @employeeregweb2 + @employeeregweb3 + @employeeregweb4 + @employeeregweb5
          if (@employeeregweballcount > 0)
            @employeeregweballsum = @employeeregweball / @employeeregweballcount
          else
            @employeeregweballsum = 0
          end

          @employeeregreg1 = SurveyMonkeyCustomer.where("process_emp_reg=? and where_did_you_register_your_worker=? and where_did_you_register_your_worker IN(?)", '1', 'Regional Office', param_value).count
          @employeeregreg2 = SurveyMonkeyCustomer.where("process_emp_reg=? and where_did_you_register_your_worker=? and where_did_you_register_your_worker IN(?)", '2', 'Regional Office', param_value).count
          @employeeregreg3 = SurveyMonkeyCustomer.where("process_emp_reg=? and where_did_you_register_your_worker=? and where_did_you_register_your_worker IN(?)", '3', 'Regional Office', param_value).count
          @employeeregreg4 = SurveyMonkeyCustomer.where("process_emp_reg=? and where_did_you_register_your_worker=? and where_did_you_register_your_worker IN(?)", '4', 'Regional Office', param_value).count
          @employeeregreg5 = SurveyMonkeyCustomer.where("process_emp_reg=? and where_did_you_register_your_worker=? and where_did_you_register_your_worker IN(?)", '5', 'Regional Office', param_value).count

          @employeeregregall = (@employeeregreg1 * 1) + (@employeeregreg2 * 2) + (@employeeregreg3 * 3) + (@employeeregreg4 * 4) + (@employeeregreg5 * 5)
          @employeeregregcount = @employeeregreg1 + @employeeregreg2 + @employeeregreg3 + @employeeregreg4 + @employeeregreg5
          if (@employeeregregall > 0)
            @employeeregregsum = @employeeregregall / @employeeregregcount
          else
            @employeeregregsum = 0
          end
          # worker reg webportal and reg office
          @workerregweb1 = SurveyMonkeyCustomer.where("process_worker_reg=? and where_did_you_register_your_worker=? and where_did_you_register_your_worker IN(?)", '1', 'Web Portal', param_value).count
          @workerregweb2 = SurveyMonkeyCustomer.where("process_worker_reg=? and where_did_you_register_your_worker=? and where_did_you_register_your_worker IN(?)", '2', 'Web Portal', param_value).count
          @workerregweb3 = SurveyMonkeyCustomer.where("process_worker_reg=? and where_did_you_register_your_worker=? and where_did_you_register_your_worker IN(?)", '3', 'Web Portal', param_value).count
          @workerregweb4 = SurveyMonkeyCustomer.where("process_worker_reg=? and where_did_you_register_your_worker=? and where_did_you_register_your_worker IN(?)", '4', 'Web Portal', param_value).count
          @workerregweb5 = SurveyMonkeyCustomer.where("process_worker_reg=? and where_did_you_register_your_worker=? and where_did_you_register_your_worker IN(?)", '5', 'Web Portal', param_value).count

          @workerregweball = (@workerregweb1 * 1) + (@workerregweb2 * 2) + (@workerregweb3 * 3) + (@workerregweb4 * 4) + (@workerregweb5 * 5)
          @workerregweballcount = @workerregweb1 + @workerregweb2 + @workerregweb3 + @workerregweb4 + @workerregweb5
          if (@workerregweballcount > 0)
            @workerregweballsum = @workerregweball / @workerregweballcount
          else
            @workerregweballsum = 0
          end

          @workerregreg1 = SurveyMonkeyCustomer.where("process_worker_reg=? and where_did_you_register_your_worker=? and where_did_you_register_your_worker IN(?)", '1', 'Regional Office', param_value).count
          @workerregreg2 = SurveyMonkeyCustomer.where("process_worker_reg=? and where_did_you_register_your_worker=? and where_did_you_register_your_worker IN(?)", '2', 'Regional Office', param_value).count
          @workerregreg3 = SurveyMonkeyCustomer.where("process_worker_reg=? and where_did_you_register_your_worker=? and where_did_you_register_your_worker IN(?)", '3', 'Regional Office', param_value).count
          @workerregreg4 = SurveyMonkeyCustomer.where("process_worker_reg=? and where_did_you_register_your_worker=? and where_did_you_register_your_worker IN(?)", '4', 'Regional Office', param_value).count
          @workerregreg5 = SurveyMonkeyCustomer.where("process_worker_reg=? and where_did_you_register_your_worker=? and where_did_you_register_your_worker IN(?)", '5', 'Regional Office', param_value).count

          @workerregregall = (@workerregreg1 * 1) + (@workerregreg2 * 2) + (@workerregreg3 * 3) + (@workerregreg4 * 4) + (@workerregreg5 * 5)
          @workerregregcount = @workerregreg1 + @workerregreg2 + @workerregreg3 + @workerregreg4 + @workerregreg5
          if (@workerregregcount > 0)
            @workerregregsum = @workerregregall / @workerregregcount
          else
            @workerregregsum = 0
          end

          # panel clinic reg webportal and reg office
          @panelregweb1 = SurveyMonkeyCustomer.where("panel_clinic_xray_facilities=? and where_did_you_register_your_worker=? and where_did_you_register_your_worker IN(?)", '1', 'Web Portal', param_value).count
          @panelregweb2 = SurveyMonkeyCustomer.where("panel_clinic_xray_facilities=? and where_did_you_register_your_worker=? and where_did_you_register_your_worker IN(?)", '2', 'Web Portal', param_value).count
          @panelregweb3 = SurveyMonkeyCustomer.where("panel_clinic_xray_facilities=? and where_did_you_register_your_worker=? and where_did_you_register_your_worker IN(?)", '3', 'Web Portal', param_value).count
          @panelregweb4 = SurveyMonkeyCustomer.where("panel_clinic_xray_facilities=? and where_did_you_register_your_worker=? and where_did_you_register_your_worker IN(?)", '4', 'Web Portal', param_value).count
          @panelregweb5 = SurveyMonkeyCustomer.where("panel_clinic_xray_facilities=? and where_did_you_register_your_worker=? and where_did_you_register_your_worker IN(?)", '5', 'Web Portal', param_value).count

          @panelregweball = (@panelregweb1 * 1) + (@panelregweb2 * 2) + (@panelregweb3 * 3) + (@panelregweb4 * 4) + (@panelregweb5 * 5)
          @panelregweballcount = @panelregweb1 + @panelregweb2 + @panelregweb3 + @panelregweb4 + @panelregweb5
          if (@panelregweballcount > 0)
            @panelregweballsum = @panelregweball / @panelregweballcount
          else
            @panelregweballsum = 0
          end

          @panelregreg1 = SurveyMonkeyCustomer.where("panel_clinic_xray_facilities=? and where_did_you_register_your_worker=? and where_did_you_register_your_worker IN(?)", '1', 'Regional Office', param_value).count
          @panelregreg2 = SurveyMonkeyCustomer.where("panel_clinic_xray_facilities=? and where_did_you_register_your_worker=? and where_did_you_register_your_worker IN(?)", '2', 'Regional Office', param_value).count
          @panelregreg3 = SurveyMonkeyCustomer.where("panel_clinic_xray_facilities=? and where_did_you_register_your_worker=? and where_did_you_register_your_worker IN(?)", '3', 'Regional Office', param_value).count
          @panelregreg4 = SurveyMonkeyCustomer.where("panel_clinic_xray_facilities=? and where_did_you_register_your_worker=? and where_did_you_register_your_worker IN(?)", '4', 'Regional Office', param_value).count
          @panelregreg5 = SurveyMonkeyCustomer.where("panel_clinic_xray_facilities=? and where_did_you_register_your_worker=? and where_did_you_register_your_worker IN(?)", '5', 'Regional Office', param_value).count

          @panelregregall = (@panelregreg1 * 1) + (@panelregreg2 * 2) + (@panelregreg3 * 3) + (@panelregreg4 * 4) + (@panelregreg5 * 5)
          @panelregregcount = @panelregreg1 + @panelregreg2 + @panelregreg3 + @panelregreg4 + @panelregreg5
          if (@panelregregcount > 0)
            @panelregregsum = @panelregregall / @panelregregcount
          else
            @panelregregsum = 0
          end

          # overall reg webportal and reg office
          @overallregweb1 = SurveyMonkeyCustomer.where("overall_experience_reg_process=? and where_did_you_register_your_worker=? and where_did_you_register_your_worker IN(?)", '1', 'Web Portal', param_value).count
          @overallregweb2 = SurveyMonkeyCustomer.where("overall_experience_reg_process=? and where_did_you_register_your_worker=? and where_did_you_register_your_worker IN(?)", '2', 'Web Portal', param_value).count
          @overallregweb3 = SurveyMonkeyCustomer.where("overall_experience_reg_process=? and where_did_you_register_your_worker=? and where_did_you_register_your_worker IN(?)", '3', 'Web Portal', param_value).count
          @overallregweb4 = SurveyMonkeyCustomer.where("overall_experience_reg_process=? and where_did_you_register_your_worker=? and where_did_you_register_your_worker IN(?)", '4', 'Web Portal', param_value).count
          @overallregweb5 = SurveyMonkeyCustomer.where("overall_experience_reg_process=? and where_did_you_register_your_worker=? and where_did_you_register_your_worker IN(?)", '5', 'Web Portal', param_value).count

          @overallregweball = (@overallregweb1 * 1) + (@overallregweb2 * 2) + (@overallregweb3 * 3) + (@overallregweb4 * 4) + (@overallregweb5 * 5)
          @overallregweballcount = @overallregweb1 + @overallregweb2 + @overallregweb3 + @overallregweb4 + @overallregweb5
          if (@overallregweballcount > 0)
            @overallregweballsum = @overallregweball / @overallregweballcount
          else
            @overallregweballsum = 0
          end

          @overallregreg1 = SurveyMonkeyCustomer.where("overall_experience_reg_process=? and where_did_you_register_your_worker=? and where_did_you_register_your_worker IN(?)", '1', 'Regional Office', param_value).count
          @overallregreg2 = SurveyMonkeyCustomer.where("overall_experience_reg_process=? and where_did_you_register_your_worker=? and where_did_you_register_your_worker IN(?)", '2', 'Regional Office', param_value).count
          @overallregreg3 = SurveyMonkeyCustomer.where("overall_experience_reg_process=? and where_did_you_register_your_worker=? and where_did_you_register_your_worker IN(?)", '3', 'Regional Office', param_value).count
          @overallregreg4 = SurveyMonkeyCustomer.where("overall_experience_reg_process=? and where_did_you_register_your_worker=? and where_did_you_register_your_worker IN(?)", '4', 'Regional Office', param_value).count
          @overallregreg5 = SurveyMonkeyCustomer.where("overall_experience_reg_process=? and where_did_you_register_your_worker=? and where_did_you_register_your_worker IN(?)", '5', 'Regional Office', param_value).count

          @overallregregall = (@overallregreg1 * 1) + (@overallregreg2 * 2) + (@overallregreg3 * 3) + (@overallregreg4 * 4) + (@overallregreg5 * 5)
          @overallregregcount = @overallregreg1 + @overallregreg2 + @overallregreg3 + @overallregreg4 + @overallregreg5
          if (@overallregregcount > 0)
            @overallregregsum = @overallregregall / @overallregregcount
          else
            @overallregregsum = 0
          end

          @appealworkerstatus = SurveyMonkeyCustomer.where('worker_status_found_medical_unsuitable=? and where_did_you_register_your_worker IN(?)', 'Yes', param_value).pluck(:worker_status_found_medical_unsuitable).count
          @appealworkerstatusNo = SurveyMonkeyCustomer.where('worker_status_found_medical_unsuitable=? and where_did_you_register_your_worker IN(?)', 'No', param_value).pluck(:worker_status_found_medical_unsuitable).count
          @appealundergostatus = SurveyMonkeyCustomer.where('undergo_fomema_appeal_process=? and where_did_you_register_your_worker IN(?)', 'Yes', param_value).pluck(:undergo_fomema_appeal_process).count
          @appealundergostatusNo = SurveyMonkeyCustomer.where('undergo_fomema_appeal_process=? and where_did_you_register_your_worker IN(?)', 'No', param_value).pluck(:undergo_fomema_appeal_process).count
          @appealoverall1 = SurveyMonkeyCustomer.where('tell_experience_appeal_process=? and where_did_you_register_your_worker IN(?)', '1', param_value).pluck(:tell_experience_appeal_process).count
          @appealoverall2 = SurveyMonkeyCustomer.where('tell_experience_appeal_process=? and where_did_you_register_your_worker IN(?)', '2', param_value).pluck(:tell_experience_appeal_process).count
          @appealoverall3 = SurveyMonkeyCustomer.where('tell_experience_appeal_process=? and where_did_you_register_your_worker IN(?)', '3', param_value).pluck(:tell_experience_appeal_process).count
          @appealoverall4 = SurveyMonkeyCustomer.where('tell_experience_appeal_process=? and where_did_you_register_your_worker IN(?)', '4', param_value).pluck(:tell_experience_appeal_process).count
          @appealoverall5 = SurveyMonkeyCustomer.where('tell_experience_appeal_process=? and where_did_you_register_your_worker IN(?)', '5', param_value).pluck(:tell_experience_appeal_process).count
          @appealoverall = (@appealoverall1 * 1) + (@appealoverall2 * 2) + (@appealoverall3 * 3) + (@appealoverall4 * 4) + (@appealoverall5 * 5)
          @appealoverallcount = @appealoverall1 + @appealoverall2 + @appealoverall3 + @appealoverall4 + @appealoverall5
          if (@appealoverallcount > 0)
            @appealoverallsum = @appealoverall / @appealoverallcount
          else
            @appealoverallsum = 0
          end

          # NPS registration web portal
          @NPSregweb1 = SurveyMonkeyCustomer.where("process_emp_reg=? and process_worker_reg=? and panel_clinic_xray_facilities=? and overall_experience_reg_process=? and where_did_you_register_your_worker=? and where_did_you_register_your_worker IN(?)", '1', '1', '1', '1', 'Web Portal', param_value).count
          @NPSregweb2 = SurveyMonkeyCustomer.where("process_emp_reg=? and process_worker_reg=? and panel_clinic_xray_facilities=? and overall_experience_reg_process=? and where_did_you_register_your_worker=? and where_did_you_register_your_worker IN(?)", '2', '2', '2', '2', 'Web Portal', param_value).count
          @NPSregweb3 = SurveyMonkeyCustomer.where("process_emp_reg=? and process_worker_reg=? and panel_clinic_xray_facilities=? and overall_experience_reg_process=? and where_did_you_register_your_worker=? and where_did_you_register_your_worker IN(?)", '3', '3', '3', '3', 'Web Portal', param_value).count
          @NPSregweb4 = SurveyMonkeyCustomer.where("process_emp_reg=? and process_worker_reg=? and panel_clinic_xray_facilities=? and overall_experience_reg_process=? and where_did_you_register_your_worker=? and where_did_you_register_your_worker IN(?)", '4', '4', '4', '4', 'Web Portal', param_value).count
          @NPSregweb5 = SurveyMonkeyCustomer.where("process_emp_reg=? and process_worker_reg=? and panel_clinic_xray_facilities=? and overall_experience_reg_process=? and where_did_you_register_your_worker=? and where_did_you_register_your_worker IN(?)", '5', '5', '5', '5', 'Web Portal', param_value).count

          @NPSregweball = (@NPSregweb1 * 1) + (@NPSregweb2 * 2) + (@NPSregweb3 * 3) + (@NPSregweb4 * 4) + (@NPSregweb5 * 5)
          @NPSregwebpromoters = @NPSregweb4 + @NPSregweb5
          @NPSregwebdectoters = @NPSregweb1 + @NPSregweb2
          if (@NPSregweball > 0)
            @NPSwebpercentagepromoters = (@NPSregwebpromoters / @NPSregweball) * 100
            @NPSwebpercentagedectaters = (@NPSregwebdectoters / @NPSregweball) * 100
            @NPSoverallpercentage = @NPSwebpercentagepromoters - @NPSwebpercentagedectaters
          else
            @NPSoverallpercentage = 0
          end
          # NPS registration regional office
          @NPSregreg1 = SurveyMonkeyCustomer.where("process_emp_reg=? and process_worker_reg=? and panel_clinic_xray_facilities=? and overall_experience_reg_process=? and where_did_you_register_your_worker=? and where_did_you_register_your_worker IN(?)", '1', '1', '1', '1', 'Regional Office', param_value).count
          @NPSregreg2 = SurveyMonkeyCustomer.where("process_emp_reg=? and process_worker_reg=? and panel_clinic_xray_facilities=? and overall_experience_reg_process=? and where_did_you_register_your_worker=? and where_did_you_register_your_worker IN(?)", '2', '2', '2', '2', 'Regional Office', param_value).count
          @NPSregreg3 = SurveyMonkeyCustomer.where("process_emp_reg=? and process_worker_reg=? and panel_clinic_xray_facilities=? and overall_experience_reg_process=? and where_did_you_register_your_worker=? and where_did_you_register_your_worker IN(?)", '3', '3', '3', '3', 'Regional Office', param_value).count
          @NPSregreg4 = SurveyMonkeyCustomer.where("process_emp_reg=? and process_worker_reg=? and panel_clinic_xray_facilities=? and overall_experience_reg_process=? and where_did_you_register_your_worker=? and where_did_you_register_your_worker IN(?)", '4', '4', '4', '4', 'Regional Office', param_value).count
          @NPSregreg5 = SurveyMonkeyCustomer.where("process_emp_reg=? and process_worker_reg=? and panel_clinic_xray_facilities=? and overall_experience_reg_process=? and where_did_you_register_your_worker=? and where_did_you_register_your_worker IN(?)", '5', '5', '5', '5', 'Regional Office', param_value).count

          @NPSregregall = (@NPSregreg1 * 1) + (@NPSregreg2 * 2) + (@NPSregreg3 * 3) + (@NPSregreg4 * 4) + (@NPSregreg5 * 5)
          @NPSregregpromoters = @NPSregreg4 + @NPSregreg5
          @NPSregregdectoters = @NPSregreg1 + @NPSregreg2
          if (@NPSregregall > 0)
            @NPSregpercentagepromoters = (@NPSregregpromoters / @NPSregregall) * 100
            @NPSregpercentagedectaters = (@NPSregregdectoters / @NPSregregall) * 100
            @NPSregoverallpercentage = @NPSregpercentagepromoters - @NPSregpercentagedectaters
          else
            @NPSregoverallpercentage = 0
          end
          # NPS Examination services
          @NPSExs1 = SurveyMonkeyCustomer.where("location_panel_clinics=? and 'Fomema_medical_examincation_are_understandable'=? and 'medical_Examinations_are_easy_toobtain'=? and 'Overall_rate_experience_medical_examination'=? and where_did_you_register_your_worker IN(?)", '1', '1', '1', '1', param_value).count
          @NPSExs2 = SurveyMonkeyCustomer.where("location_panel_clinics=? and 'Fomema_medical_examincation_are_understandable'=? and 'medical_Examinations_are_easy_toobtain'=? and 'Overall_rate_experience_medical_examination'=? and where_did_you_register_your_worker IN(?)", '2', '2', '2', '2', param_value).count
          @NPSExs3 = SurveyMonkeyCustomer.where("location_panel_clinics=? and 'Fomema_medical_examincation_are_understandable'=? and 'medical_Examinations_are_easy_toobtain'=? and 'Overall_rate_experience_medical_examination'=? and where_did_you_register_your_worker IN(?)", '3', '3', '3', '3', param_value).count
          @NPSExs4 = SurveyMonkeyCustomer.where("location_panel_clinics=? and 'Fomema_medical_examincation_are_understandable'=? and 'medical_Examinations_are_easy_toobtain'=? and 'Overall_rate_experience_medical_examination'=? and where_did_you_register_your_worker IN(?)", '4', '4', '4', '4', param_value).count
          @NPSExs5 = SurveyMonkeyCustomer.where("location_panel_clinics=? and 'Fomema_medical_examincation_are_understandable'=? and 'medical_Examinations_are_easy_toobtain'=? and 'Overall_rate_experience_medical_examination'=? and where_did_you_register_your_worker IN(?)", '5', '5', '5', '5', param_value).count

          @NPSExsall = (@NPSExs1 * 1) + (@NPSExs2 * 2) + (@NPSExs3 * 3) + (@NPSExs4 * 4) + (@NPSExs5 * 5)
          @NPSExspromoters = @NPSExs4 + @NPSExs5
          @NPSExsdectoters = @NPSExs1 + @NPSExs2
          if (@NPSExsall > 0)
            @NPSExspercentagepromoters = (@NPSExspromoters / @NPSExsall) * 100
            @NPSExspercentagedectaters = (@NPSExsdectoters / @NPSExsall) * 100
            @NPSExsoverallpercentage = @NPSExspercentagepromoters - @NPSExspercentagedectaters
          else
            @NPSExsoverallpercentage = 0
          end
          # NPS appeal process
          @NPSappeal1 = SurveyMonkeyCustomer.where("tell_experience_appeal_process=? and where_did_you_register_your_worker IN(?)", '1', param_value).count
          @NPSappeal2 = SurveyMonkeyCustomer.where("tell_experience_appeal_process=? and where_did_you_register_your_worker IN(?)", '2', param_value).count
          @NPSappeal3 = SurveyMonkeyCustomer.where("tell_experience_appeal_process=? and where_did_you_register_your_worker IN(?)", '3', param_value).count
          @NPSappeal4 = SurveyMonkeyCustomer.where("tell_experience_appeal_process=? and where_did_you_register_your_worker IN(?)", '4', param_value).count
          @NPSappeal5 = SurveyMonkeyCustomer.where("tell_experience_appeal_process=? and where_did_you_register_your_worker IN(?)", '5', param_value).count

          @NPSappealall = (@NPSappeal1 * 1) + (@NPSappeal2 * 2) + (@NPSappeal3 * 3) + (@NPSappeal4 * 4) + (@NPSappeal5 * 5)
          @NPSappealpromoters = @NPSappeal4 + @NPSappeal5
          @NPSappealdectoters = @NPSappeal1 + @NPSappeal2
          if (@NPSappealall > 0)
            @NPSappealpercentagepromoters = (@NPSappealpromoters / @NPSappealall) * 100
            @NPSappealpercentagedectaters = (@NPSappealdectoters / @NPSappealall) * 100
            @NPSappealoverallpercentage = @NPSappealpercentagepromoters - @NPSappealpercentagedectaters
          else
            @NPSappealoverallpercentage = 0
          end
          # NPS Average services
          if (@NPSoverallpercentage > 0)
            @NpsAveragescore = (@NPSoverallpercentage + @NPSregoverallpercentage + @NPSExsoverallpercentage + @NPSExsoverallpercentage)
            @NPSavgscore = @NpsAveragescore / 4
          else
            @NPSavgscore = 0
          end

          @panelclinic1 = SurveyMonkeyCustomer.where("location_panel_clinics=? and where_did_you_register_your_worker IN(?)", '1', param_value).count
          @panelclinic2 = SurveyMonkeyCustomer.where("location_panel_clinics=? and where_did_you_register_your_worker IN(?)", '2', param_value).count
          @panelclinic3 = SurveyMonkeyCustomer.where("location_panel_clinics=? and where_did_you_register_your_worker IN(?)", '3', param_value).count
          @panelclinic4 = SurveyMonkeyCustomer.where("location_panel_clinics=? and where_did_you_register_your_worker IN(?)", '4', param_value).count
          @panelclinic5 = SurveyMonkeyCustomer.where("location_panel_clinics=? and where_did_you_register_your_worker IN(?)", '5', param_value).count

          @panelclinic1all = (@panelclinic1 * 1) + (@panelclinic2 * 2) + (@panelclinic3 * 3) + (@panelclinic4 * 4) + (@panelclinic5 * 5)
          @panelclinic1count = @panelclinic1 + @panelclinic2 + @panelclinic3 + @panelclinic4 + @panelclinic5
          if (@panelclinic1all > 0)
            @panelclinics = @panelclinic1all / @panelclinic1count
          else
            @panelclinics = 0
          end

          @understantable1 = SurveyMonkeyCustomer.where("'Fomema_medical_examincation_are_understandable'=? and where_did_you_register_your_worker IN(?)", '1', param_value).count
          @understantable2 = SurveyMonkeyCustomer.where("'Fomema_medical_examincation_are_understandable'=? and where_did_you_register_your_worker IN(?)", '2', param_value).count
          @understantable3 = SurveyMonkeyCustomer.where("'Fomema_medical_examincation_are_understandable'=? and where_did_you_register_your_worker IN(?)", '3', param_value).count
          @understantable4 = SurveyMonkeyCustomer.where("'Fomema_medical_examincation_are_understandable'=? and where_did_you_register_your_worker IN(?)", '4', param_value).count
          @understantable5 = SurveyMonkeyCustomer.where("'Fomema_medical_examincation_are_understandable'=? and where_did_you_register_your_worker IN(?)", '5', param_value).count

          @understantableall = (@understantable1 * 1) + (@understantable2 * 2) + (@understantable3 * 3) + (@understantable4 * 4) + (@understantable5 * 5)
          @understantablecount = @understantable1 + @understantable2 + @understantable3 + @understantable4 + @understantable5
          if (@understantableall > 0)
            @understantable = @understantableall / @understantablecount
          else
            @understantable = 0
          end

          @obtainable1 = SurveyMonkeyCustomer.where("'medical_Examinations_are_easy_toobtain'=? and where_did_you_register_your_worker IN(?)", '1', param_value).count
          @obtainable2 = SurveyMonkeyCustomer.where("'medical_Examinations_are_easy_toobtain'=? and where_did_you_register_your_worker IN(?)", '2', param_value).count
          @obtainable3 = SurveyMonkeyCustomer.where("'medical_Examinations_are_easy_toobtain'=? and where_did_you_register_your_worker IN(?)", '3', param_value).count
          @obtainable4 = SurveyMonkeyCustomer.where("'medical_Examinations_are_easy_toobtain'=? and where_did_you_register_your_worker IN(?)", '4', param_value).count
          @obtainable5 = SurveyMonkeyCustomer.where("'medical_Examinations_are_easy_toobtain'=? and where_did_you_register_your_worker IN(?)", '5', param_value).count

          @obtainableall = (@obtainable1 * 1) + (@obtainable2 * 2) + (@obtainable3 * 3) + (@obtainable4 * 4) + (@obtainable5 * 5)
          @obtainablecount = @obtainable1 + @obtainable2 + @obtainable3 + @obtainable4 + @obtainable5
          if (@obtainableall > 0)
            @obtainable = @obtainableall / @obtainablecount
          else
            @obtainable = 0
          end

          @overallexp1 = SurveyMonkeyCustomer.where("'Overall_rate_experience_medical_examination'=? and where_did_you_register_your_worker IN(?)", '1', param_value).count
          @overallexp2 = SurveyMonkeyCustomer.where("'Overall_rate_experience_medical_examination'=? and where_did_you_register_your_worker IN(?)", '2', param_value).count
          @overallexp3 = SurveyMonkeyCustomer.where("'Overall_rate_experience_medical_examination'=? and where_did_you_register_your_worker IN(?)", '3', param_value).count
          @overallexp4 = SurveyMonkeyCustomer.where("'Overall_rate_experience_medical_examination'=? and where_did_you_register_your_worker IN(?)", '4', param_value).count
          @overallexp5 = SurveyMonkeyCustomer.where("'Overall_rate_experience_medical_examination'=? and where_did_you_register_your_worker IN(?)", '5', param_value).count

          @overallexpall = (@overallexp1 * 1) + (@overallexp2 * 2) + (@overallexp3 * 3) + (@overallexp4 * 4) + (@overallexp5 * 5)
          @overallexpcount = @overallexp1 + @overallexp2 + @overallexp3 + @overallexp4 + @overallexp5
          if (@overallexpall > 0)
            @overallexp = @overallexpall / @overallexpcount
          else
            @overallexp = 0
          end

        end
      when "agegroup"
        if param_value.present?
          @transaction_line_chart = SurveyMonkeyCustomer.where('what_is_your_age IN(?)', param_value).transaction_data_1_year

          @respondentsagegroup1824 = SurveyMonkeyCustomer.where('what_is_your_age=? and what_is_your_age IN(?)', '18-24', param_value).pluck(:what_is_your_age).count
          @respondentsagegroup2534 = SurveyMonkeyCustomer.where('what_is_your_age=? and what_is_your_age IN(?)', '25-34', param_value).pluck(:what_is_your_age).count
          @respondentsagegroup3544 = SurveyMonkeyCustomer.where('what_is_your_age=? and what_is_your_age IN(?)', '35-44', param_value).pluck(:what_is_your_age).count
          @respondentsagegroup4554 = SurveyMonkeyCustomer.where('what_is_your_age=? and what_is_your_age IN(?)', '45-54', param_value).pluck(:what_is_your_age).count
          @respondentsagegroup5565 = SurveyMonkeyCustomer.where('what_is_your_age=? and what_is_your_age IN(?)', '55-65', param_value).pluck(:what_is_your_age).count
          @respondentsagegroupmore65 = SurveyMonkeyCustomer.where('what_is_your_age=? and what_is_your_age IN(?)', 'More than 65', param_value).pluck(:what_is_your_age).count
          @webportal = SurveyMonkeyCustomer.where('where_did_you_register_your_worker=? and what_is_your_age IN(?)', 'Web Portal', param_value).pluck(:where_did_you_register_your_worker).count
          @Rooffice = SurveyMonkeyCustomer.where('where_did_you_register_your_worker=? and what_is_your_age IN(?)', 'Regional Office', param_value).pluck(:where_did_you_register_your_worker).count
          @gendermale = SurveyMonkeyCustomer.where('what_is_your_gender=? and what_is_your_age IN(?)', 'Male', param_value).pluck(:what_is_your_gender).count
          @genderfemale = SurveyMonkeyCustomer.where('what_is_your_gender=? and what_is_your_age IN(?)', 'Female', param_value).pluck(:what_is_your_gender).count
          @individual = SurveyMonkeyCustomer.where('what_is_customer_suits_you=? and what_is_your_age IN(?)', 'Individual Employer', param_value).pluck(:what_is_customer_suits_you).count
          @customer_type = SurveyMonkeyCustomer.pluck(:what_is_customer_suits_you).uniq
          @registrationmedium = SurveyMonkeyCustomer.pluck(:where_did_you_register_your_worker).uniq
          @company = SurveyMonkeyCustomer.where('what_is_customer_suits_you=? and what_is_your_age IN(?)', 'Company Employer', param_value).pluck(:what_is_customer_suits_you).count
          @agent = SurveyMonkeyCustomer.where(' what_is_customer_suits_you=? and what_is_your_age IN(?)', 'Agent', param_value).pluck(:what_is_customer_suits_you).count

          @facebook = SurveyMonkeyCustomer.where('facebook=? and what_is_your_age IN(?)', 'Facebook', param_value).pluck(:facebook).count
          @twitter = SurveyMonkeyCustomer.where('twitter=? and what_is_your_age IN(?)', 'Twitter', param_value).pluck(:twitter).count
          @instagram = SurveyMonkeyCustomer.where('instagram=? and what_is_your_age IN(?)', 'Instagram', param_value).pluck(:instagram).count
          @telegram = SurveyMonkeyCustomer.where('telegram=? and what_is_your_age IN(?)', 'Telegram', param_value).pluck(:telegram).count
          @OtherSM = SurveyMonkeyCustomer.where('other_social!=? and what_is_your_age IN(?)', '', param_value).pluck(:other_social).count

          @operatingsocial = SurveyMonkeyCustomer.where('announcement_business_operator=? and what_is_your_age IN(?)', 'Yes', param_value).pluck(:announcement_business_operator).count
          @operatingsocialNo = SurveyMonkeyCustomer.where('announcement_business_operator=? and what_is_your_age IN(?)', 'No', param_value).pluck(:announcement_business_operator).count
          @health_awareness = SurveyMonkeyCustomer.where('delivering_health=? and what_is_your_age IN(?)', 'Yes', param_value).pluck(:delivering_health).count
          @health_awarenessNo = SurveyMonkeyCustomer.where('delivering_health=? and what_is_your_age IN(?)', 'No', param_value).pluck(:delivering_health).count
          @moh_moha = SurveyMonkeyCustomer.where('"aligned_info_moh_MOHA"=? and what_is_your_age IN(?)', 'Yes', param_value).pluck(:aligned_info_moh_MOHA).count
          @moh_mohaNo = SurveyMonkeyCustomer.where('"aligned_info_moh_MOHA"=? and what_is_your_age IN(?)', 'No', param_value).pluck(:aligned_info_moh_MOHA).count

          # employee reg webportal and reg office
          @employeeregweb1 = SurveyMonkeyCustomer.where("process_emp_reg=? and where_did_you_register_your_worker=? and what_is_your_age IN(?)", '1', 'Web Portal', param_value).count
          @employeeregweb2 = SurveyMonkeyCustomer.where("process_emp_reg=? and where_did_you_register_your_worker=? and what_is_your_age IN(?)", '2', 'Web Portal', param_value).count
          @employeeregweb3 = SurveyMonkeyCustomer.where("process_emp_reg=? and where_did_you_register_your_worker=? and what_is_your_age IN(?)", '3', 'Web Portal', param_value).count
          @employeeregweb4 = SurveyMonkeyCustomer.where("process_emp_reg=? and where_did_you_register_your_worker=? and what_is_your_age IN(?)", '4', 'Web Portal', param_value).count
          @employeeregweb5 = SurveyMonkeyCustomer.where("process_emp_reg=? and where_did_you_register_your_worker=? and what_is_your_age IN(?)", '5', 'Web Portal', param_value).count

          @employeeregweball = (@employeeregweb1 * 1) + (@employeeregweb2 * 2) + (@employeeregweb3 * 3) + (@employeeregweb4 * 4) + (@employeeregweb5 * 5)
          @employeeregweballcount = @employeeregweb1 + @employeeregweb2 + @employeeregweb3 + @employeeregweb4 + @employeeregweb5
          if (@employeeregweballcount > 0)
            @employeeregweballsum = @employeeregweball / @employeeregweballcount
          else
            @employeeregweballsum = 0
          end

          @employeeregreg1 = SurveyMonkeyCustomer.where("process_emp_reg=? and where_did_you_register_your_worker=? and what_is_your_age IN(?)", '1', 'Regional Office', param_value).count
          @employeeregreg2 = SurveyMonkeyCustomer.where("process_emp_reg=? and where_did_you_register_your_worker=? and what_is_your_age IN(?)", '2', 'Regional Office', param_value).count
          @employeeregreg3 = SurveyMonkeyCustomer.where("process_emp_reg=? and where_did_you_register_your_worker=? and what_is_your_age IN(?)", '3', 'Regional Office', param_value).count
          @employeeregreg4 = SurveyMonkeyCustomer.where("process_emp_reg=? and where_did_you_register_your_worker=? and what_is_your_age IN(?)", '4', 'Regional Office', param_value).count
          @employeeregreg5 = SurveyMonkeyCustomer.where("process_emp_reg=? and where_did_you_register_your_worker=? and what_is_your_age IN(?)", '5', 'Regional Office', param_value).count

          @employeeregregall = (@employeeregreg1 * 1) + (@employeeregreg2 * 2) + (@employeeregreg3 * 3) + (@employeeregreg4 * 4) + (@employeeregreg5 * 5)
          @employeeregregcount = @employeeregreg1 + @employeeregreg2 + @employeeregreg3 + @employeeregreg4 + @employeeregreg5
          if (@employeeregregcount > 0)
            @employeeregregsum = @employeeregregall / @employeeregregcount
          else
            @employeeregregsum = 0
          end

          # worker reg webportal and reg office
          @workerregweb1 = SurveyMonkeyCustomer.where("process_worker_reg=? and where_did_you_register_your_worker=? and what_is_your_age IN(?)", '1', 'Web Portal', param_value).count
          @workerregweb2 = SurveyMonkeyCustomer.where("process_worker_reg=? and where_did_you_register_your_worker=? and what_is_your_age IN(?)", '2', 'Web Portal', param_value).count
          @workerregweb3 = SurveyMonkeyCustomer.where("process_worker_reg=? and where_did_you_register_your_worker=? and what_is_your_age IN(?)", '3', 'Web Portal', param_value).count
          @workerregweb4 = SurveyMonkeyCustomer.where("process_worker_reg=? and where_did_you_register_your_worker=? and what_is_your_age IN(?)", '4', 'Web Portal', param_value).count
          @workerregweb5 = SurveyMonkeyCustomer.where("process_worker_reg=? and where_did_you_register_your_worker=? and what_is_your_age IN(?)", '5', 'Web Portal', param_value).count

          @workerregweball = (@workerregweb1 * 1) + (@workerregweb2 * 2) + (@workerregweb3 * 3) + (@workerregweb4 * 4) + (@workerregweb5 * 5)
          @workerregweballcount = @workerregweb1 + @workerregweb2 + @workerregweb3 + @workerregweb4 + @workerregweb5
          if (@workerregweballcount > 0)
            @workerregweballsum = @workerregweball / @workerregweballcount
          else
            @workerregweballsum = 0
          end

          @workerregreg1 = SurveyMonkeyCustomer.where("process_worker_reg=? and where_did_you_register_your_worker=? and what_is_your_age IN(?)", '1', 'Regional Office', param_value).count
          @workerregreg2 = SurveyMonkeyCustomer.where("process_worker_reg=? and where_did_you_register_your_worker=? and what_is_your_age IN(?)", '2', 'Regional Office', param_value).count
          @workerregreg3 = SurveyMonkeyCustomer.where("process_worker_reg=? and where_did_you_register_your_worker=? and what_is_your_age IN(?)", '3', 'Regional Office', param_value).count
          @workerregreg4 = SurveyMonkeyCustomer.where("process_worker_reg=? and where_did_you_register_your_worker=? and what_is_your_age IN(?)", '4', 'Regional Office', param_value).count
          @workerregreg5 = SurveyMonkeyCustomer.where("process_worker_reg=? and where_did_you_register_your_worker=? and what_is_your_age IN(?)", '5', 'Regional Office', param_value).count

          @workerregregall = (@workerregreg1 * 1) + (@workerregreg2 * 2) + (@workerregreg3 * 3) + (@workerregreg4 * 4) + (@workerregreg5 * 5)
          @workerregregcount = @workerregreg1 + @workerregreg2 + @workerregreg3 + @workerregreg4 + @workerregreg5
          if (@workerregregcount > 0)
            @workerregregsum = @workerregregall / @workerregregcount
          else
            @workerregregsum = 0
          end

          # panel clinic reg webportal and reg office
          @panelregweb1 = SurveyMonkeyCustomer.where("panel_clinic_xray_facilities=? and where_did_you_register_your_worker=? and what_is_your_age IN(?)", '1', 'Web Portal', param_value).count
          @panelregweb2 = SurveyMonkeyCustomer.where("panel_clinic_xray_facilities=? and where_did_you_register_your_worker=? and what_is_your_age IN(?)", '2', 'Web Portal', param_value).count
          @panelregweb3 = SurveyMonkeyCustomer.where("panel_clinic_xray_facilities=? and where_did_you_register_your_worker=? and what_is_your_age IN(?)", '3', 'Web Portal', param_value).count
          @panelregweb4 = SurveyMonkeyCustomer.where("panel_clinic_xray_facilities=? and where_did_you_register_your_worker=? and what_is_your_age IN(?)", '4', 'Web Portal', param_value).count
          @panelregweb5 = SurveyMonkeyCustomer.where("panel_clinic_xray_facilities=? and where_did_you_register_your_worker=? and what_is_your_age IN(?)", '5', 'Web Portal', param_value).count

          @panelregweball = (@panelregweb1 * 1) + (@panelregweb2 * 2) + (@panelregweb3 * 3) + (@panelregweb4 * 4) + (@panelregweb5 * 5)
          @panelregweballcount = @panelregweb1 + @panelregweb2 + @panelregweb3 + @panelregweb4 + @panelregweb5
          if (@panelregweballcount > 0)
            @panelregweballsum = @panelregweball / @panelregweballcount
          else
            @panelregweballsum = 0
          end

          @panelregreg1 = SurveyMonkeyCustomer.where("panel_clinic_xray_facilities=? and where_did_you_register_your_worker=? and what_is_your_age IN(?)", '1', 'Regional Office', param_value).count
          @panelregreg2 = SurveyMonkeyCustomer.where("panel_clinic_xray_facilities=? and where_did_you_register_your_worker=? and what_is_your_age IN(?)", '2', 'Regional Office', param_value).count
          @panelregreg3 = SurveyMonkeyCustomer.where("panel_clinic_xray_facilities=? and where_did_you_register_your_worker=? and what_is_your_age IN(?)", '3', 'Regional Office', param_value).count
          @panelregreg4 = SurveyMonkeyCustomer.where("panel_clinic_xray_facilities=? and where_did_you_register_your_worker=? and what_is_your_age IN(?)", '4', 'Regional Office', param_value).count
          @panelregreg5 = SurveyMonkeyCustomer.where("panel_clinic_xray_facilities=? and where_did_you_register_your_worker=? and what_is_your_age IN(?)", '5', 'Regional Office', param_value).count

          @panelregregall = (@panelregreg1 * 1) + (@panelregreg2 * 2) + (@panelregreg3 * 3) + (@panelregreg4 * 4) + (@panelregreg5 * 5)
          @panelregregcount = @panelregreg1 + @panelregreg2 + @panelregreg3 + @panelregreg4 + @panelregreg5
          if (@panelregregcount > 0)
            @panelregregsum = @panelregregall / @panelregregcount
          else
            @panelregregsum = 0
          end

          # overall reg webportal and reg office
          @overallregweb1 = SurveyMonkeyCustomer.where("overall_experience_reg_process=? and where_did_you_register_your_worker=? and what_is_your_age IN(?)", '1', 'Web Portal', param_value).count
          @overallregweb2 = SurveyMonkeyCustomer.where("overall_experience_reg_process=? and where_did_you_register_your_worker=? and what_is_your_age IN(?)", '2', 'Web Portal', param_value).count
          @overallregweb3 = SurveyMonkeyCustomer.where("overall_experience_reg_process=? and where_did_you_register_your_worker=? and what_is_your_age IN(?)", '3', 'Web Portal', param_value).count
          @overallregweb4 = SurveyMonkeyCustomer.where("overall_experience_reg_process=? and where_did_you_register_your_worker=? and what_is_your_age IN(?)", '4', 'Web Portal', param_value).count
          @overallregweb5 = SurveyMonkeyCustomer.where("overall_experience_reg_process=? and where_did_you_register_your_worker=? and what_is_your_age IN(?)", '5', 'Web Portal', param_value).count

          @overallregweball = (@overallregweb1 * 1) + (@overallregweb2 * 2) + (@overallregweb3 * 3) + (@overallregweb4 * 4) + (@overallregweb5 * 5)
          @overallregweballcount = @overallregweb1 + @overallregweb2 + @overallregweb3 + @overallregweb4 + @overallregweb5
          if (@overallregweballcount > 0)
            @overallregweballsum = @overallregweball / @overallregweballcount
          else
            @overallregweballsum = 0
          end

          @overallregreg1 = SurveyMonkeyCustomer.where("overall_experience_reg_process=? and where_did_you_register_your_worker=? and what_is_your_age IN(?)", '1', 'Regional Office', param_value).count
          @overallregreg2 = SurveyMonkeyCustomer.where("overall_experience_reg_process=? and where_did_you_register_your_worker=? and what_is_your_age IN(?)", '2', 'Regional Office', param_value).count
          @overallregreg3 = SurveyMonkeyCustomer.where("overall_experience_reg_process=? and where_did_you_register_your_worker=? and what_is_your_age IN(?)", '3', 'Regional Office', param_value).count
          @overallregreg4 = SurveyMonkeyCustomer.where("overall_experience_reg_process=? and where_did_you_register_your_worker=? and what_is_your_age IN(?)", '4', 'Regional Office', param_value).count
          @overallregreg5 = SurveyMonkeyCustomer.where("overall_experience_reg_process=? and where_did_you_register_your_worker=? and what_is_your_age IN(?)", '5', 'Regional Office', param_value).count

          @overallregregall = (@overallregreg1 * 1) + (@overallregreg2 * 2) + (@overallregreg3 * 3) + (@overallregreg4 * 4) + (@overallregreg5 * 5)
          @overallregregcount = @overallregreg1 + @overallregreg2 + @overallregreg3 + @overallregreg4 + @overallregreg5
          if (@overallregregcount > 0)
            @overallregregsum = @overallregregall / @overallregregcount
          else
            @overallregregsum = 0
          end

          @appealworkerstatus = SurveyMonkeyCustomer.where('worker_status_found_medical_unsuitable=? and what_is_your_age IN(?)', 'Yes', param_value).pluck(:worker_status_found_medical_unsuitable).count
          @appealworkerstatusNo = SurveyMonkeyCustomer.where('worker_status_found_medical_unsuitable=? and what_is_your_age IN(?)', 'No', param_value).pluck(:worker_status_found_medical_unsuitable).count
          @appealundergostatus = SurveyMonkeyCustomer.where('undergo_fomema_appeal_process=? and what_is_your_age IN(?)', 'Yes', param_value).pluck(:undergo_fomema_appeal_process).count
          @appealundergostatusNo = SurveyMonkeyCustomer.where('undergo_fomema_appeal_process=? and what_is_your_age IN(?)', 'No', param_value).pluck(:undergo_fomema_appeal_process).count
          @appealoverall1 = SurveyMonkeyCustomer.where('tell_experience_appeal_process=? and what_is_your_age IN(?)', '1', param_value).pluck(:tell_experience_appeal_process).count
          @appealoverall2 = SurveyMonkeyCustomer.where('tell_experience_appeal_process=? and what_is_your_age IN(?)', '2', param_value).pluck(:tell_experience_appeal_process).count
          @appealoverall3 = SurveyMonkeyCustomer.where('tell_experience_appeal_process=? and what_is_your_age IN(?)', '3', param_value).pluck(:tell_experience_appeal_process).count
          @appealoverall4 = SurveyMonkeyCustomer.where('tell_experience_appeal_process=? and what_is_your_age IN(?)', '4', param_value).pluck(:tell_experience_appeal_process).count
          @appealoverall5 = SurveyMonkeyCustomer.where('tell_experience_appeal_process=? and what_is_your_age IN(?)', '5', param_value).pluck(:tell_experience_appeal_process).count
          @appealoverall = (@appealoverall1 * 1) + (@appealoverall2 * 2) + (@appealoverall3 * 3) + (@appealoverall4 * 4) + (@appealoverall5 * 5)
          @appealoverallcount = @appealoverall1 + @appealoverall2 + @appealoverall3 + @appealoverall4 + @appealoverall5
          if (@appealoverallcount > 0)
            @appealoverallsum = @appealoverall / @appealoverallcount
          else
            @appealoverallsum = 0
          end

          # NPS registration web portal
          @NPSregweb1 = SurveyMonkeyCustomer.where("process_emp_reg=? and process_worker_reg=? and panel_clinic_xray_facilities=? and overall_experience_reg_process=? and where_did_you_register_your_worker=? and what_is_your_age IN(?)", '1', '1', '1', '1', 'Web Portal', param_value).count
          @NPSregweb2 = SurveyMonkeyCustomer.where("process_emp_reg=? and process_worker_reg=? and panel_clinic_xray_facilities=? and overall_experience_reg_process=? and where_did_you_register_your_worker=? and what_is_your_age IN(?)", '2', '2', '2', '2', 'Web Portal', param_value).count
          @NPSregweb3 = SurveyMonkeyCustomer.where("process_emp_reg=? and process_worker_reg=? and panel_clinic_xray_facilities=? and overall_experience_reg_process=? and where_did_you_register_your_worker=? and what_is_your_age IN(?)", '3', '3', '3', '3', 'Web Portal', param_value).count
          @NPSregweb4 = SurveyMonkeyCustomer.where("process_emp_reg=? and process_worker_reg=? and panel_clinic_xray_facilities=? and overall_experience_reg_process=? and where_did_you_register_your_worker=? and what_is_your_age IN(?)", '4', '4', '4', '4', 'Web Portal', param_value).count
          @NPSregweb5 = SurveyMonkeyCustomer.where("process_emp_reg=? and process_worker_reg=? and panel_clinic_xray_facilities=? and overall_experience_reg_process=? and where_did_you_register_your_worker=? and what_is_your_age IN(?)", '5', '5', '5', '5', 'Web Portal', param_value).count

          @NPSregweball = (@NPSregweb1 * 1) + (@NPSregweb2 * 2) + (@NPSregweb3 * 3) + (@NPSregweb4 * 4) + (@NPSregweb5 * 5)
          @NPSregwebpromoters = @NPSregweb4 + @NPSregweb5
          @NPSregwebdectoters = @NPSregweb1 + @NPSregweb2
          if (@NPSregweball > 0)
            @NPSwebpercentagepromoters = (@NPSregwebpromoters / @NPSregweball) * 100
            @NPSwebpercentagedectaters = (@NPSregwebdectoters / @NPSregweball) * 100
            @NPSoverallpercentage = @NPSwebpercentagepromoters - @NPSwebpercentagedectaters
          else
            @NPSoverallpercentage = 0
          end
          # NPS registration regional office
          @NPSregreg1 = SurveyMonkeyCustomer.where("process_emp_reg=? and process_worker_reg=? and panel_clinic_xray_facilities=? and overall_experience_reg_process=? and where_did_you_register_your_worker=? and what_is_your_age IN(?)", '1', '1', '1', '1', 'Regional Office', param_value).count
          @NPSregreg2 = SurveyMonkeyCustomer.where("process_emp_reg=? and process_worker_reg=? and panel_clinic_xray_facilities=? and overall_experience_reg_process=? and where_did_you_register_your_worker=? and what_is_your_age IN(?)", '2', '2', '2', '2', 'Regional Office', param_value).count
          @NPSregreg3 = SurveyMonkeyCustomer.where("process_emp_reg=? and process_worker_reg=? and panel_clinic_xray_facilities=? and overall_experience_reg_process=? and where_did_you_register_your_worker=? and what_is_your_age IN(?)", '3', '3', '3', '3', 'Regional Office', param_value).count
          @NPSregreg4 = SurveyMonkeyCustomer.where("process_emp_reg=? and process_worker_reg=? and panel_clinic_xray_facilities=? and overall_experience_reg_process=? and where_did_you_register_your_worker=? and what_is_your_age IN(?)", '4', '4', '4', '4', 'Regional Office', param_value).count
          @NPSregreg5 = SurveyMonkeyCustomer.where("process_emp_reg=? and process_worker_reg=? and panel_clinic_xray_facilities=? and overall_experience_reg_process=? and where_did_you_register_your_worker=? and what_is_your_age IN(?)", '5', '5', '5', '5', 'Regional Office', param_value).count

          @NPSregregall = (@NPSregreg1 * 1) + (@NPSregreg2 * 2) + (@NPSregreg3 * 3) + (@NPSregreg4 * 4) + (@NPSregreg5 * 5)
          @NPSregregpromoters = @NPSregreg4 + @NPSregreg5
          @NPSregregdectoters = @NPSregreg1 + @NPSregreg2
          if (@NPSregregall > 0)
            @NPSregpercentagepromoters = (@NPSregregpromoters / @NPSregregall) * 100
            @NPSregpercentagedectaters = (@NPSregregdectoters / @NPSregregall) * 100
            @NPSregoverallpercentage = @NPSregpercentagepromoters - @NPSregpercentagedectaters
          else
            @NPSregoverallpercentage = 0
          end
          # NPS Examination services
          @NPSExs1 = SurveyMonkeyCustomer.where("location_panel_clinics=? and 'Fomema_medical_examincation_are_understandable'=? and 'medical_Examinations_are_easy_toobtain'=? and 'Overall_rate_experience_medical_examination'=? and what_is_your_age IN(?)", '1', '1', '1', '1', param_value).count
          @NPSExs2 = SurveyMonkeyCustomer.where("location_panel_clinics=? and 'Fomema_medical_examincation_are_understandable'=? and 'medical_Examinations_are_easy_toobtain'=? and 'Overall_rate_experience_medical_examination'=? and what_is_your_age IN(?)", '2', '2', '2', '2', param_value).count
          @NPSExs3 = SurveyMonkeyCustomer.where("location_panel_clinics=? and 'Fomema_medical_examincation_are_understandable'=? and 'medical_Examinations_are_easy_toobtain'=? and 'Overall_rate_experience_medical_examination'=? and what_is_your_age IN(?)", '3', '3', '3', '3', param_value).count
          @NPSExs4 = SurveyMonkeyCustomer.where("location_panel_clinics=? and 'Fomema_medical_examincation_are_understandable'=? and 'medical_Examinations_are_easy_toobtain'=? and 'Overall_rate_experience_medical_examination'=? and what_is_your_age IN(?)", '4', '4', '4', '4', param_value).count
          @NPSExs5 = SurveyMonkeyCustomer.where("location_panel_clinics=? and 'Fomema_medical_examincation_are_understandable'=? and 'medical_Examinations_are_easy_toobtain'=? and 'Overall_rate_experience_medical_examination'=? and what_is_your_age IN(?)", '5', '5', '5', '5', param_value).count

          @NPSExsall = (@NPSExs1 * 1) + (@NPSExs2 * 2) + (@NPSExs3 * 3) + (@NPSExs4 * 4) + (@NPSExs5 * 5)
          @NPSExspromoters = @NPSExs4 + @NPSExs5
          @NPSExsdectoters = @NPSExs1 + @NPSExs2
          if (@NPSExsall > 0)
            @NPSExspercentagepromoters = (@NPSExspromoters / @NPSExsall) * 100
            @NPSExspercentagedectaters = (@NPSExsdectoters / @NPSExsall) * 100
            @NPSExsoverallpercentage = @NPSExspercentagepromoters - @NPSExspercentagedectaters
          else
            @NPSExsoverallpercentage = 0
          end
          # NPS appeal process
          @NPSappeal1 = SurveyMonkeyCustomer.where("tell_experience_appeal_process=? and what_is_your_age IN(?)", '1', param_value).count
          @NPSappeal2 = SurveyMonkeyCustomer.where("tell_experience_appeal_process=? and what_is_your_age IN(?)", '2', param_value).count
          @NPSappeal3 = SurveyMonkeyCustomer.where("tell_experience_appeal_process=? and what_is_your_age IN(?)", '3', param_value).count
          @NPSappeal4 = SurveyMonkeyCustomer.where("tell_experience_appeal_process=? and what_is_your_age IN(?)", '4', param_value).count
          @NPSappeal5 = SurveyMonkeyCustomer.where("tell_experience_appeal_process=? and what_is_your_age IN(?)", '5', param_value).count

          @NPSappealall = (@NPSappeal1 * 1) + (@NPSappeal2 * 2) + (@NPSappeal3 * 3) + (@NPSappeal4 * 4) + (@NPSappeal5 * 5)
          @NPSappealpromoters = @NPSappeal4 + @NPSappeal5
          @NPSappealdectoters = @NPSappeal1 + @NPSappeal2
          if (@NPSappealall > 0)
            @NPSappealpercentagepromoters = (@NPSappealpromoters / @NPSappealall) * 100
            @NPSappealpercentagedectaters = (@NPSappealdectoters / @NPSappealall) * 100
            @NPSappealoverallpercentage = @NPSappealpercentagepromoters - @NPSappealpercentagedectaters
          else
            @NPSappealoverallpercentage = 0
          end

          # NPS Average services
          if (@NPSoverallpercentage > 0)
            @NpsAveragescore = (@NPSoverallpercentage + @NPSregoverallpercentage + @NPSExsoverallpercentage + @NPSExsoverallpercentage)
            @NPSavgscore = @NpsAveragescore / 4
          else
            @NPSavgscore = 0
          end

          @panelclinic1 = SurveyMonkeyCustomer.where("location_panel_clinics=? and what_is_your_age IN(?)", '1', param_value).count
          @panelclinic2 = SurveyMonkeyCustomer.where("location_panel_clinics=? and what_is_your_age IN(?)", '2', param_value).count
          @panelclinic3 = SurveyMonkeyCustomer.where("location_panel_clinics=? and what_is_your_age IN(?)", '3', param_value).count
          @panelclinic4 = SurveyMonkeyCustomer.where("location_panel_clinics=? and what_is_your_age IN(?)", '4', param_value).count
          @panelclinic5 = SurveyMonkeyCustomer.where("location_panel_clinics=? and what_is_your_age IN(?)", '5', param_value).count

          @panelclinic1all = (@panelclinic1 * 1) + (@panelclinic2 * 2) + (@panelclinic3 * 3) + (@panelclinic4 * 4) + (@panelclinic5 * 5)
          @panelclinic1count = @panelclinic1 + @panelclinic2 + @panelclinic3 + @panelclinic4 + @panelclinic5
          if (@panelclinic1all > 0)
            @panelclinics = @panelclinic1all / @panelclinic1count
          else
            @panelclinics = 0
          end

          @understantable1 = SurveyMonkeyCustomer.where("'Fomema_medical_examincation_are_understandable'=? and what_is_your_age IN(?)", '1', param_value).count
          @understantable2 = SurveyMonkeyCustomer.where("'Fomema_medical_examincation_are_understandable'=? and what_is_your_age IN(?)", '2', param_value).count
          @understantable3 = SurveyMonkeyCustomer.where("'Fomema_medical_examincation_are_understandable'=? and what_is_your_age IN(?)", '3', param_value).count
          @understantable4 = SurveyMonkeyCustomer.where("'Fomema_medical_examincation_are_understandable'=? and what_is_your_age IN(?)", '4', param_value).count
          @understantable5 = SurveyMonkeyCustomer.where("'Fomema_medical_examincation_are_understandable'=? and what_is_your_age IN(?)", '5', param_value).count

          @understantableall = (@understantable1 * 1) + (@understantable2 * 2) + (@understantable3 * 3) + (@understantable4 * 4) + (@understantable5 * 5)
          @understantablecount = @understantable1 + @understantable2 + @understantable3 + @understantable4 + @understantable5
          if (@understantableall > 0)
            @understantable = @understantableall / @understantablecount
          else
            @understantable = 0
          end

          @obtainable1 = SurveyMonkeyCustomer.where("'medical_Examinations_are_easy_toobtain'=? and what_is_your_age IN(?)", '1', param_value).count
          @obtainable2 = SurveyMonkeyCustomer.where("'medical_Examinations_are_easy_toobtain'=? and what_is_your_age IN(?)", '2', param_value).count
          @obtainable3 = SurveyMonkeyCustomer.where("'medical_Examinations_are_easy_toobtain'=? and what_is_your_age IN(?)", '3', param_value).count
          @obtainable4 = SurveyMonkeyCustomer.where("'medical_Examinations_are_easy_toobtain'=? and what_is_your_age IN(?)", '4', param_value).count
          @obtainable5 = SurveyMonkeyCustomer.where("'medical_Examinations_are_easy_toobtain'=? and what_is_your_age IN(?)", '5', param_value).count

          @obtainableall = (@obtainable1 * 1) + (@obtainable2 * 2) + (@obtainable3 * 3) + (@obtainable4 * 4) + (@obtainable5 * 5)
          @obtainablecount = @obtainable1 + @obtainable2 + @obtainable3 + @obtainable4 + @obtainable5
          if (@obtainableall > 0)
            @obtainable = @obtainableall / @obtainablecount
          else
            @obtainable = 0
          end

          @overallexp1 = SurveyMonkeyCustomer.where("'Overall_rate_experience_medical_examination'=? and what_is_your_age IN(?)", '1', param_value).count
          @overallexp2 = SurveyMonkeyCustomer.where("'Overall_rate_experience_medical_examination'=? and what_is_your_age IN(?)", '2', param_value).count
          @overallexp3 = SurveyMonkeyCustomer.where("'Overall_rate_experience_medical_examination'=? and what_is_your_age IN(?)", '3', param_value).count
          @overallexp4 = SurveyMonkeyCustomer.where("'Overall_rate_experience_medical_examination'=? and what_is_your_age IN(?)", '4', param_value).count
          @overallexp5 = SurveyMonkeyCustomer.where("'Overall_rate_experience_medical_examination'=? and what_is_your_age IN(?)", '5', param_value).count

          @overallexpall = (@overallexp1 * 1) + (@overallexp2 * 2) + (@overallexp3 * 3) + (@overallexp4 * 4) + (@overallexp5 * 5)
          @overallexpcount = @overallexp1 + @overallexp2 + @overallexp3 + @overallexp4 + @overallexp5
          if (@overallexpall > 0)
            @overallexp = @overallexpall / @overallexpcount
          else
            @overallexp = 0
          end

        end
      when "gender"
        if param_value.present?
          @transaction_line_chart = SurveyMonkeyCustomer.where('what_is_your_gender IN(?)', param_value).transaction_data_1_year

          @respondentsagegroup1824 = SurveyMonkeyCustomer.where('what_is_your_age=? and what_is_your_gender IN(?)', '18-24', param_value).pluck(:what_is_your_age).count
          @respondentsagegroup2534 = SurveyMonkeyCustomer.where('what_is_your_age=? and what_is_your_gender IN(?)', '25-34', param_value).pluck(:what_is_your_age).count
          @respondentsagegroup3544 = SurveyMonkeyCustomer.where('what_is_your_age=? and what_is_your_gender IN(?)', '35-44', param_value).pluck(:what_is_your_age).count
          @respondentsagegroup4554 = SurveyMonkeyCustomer.where('what_is_your_age=? and what_is_your_gender IN(?)', '45-54', param_value).pluck(:what_is_your_age).count
          @respondentsagegroup5565 = SurveyMonkeyCustomer.where('what_is_your_age=? and what_is_your_gender IN(?)', '55-65', param_value).pluck(:what_is_your_age).count
          @respondentsagegroupmore65 = SurveyMonkeyCustomer.where('what_is_your_age=? and what_is_your_gender IN(?)', 'More than 65', param_value).pluck(:what_is_your_age).count
          @webportal = SurveyMonkeyCustomer.where('where_did_you_register_your_worker=? and what_is_your_gender IN(?)', 'Web Portal', param_value).pluck(:where_did_you_register_your_worker).count
          @Rooffice = SurveyMonkeyCustomer.where('where_did_you_register_your_worker=? and what_is_your_gender IN(?)', 'Regional Office', param_value).pluck(:where_did_you_register_your_worker).count
          @gendermale = SurveyMonkeyCustomer.where('what_is_your_gender=? and what_is_your_gender IN(?)', 'Male', param_value).pluck(:what_is_your_gender).count
          @genderfemale = SurveyMonkeyCustomer.where('what_is_your_gender=? and what_is_your_gender IN(?)', 'Female', param_value).pluck(:what_is_your_gender).count
          @individual = SurveyMonkeyCustomer.where('what_is_customer_suits_you=? and what_is_your_gender IN(?)', 'Individual Employer', param_value).pluck(:what_is_customer_suits_you).count
          @customer_type = SurveyMonkeyCustomer.pluck(:what_is_customer_suits_you).uniq
          @registrationmedium = SurveyMonkeyCustomer.pluck(:where_did_you_register_your_worker).uniq
          @company = SurveyMonkeyCustomer.where('what_is_customer_suits_you=? and what_is_your_gender IN(?)', 'Company Employer', param_value).pluck(:what_is_customer_suits_you).count
          @agent = SurveyMonkeyCustomer.where(' what_is_customer_suits_you=? and what_is_your_gender IN(?)', 'Agent', param_value).pluck(:what_is_customer_suits_you).count

          @facebook = SurveyMonkeyCustomer.where('facebook=? and what_is_your_gender IN(?)', 'Facebook', param_value).pluck(:facebook).count
          @twitter = SurveyMonkeyCustomer.where('twitter=? and what_is_your_gender IN(?)', 'Twitter', param_value).pluck(:twitter).count
          @instagram = SurveyMonkeyCustomer.where('instagram=? and what_is_your_gender IN(?)', 'Instagram', param_value).pluck(:instagram).count
          @telegram = SurveyMonkeyCustomer.where('telegram=? and what_is_your_gender IN(?)', 'Telegram', param_value).pluck(:telegram).count
          @OtherSM = SurveyMonkeyCustomer.where('other_social!=? and what_is_your_gender IN(?)', '', param_value).pluck(:other_social).count

          @operatingsocial = SurveyMonkeyCustomer.where('announcement_business_operator=? and what_is_your_gender IN(?)', 'Yes', param_value).pluck(:announcement_business_operator).count
          @operatingsocialNo = SurveyMonkeyCustomer.where('announcement_business_operator=? and what_is_your_gender IN(?)', 'No', param_value).pluck(:announcement_business_operator).count
          @health_awareness = SurveyMonkeyCustomer.where('delivering_health=? and what_is_your_gender IN(?)', 'Yes', param_value).pluck(:delivering_health).count
          @health_awarenessNo = SurveyMonkeyCustomer.where('delivering_health=? and what_is_your_gender IN(?)', 'No', param_value).pluck(:delivering_health).count
          @moh_moha = SurveyMonkeyCustomer.where('"aligned_info_moh_MOHA"=? and what_is_your_gender IN(?)', 'Yes', param_value).pluck(:aligned_info_moh_MOHA).count
          @moh_mohaNo = SurveyMonkeyCustomer.where('"aligned_info_moh_MOHA"=? and what_is_your_gender IN(?)', 'No', param_value).pluck(:aligned_info_moh_MOHA).count

          # employee reg webportal and reg office
          @employeeregweb1 = SurveyMonkeyCustomer.where("process_emp_reg=? and where_did_you_register_your_worker=? and what_is_your_gender IN(?)", '1', 'Web Portal', param_value).count
          @employeeregweb2 = SurveyMonkeyCustomer.where("process_emp_reg=? and where_did_you_register_your_worker=? and what_is_your_gender IN(?)", '2', 'Web Portal', param_value).count
          @employeeregweb3 = SurveyMonkeyCustomer.where("process_emp_reg=? and where_did_you_register_your_worker=? and what_is_your_gender IN(?)", '3', 'Web Portal', param_value).count
          @employeeregweb4 = SurveyMonkeyCustomer.where("process_emp_reg=? and where_did_you_register_your_worker=? and what_is_your_gender IN(?)", '4', 'Web Portal', param_value).count
          @employeeregweb5 = SurveyMonkeyCustomer.where("process_emp_reg=? and where_did_you_register_your_worker=? and what_is_your_gender IN(?)", '5', 'Web Portal', param_value).count

          @employeeregweball = (@employeeregweb1 * 1) + (@employeeregweb2 * 2) + (@employeeregweb3 * 3) + (@employeeregweb4 * 4) + (@employeeregweb5 * 5)
          @employeeregweballcount = @employeeregweb1 + @employeeregweb2 + @employeeregweb3 + @employeeregweb4 + @employeeregweb5
          if (@employeeregweballcount > 0)
            @employeeregweballsum = @employeeregweball / @employeeregweballcount
          else
            @employeeregweballsum = 0
          end

          @employeeregreg1 = SurveyMonkeyCustomer.where("process_emp_reg=? and where_did_you_register_your_worker=? and what_is_your_gender IN(?)", '1', 'Regional Office', param_value).count
          @employeeregreg2 = SurveyMonkeyCustomer.where("process_emp_reg=? and where_did_you_register_your_worker=? and what_is_your_gender IN(?)", '2', 'Regional Office', param_value).count
          @employeeregreg3 = SurveyMonkeyCustomer.where("process_emp_reg=? and where_did_you_register_your_worker=? and what_is_your_gender IN(?)", '3', 'Regional Office', param_value).count
          @employeeregreg4 = SurveyMonkeyCustomer.where("process_emp_reg=? and where_did_you_register_your_worker=? and what_is_your_gender IN(?)", '4', 'Regional Office', param_value).count
          @employeeregreg5 = SurveyMonkeyCustomer.where("process_emp_reg=? and where_did_you_register_your_worker=? and what_is_your_gender IN(?)", '5', 'Regional Office', param_value).count

          @employeeregregall = (@employeeregreg1 * 1) + (@employeeregreg2 * 2) + (@employeeregreg3 * 3) + (@employeeregreg4 * 4) + (@employeeregreg5 * 5)
          @employeeregregcount = @employeeregreg1 + @employeeregreg2 + @employeeregreg3 + @employeeregreg4 + @employeeregreg5
          if (@employeeregregcount > 0)
            @employeeregregsum = @employeeregregall / @employeeregregcount
          else
            @employeeregregsum = 0
          end

          # worker reg webportal and reg office
          @workerregweb1 = SurveyMonkeyCustomer.where("process_worker_reg=? and where_did_you_register_your_worker=? and what_is_your_gender IN(?)", '1', 'Web Portal', param_value).count
          @workerregweb2 = SurveyMonkeyCustomer.where("process_worker_reg=? and where_did_you_register_your_worker=? and what_is_your_gender IN(?)", '2', 'Web Portal', param_value).count
          @workerregweb3 = SurveyMonkeyCustomer.where("process_worker_reg=? and where_did_you_register_your_worker=? and what_is_your_gender IN(?)", '3', 'Web Portal', param_value).count
          @workerregweb4 = SurveyMonkeyCustomer.where("process_worker_reg=? and where_did_you_register_your_worker=? and what_is_your_gender IN(?)", '4', 'Web Portal', param_value).count
          @workerregweb5 = SurveyMonkeyCustomer.where("process_worker_reg=? and where_did_you_register_your_worker=? and what_is_your_gender IN(?)", '5', 'Web Portal', param_value).count

          @workerregweball = (@workerregweb1 * 1) + (@workerregweb2 * 2) + (@workerregweb3 * 3) + (@workerregweb4 * 4) + (@workerregweb5 * 5)
          @workerregweballcount = @workerregweb1 + @workerregweb2 + @workerregweb3 + @workerregweb4 + @workerregweb5
          if (@workerregweballcount > 0)
            @workerregweballsum = @workerregweball / @workerregweballcount
          else
            @workerregweballsum = 0
          end
          @workerregreg1 = SurveyMonkeyCustomer.where("process_worker_reg=? and where_did_you_register_your_worker=? and what_is_your_gender IN(?)", '1', 'Regional Office', param_value).count
          @workerregreg2 = SurveyMonkeyCustomer.where("process_worker_reg=? and where_did_you_register_your_worker=? and what_is_your_gender IN(?)", '2', 'Regional Office', param_value).count
          @workerregreg3 = SurveyMonkeyCustomer.where("process_worker_reg=? and where_did_you_register_your_worker=? and what_is_your_gender IN(?)", '3', 'Regional Office', param_value).count
          @workerregreg4 = SurveyMonkeyCustomer.where("process_worker_reg=? and where_did_you_register_your_worker=? and what_is_your_gender IN(?)", '4', 'Regional Office', param_value).count
          @workerregreg5 = SurveyMonkeyCustomer.where("process_worker_reg=? and where_did_you_register_your_worker=? and what_is_your_gender IN(?)", '5', 'Regional Office', param_value).count

          @workerregregall = (@workerregreg1 * 1) + (@workerregreg2 * 2) + (@workerregreg3 * 3) + (@workerregreg4 * 4) + (@workerregreg5 * 5)
          @workerregregcount = @workerregreg1 + @workerregreg2 + @workerregreg3 + @workerregreg4 + @workerregreg5
          if (@workerregregcount > 0)
            @workerregregsum = @workerregregall / @workerregregcount
          else
            @workerregregsum = 0
          end
          # panel clinic reg webportal and reg office
          @panelregweb1 = SurveyMonkeyCustomer.where("panel_clinic_xray_facilities=? and where_did_you_register_your_worker=? and what_is_your_gender IN(?)", '1', 'Web Portal', param_value).count
          @panelregweb2 = SurveyMonkeyCustomer.where("panel_clinic_xray_facilities=? and where_did_you_register_your_worker=? and what_is_your_gender IN(?)", '2', 'Web Portal', param_value).count
          @panelregweb3 = SurveyMonkeyCustomer.where("panel_clinic_xray_facilities=? and where_did_you_register_your_worker=? and what_is_your_gender IN(?)", '3', 'Web Portal', param_value).count
          @panelregweb4 = SurveyMonkeyCustomer.where("panel_clinic_xray_facilities=? and where_did_you_register_your_worker=? and what_is_your_gender IN(?)", '4', 'Web Portal', param_value).count
          @panelregweb5 = SurveyMonkeyCustomer.where("panel_clinic_xray_facilities=? and where_did_you_register_your_worker=? and what_is_your_gender IN(?)", '5', 'Web Portal', param_value).count

          @panelregweball = (@panelregweb1 * 1) + (@panelregweb2 * 2) + (@panelregweb3 * 3) + (@panelregweb4 * 4) + (@panelregweb5 * 5)
          @panelregweballcount = @panelregweb1 + @panelregweb2 + @panelregweb3 + @panelregweb4 + @panelregweb5
          if (@panelregweballcount > 0)
            @panelregweballsum = @panelregweball / @panelregweballcount
          else
            @panelregweballsum = 0
          end

          @panelregreg1 = SurveyMonkeyCustomer.where("panel_clinic_xray_facilities=? and where_did_you_register_your_worker=? and what_is_your_gender IN(?)", '1', 'Regional Office', param_value).count
          @panelregreg2 = SurveyMonkeyCustomer.where("panel_clinic_xray_facilities=? and where_did_you_register_your_worker=? and what_is_your_gender IN(?)", '2', 'Regional Office', param_value).count
          @panelregreg3 = SurveyMonkeyCustomer.where("panel_clinic_xray_facilities=? and where_did_you_register_your_worker=? and what_is_your_gender IN(?)", '3', 'Regional Office', param_value).count
          @panelregreg4 = SurveyMonkeyCustomer.where("panel_clinic_xray_facilities=? and where_did_you_register_your_worker=? and what_is_your_gender IN(?)", '4', 'Regional Office', param_value).count
          @panelregreg5 = SurveyMonkeyCustomer.where("panel_clinic_xray_facilities=? and where_did_you_register_your_worker=? and what_is_your_gender IN(?)", '5', 'Regional Office', param_value).count

          @panelregregall = (@panelregreg1 * 1) + (@panelregreg2 * 2) + (@panelregreg3 * 3) + (@panelregreg4 * 4) + (@panelregreg5 * 5)
          @panelregregcount = @panelregreg1 + @panelregreg2 + @panelregreg3 + @panelregreg4 + @panelregreg5
          if (@panelregregcount > 0)
            @panelregregsum = @panelregregall / @panelregregcount
          else
            @panelregregsum = 0
          end

          # overall reg webportal and reg office
          @overallregweb1 = SurveyMonkeyCustomer.where("overall_experience_reg_process=? and where_did_you_register_your_worker=? and what_is_your_gender IN(?)", '1', 'Web Portal', param_value).count
          @overallregweb2 = SurveyMonkeyCustomer.where("overall_experience_reg_process=? and where_did_you_register_your_worker=? and what_is_your_gender IN(?)", '2', 'Web Portal', param_value).count
          @overallregweb3 = SurveyMonkeyCustomer.where("overall_experience_reg_process=? and where_did_you_register_your_worker=? and what_is_your_gender IN(?)", '3', 'Web Portal', param_value).count
          @overallregweb4 = SurveyMonkeyCustomer.where("overall_experience_reg_process=? and where_did_you_register_your_worker=? and what_is_your_gender IN(?)", '4', 'Web Portal', param_value).count
          @overallregweb5 = SurveyMonkeyCustomer.where("overall_experience_reg_process=? and where_did_you_register_your_worker=? and what_is_your_gender IN(?)", '5', 'Web Portal', param_value).count

          @overallregweball = (@overallregweb1 * 1) + (@overallregweb2 * 2) + (@overallregweb3 * 3) + (@overallregweb4 * 4) + (@overallregweb5 * 5)
          @overallregweballcount = @overallregweb1 + @overallregweb2 + @overallregweb3 + @overallregweb4 + @overallregweb5
          if (@overallregweballcount > 0)
            @overallregweballsum = @overallregweball / @overallregweballcount
          else
            @overallregweballsum = 0
          end
          @overallregreg1 = SurveyMonkeyCustomer.where("overall_experience_reg_process=? and where_did_you_register_your_worker=? and what_is_your_gender IN(?)", '1', 'Regional Office', param_value).count
          @overallregreg2 = SurveyMonkeyCustomer.where("overall_experience_reg_process=? and where_did_you_register_your_worker=? and what_is_your_gender IN(?)", '2', 'Regional Office', param_value).count
          @overallregreg3 = SurveyMonkeyCustomer.where("overall_experience_reg_process=? and where_did_you_register_your_worker=? and what_is_your_gender IN(?)", '3', 'Regional Office', param_value).count
          @overallregreg4 = SurveyMonkeyCustomer.where("overall_experience_reg_process=? and where_did_you_register_your_worker=? and what_is_your_gender IN(?)", '4', 'Regional Office', param_value).count
          @overallregreg5 = SurveyMonkeyCustomer.where("overall_experience_reg_process=? and where_did_you_register_your_worker=? and what_is_your_gender IN(?)", '5', 'Regional Office', param_value).count

          @overallregregall = (@overallregreg1 * 1) + (@overallregreg2 * 2) + (@overallregreg3 * 3) + (@overallregreg4 * 4) + (@overallregreg5 * 5)
          @overallregregcount = @overallregreg1 + @overallregreg2 + @overallregreg3 + @overallregreg4 + @overallregreg5
          if (@overallregregcount > 0)
            @overallregregsum = @overallregregall / @overallregregcount
          else
            @overallregregsum = 0
          end

          @appealworkerstatus = SurveyMonkeyCustomer.where('worker_status_found_medical_unsuitable=? and what_is_your_gender IN(?)', 'Yes', param_value).pluck(:worker_status_found_medical_unsuitable).count
          @appealworkerstatusNo = SurveyMonkeyCustomer.where('worker_status_found_medical_unsuitable=? and what_is_your_gender IN(?)', 'No', param_value).pluck(:worker_status_found_medical_unsuitable).count
          @appealundergostatus = SurveyMonkeyCustomer.where('undergo_fomema_appeal_process=? and what_is_your_gender IN(?)', 'Yes', param_value).pluck(:undergo_fomema_appeal_process).count
          @appealundergostatusNo = SurveyMonkeyCustomer.where('undergo_fomema_appeal_process=? and what_is_your_gender IN(?)', 'No', param_value).pluck(:undergo_fomema_appeal_process).count
          @appealoverall1 = SurveyMonkeyCustomer.where('tell_experience_appeal_process=? and what_is_your_gender IN(?)', '1', param_value).pluck(:tell_experience_appeal_process).count
          @appealoverall2 = SurveyMonkeyCustomer.where('tell_experience_appeal_process=? and what_is_your_gender IN(?)', '2', param_value).pluck(:tell_experience_appeal_process).count
          @appealoverall3 = SurveyMonkeyCustomer.where('tell_experience_appeal_process=? and what_is_your_gender IN(?)', '3', param_value).pluck(:tell_experience_appeal_process).count
          @appealoverall4 = SurveyMonkeyCustomer.where('tell_experience_appeal_process=? and what_is_your_gender IN(?)', '4', param_value).pluck(:tell_experience_appeal_process).count
          @appealoverall5 = SurveyMonkeyCustomer.where('tell_experience_appeal_process=? and what_is_your_gender IN(?)', '5', param_value).pluck(:tell_experience_appeal_process).count
          @appealoverall = (@appealoverall1 * 1) + (@appealoverall2 * 2) + (@appealoverall3 * 3) + (@appealoverall4 * 4) + (@appealoverall5 * 5)
          @appealoverallcount = @appealoverall1 + @appealoverall2 + @appealoverall3 + @appealoverall4 + @appealoverall5
          if (@appealoverallcount > 0)
            @appealoverallsum = @appealoverall / @appealoverallcount
          else
            @appealoverallsum = 0
          end

          # NPS registration web portal
          @NPSregweb1 = SurveyMonkeyCustomer.where("process_emp_reg=? and process_worker_reg=? and panel_clinic_xray_facilities=? and overall_experience_reg_process=? and where_did_you_register_your_worker=? and what_is_your_gender IN(?)", '1', '1', '1', '1', 'Web Portal', param_value).count
          @NPSregweb2 = SurveyMonkeyCustomer.where("process_emp_reg=? and process_worker_reg=? and panel_clinic_xray_facilities=? and overall_experience_reg_process=? and where_did_you_register_your_worker=? and what_is_your_gender IN(?)", '2', '2', '2', '2', 'Web Portal', param_value).count
          @NPSregweb3 = SurveyMonkeyCustomer.where("process_emp_reg=? and process_worker_reg=? and panel_clinic_xray_facilities=? and overall_experience_reg_process=? and where_did_you_register_your_worker=? and what_is_your_gender IN(?)", '3', '3', '3', '3', 'Web Portal', param_value).count
          @NPSregweb4 = SurveyMonkeyCustomer.where("process_emp_reg=? and process_worker_reg=? and panel_clinic_xray_facilities=? and overall_experience_reg_process=? and where_did_you_register_your_worker=? and what_is_your_gender IN(?)", '4', '4', '4', '4', 'Web Portal', param_value).count
          @NPSregweb5 = SurveyMonkeyCustomer.where("process_emp_reg=? and process_worker_reg=? and panel_clinic_xray_facilities=? and overall_experience_reg_process=? and where_did_you_register_your_worker=? and what_is_your_gender IN(?)", '5', '5', '5', '5', 'Web Portal', param_value).count

          @NPSregweball = (@NPSregweb1 * 1) + (@NPSregweb2 * 2) + (@NPSregweb3 * 3) + (@NPSregweb4 * 4) + (@NPSregweb5 * 5)
          @NPSregwebpromoters = @NPSregweb4 + @NPSregweb5
          @NPSregwebdectoters = @NPSregweb1 + @NPSregweb2
          if (@NPSregweball > 0)
            @NPSwebpercentagepromoters = (@NPSregwebpromoters / @NPSregweball) * 100
            @NPSwebpercentagedectaters = (@NPSregwebdectoters / @NPSregweball) * 100
            @NPSoverallpercentage = @NPSwebpercentagepromoters - @NPSwebpercentagedectaters
          else
            @NPSoverallpercentage = 0
          end
          # NPS registration regional office
          @NPSregreg1 = SurveyMonkeyCustomer.where("process_emp_reg=? and process_worker_reg=? and panel_clinic_xray_facilities=? and overall_experience_reg_process=? and where_did_you_register_your_worker=? and what_is_your_gender IN(?)", '1', '1', '1', '1', 'Regional Office', param_value).count
          @NPSregreg2 = SurveyMonkeyCustomer.where("process_emp_reg=? and process_worker_reg=? and panel_clinic_xray_facilities=? and overall_experience_reg_process=? and where_did_you_register_your_worker=? and what_is_your_gender IN(?)", '2', '2', '2', '2', 'Regional Office', param_value).count
          @NPSregreg3 = SurveyMonkeyCustomer.where("process_emp_reg=? and process_worker_reg=? and panel_clinic_xray_facilities=? and overall_experience_reg_process=? and where_did_you_register_your_worker=? and what_is_your_gender IN(?)", '3', '3', '3', '3', 'Regional Office', param_value).count
          @NPSregreg4 = SurveyMonkeyCustomer.where("process_emp_reg=? and process_worker_reg=? and panel_clinic_xray_facilities=? and overall_experience_reg_process=? and where_did_you_register_your_worker=? and what_is_your_gender IN(?)", '4', '4', '4', '4', 'Regional Office', param_value).count
          @NPSregreg5 = SurveyMonkeyCustomer.where("process_emp_reg=? and process_worker_reg=? and panel_clinic_xray_facilities=? and overall_experience_reg_process=? and where_did_you_register_your_worker=? and what_is_your_gender IN(?)", '5', '5', '5', '5', 'Regional Office', param_value).count

          @NPSregregall = (@NPSregreg1 * 1) + (@NPSregreg2 * 2) + (@NPSregreg3 * 3) + (@NPSregreg4 * 4) + (@NPSregreg5 * 5)
          @NPSregregpromoters = @NPSregreg4 + @NPSregreg5
          @NPSregregdectoters = @NPSregreg1 + @NPSregreg2
          if (@NPSregregall > 0)
            @NPSregpercentagepromoters = (@NPSregregpromoters / @NPSregregall) * 100
            @NPSregpercentagedectaters = (@NPSregregdectoters / @NPSregregall) * 100
            @NPSregoverallpercentage = @NPSregpercentagepromoters - @NPSregpercentagedectaters
          else
            @NPSregoverallpercentage = 0
          end
          # NPS Examination services
          @NPSExs1 = SurveyMonkeyCustomer.where("location_panel_clinics=? and 'Fomema_medical_examincation_are_understandable'=? and 'medical_Examinations_are_easy_toobtain'=? and 'Overall_rate_experience_medical_examination'=? and what_is_your_gender IN(?)", '1', '1', '1', '1', param_value).count
          @NPSExs2 = SurveyMonkeyCustomer.where("location_panel_clinics=? and 'Fomema_medical_examincation_are_understandable'=? and 'medical_Examinations_are_easy_toobtain'=? and 'Overall_rate_experience_medical_examination'=? and what_is_your_gender IN(?)", '2', '2', '2', '2', param_value).count
          @NPSExs3 = SurveyMonkeyCustomer.where("location_panel_clinics=? and 'Fomema_medical_examincation_are_understandable'=? and 'medical_Examinations_are_easy_toobtain'=? and 'Overall_rate_experience_medical_examination'=? and what_is_your_gender IN(?)", '3', '3', '3', '3', param_value).count
          @NPSExs4 = SurveyMonkeyCustomer.where("location_panel_clinics=? and 'Fomema_medical_examincation_are_understandable'=? and 'medical_Examinations_are_easy_toobtain'=? and 'Overall_rate_experience_medical_examination'=? and what_is_your_gender IN(?)", '4', '4', '4', '4', param_value).count
          @NPSExs5 = SurveyMonkeyCustomer.where("location_panel_clinics=? and 'Fomema_medical_examincation_are_understandable'=? and 'medical_Examinations_are_easy_toobtain'=? and 'Overall_rate_experience_medical_examination'=? and what_is_your_gender IN(?)", '5', '5', '5', '5', param_value).count

          @NPSExsall = (@NPSExs1 * 1) + (@NPSExs2 * 2) + (@NPSExs3 * 3) + (@NPSExs4 * 4) + (@NPSExs5 * 5)
          @NPSExspromoters = @NPSExs4 + @NPSExs5
          @NPSExsdectoters = @NPSExs1 + @NPSExs2
          if (@NPSExsall > 0)
            @NPSExspercentagepromoters = (@NPSExspromoters / @NPSExsall) * 100
            @NPSExspercentagedectaters = (@NPSExsdectoters / @NPSExsall) * 100
            @NPSExsoverallpercentage = @NPSExspercentagepromoters - @NPSExspercentagedectaters
          else
            @NPSExsoverallpercentage = 0
          end
          # NPS appeal process
          @NPSappeal1 = SurveyMonkeyCustomer.where("tell_experience_appeal_process=? and what_is_your_gender IN(?)", '1', param_value).count
          @NPSappeal2 = SurveyMonkeyCustomer.where("tell_experience_appeal_process=? and what_is_your_gender IN(?)", '2', param_value).count
          @NPSappeal3 = SurveyMonkeyCustomer.where("tell_experience_appeal_process=? and what_is_your_gender IN(?)", '3', param_value).count
          @NPSappeal4 = SurveyMonkeyCustomer.where("tell_experience_appeal_process=? and what_is_your_gender IN(?)", '4', param_value).count
          @NPSappeal5 = SurveyMonkeyCustomer.where("tell_experience_appeal_process=? and what_is_your_gender IN(?)", '5', param_value).count

          @NPSappealall = (@NPSappeal1 * 1) + (@NPSappeal2 * 2) + (@NPSappeal3 * 3) + (@NPSappeal4 * 4) + (@NPSappeal5 * 5)
          @NPSappealpromoters = @NPSappeal4 + @NPSappeal5
          @NPSappealdectoters = @NPSappeal1 + @NPSappeal2
          if (@NPSappealall > 0)
            @NPSappealpercentagepromoters = (@NPSappealpromoters / @NPSappealall) * 100
            @NPSappealpercentagedectaters = (@NPSappealdectoters / @NPSappealall) * 100
            @NPSappealoverallpercentage = @NPSappealpercentagepromoters - @NPSappealpercentagedectaters
          else
            @NPSappealoverallpercentage = 0
          end

          # NPS Average services
          if (@NPSoverallpercentage > 0)
            @NpsAveragescore = (@NPSoverallpercentage + @NPSregoverallpercentage + @NPSExsoverallpercentage + @NPSExsoverallpercentage)
            @NPSavgscore = @NpsAveragescore / 4
          else
            @NPSavgscore = 0
          end

          @panelclinic1 = SurveyMonkeyCustomer.where("location_panel_clinics=? and what_is_your_gender IN(?)", '1', param_value).count
          @panelclinic2 = SurveyMonkeyCustomer.where("location_panel_clinics=? and what_is_your_gender IN(?)", '2', param_value).count
          @panelclinic3 = SurveyMonkeyCustomer.where("location_panel_clinics=? and what_is_your_gender IN(?)", '3', param_value).count
          @panelclinic4 = SurveyMonkeyCustomer.where("location_panel_clinics=? and what_is_your_gender IN(?)", '4', param_value).count
          @panelclinic5 = SurveyMonkeyCustomer.where("location_panel_clinics=? and what_is_your_gender IN(?)", '5', param_value).count

          @panelclinic1all = (@panelclinic1 * 1) + (@panelclinic2 * 2) + (@panelclinic3 * 3) + (@panelclinic4 * 4) + (@panelclinic5 * 5)
          @panelclinic1count = @panelclinic1 + @panelclinic2 + @panelclinic3 + @panelclinic4 + @panelclinic5
          if (@panelclinic1all > 0)
            @panelclinics = @panelclinic1all / @panelclinic1count
          else
            @panelclinics = 0
          end

          @understantable1 = SurveyMonkeyCustomer.where("'Fomema_medical_examincation_are_understandable'=? and what_is_your_gender IN(?)", '1', param_value).count
          @understantable2 = SurveyMonkeyCustomer.where("'Fomema_medical_examincation_are_understandable'=? and what_is_your_gender IN(?)", '2', param_value).count
          @understantable3 = SurveyMonkeyCustomer.where("'Fomema_medical_examincation_are_understandable'=? and what_is_your_gender IN(?)", '3', param_value).count
          @understantable4 = SurveyMonkeyCustomer.where("'Fomema_medical_examincation_are_understandable'=? and what_is_your_gender IN(?)", '4', param_value).count
          @understantable5 = SurveyMonkeyCustomer.where("'Fomema_medical_examincation_are_understandable'=? and what_is_your_gender IN(?)", '5', param_value).count

          @understantableall = (@understantable1 * 1) + (@understantable2 * 2) + (@understantable3 * 3) + (@understantable4 * 4) + (@understantable5 * 5)
          @understantablecount = @understantable1 + @understantable2 + @understantable3 + @understantable4 + @understantable5
          if (@understantableall > 0)
            @understantable = @understantableall / @understantablecount
          else
            @understantable = 0
          end

          @obtainable1 = SurveyMonkeyCustomer.where("'medical_Examinations_are_easy_toobtain'=? and what_is_your_gender IN(?)", '1', param_value).count
          @obtainable2 = SurveyMonkeyCustomer.where("'medical_Examinations_are_easy_toobtain'=? and what_is_your_gender IN(?)", '2', param_value).count
          @obtainable3 = SurveyMonkeyCustomer.where("'medical_Examinations_are_easy_toobtain'=? and what_is_your_gender IN(?)", '3', param_value).count
          @obtainable4 = SurveyMonkeyCustomer.where("'medical_Examinations_are_easy_toobtain'=? and what_is_your_gender IN(?)", '4', param_value).count
          @obtainable5 = SurveyMonkeyCustomer.where("'medical_Examinations_are_easy_toobtain'=? and what_is_your_gender IN(?)", '5', param_value).count

          @obtainableall = (@obtainable1 * 1) + (@obtainable2 * 2) + (@obtainable3 * 3) + (@obtainable4 * 4) + (@obtainable5 * 5)
          @obtainablecount = @obtainable1 + @obtainable2 + @obtainable3 + @obtainable4 + @obtainable5
          if (@obtainableall > 0)
            @obtainable = @obtainableall / @obtainablecount
          else
            @obtainable = 0
          end

          @overallexp1 = SurveyMonkeyCustomer.where("'Overall_rate_experience_medical_examination'=? and what_is_your_gender IN(?)", '1', param_value).count
          @overallexp2 = SurveyMonkeyCustomer.where("'Overall_rate_experience_medical_examination'=? and what_is_your_gender IN(?)", '2', param_value).count
          @overallexp3 = SurveyMonkeyCustomer.where("'Overall_rate_experience_medical_examination'=? and what_is_your_gender IN(?)", '3', param_value).count
          @overallexp4 = SurveyMonkeyCustomer.where("'Overall_rate_experience_medical_examination'=? and what_is_your_gender IN(?)", '4', param_value).count
          @overallexp5 = SurveyMonkeyCustomer.where("'Overall_rate_experience_medical_examination'=? and what_is_your_gender IN(?)", '5', param_value).count

          @overallexpall = (@overallexp1 * 1) + (@overallexp2 * 2) + (@overallexp3 * 3) + (@overallexp4 * 4) + (@overallexp5 * 5)
          @overallexpcount = @overallexp1 + @overallexp2 + @overallexp3 + @overallexp4 + @overallexp5
          if (@overallexpall > 0)
            @overallexp = @overallexpall / @overallexpcount
          else
            @overallexp = 0
          end
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