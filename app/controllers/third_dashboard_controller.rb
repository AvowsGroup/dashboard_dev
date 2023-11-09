class ThirdDashboardController < ApplicationController
  before_action :initialize_date_range, only: [:index, :kpi_percentage, :review_xray, :pcr_xray]

  def index
    @task_list = tasks
    result_key
    page_number = params[:page] || 1
    @users = User.select(:name, :designation).paginate(page: page_number, per_page: 10)
  end

  def third_db_data
    @params = JSON.parse(params.keys.first)
    page_number = params[:page] || 1
    @task_list = tasks
    result_key
    @users = User.select(:name, :designation).paginate(page: page_number, per_page: 10)
  end

  def initialize_date_range
    @current_date = Date.today
    @beginning_of_year = Date.new(@current_date.year, 1, 1).to_s
    @end_of_year = Date.new(@current_date.year, 12, 31).to_s
  end

  private

  def result_key
    @kpi_data = {
      customer_service: @task_list.select { |hash| ["Email", "Chat", "Bypass fingerprint approval"].include?(hash[:task]) },
      support_service: @task_list.select { |hash| ["Employer Registration", "Agency Registration", "Foreign Worker Amendment", "Change Employer (transfer worker)", "Special Renewal Approval (unfit)", "Update Employer Detail Approval (Employer)"].include?(hash[:task]) },
      xray_quality: @task_list.select { |hash| ["Review - Normal chest X-ray", "Audit - Abnormal chest X-ray", "XQCC Amendment"].include?(hash[:task]) },
      laboratory_quality: @task_list.select { |hash| ["Laboratory"].include?(hash[:task]) },
      inspectorate: @task_list.select { |hash| ["Doctor Visit", "X-ray Visit"].include?(hash[:task]) },
      finance_admin: @task_list.select { |hash| ["Payment to service providers (Doctor, X-ray, Laboratory)", "Refund to Employers", "Insurance payment to Fomema Global Sdn Bhd"].include?(hash[:task]) },
      medical_review: @task_list.select { |hash| ["Appeal cases", "Pending Review Cases", "TCUPI Cases", "Employer Enquiry JIVO"].include?(hash[:task]) },
      regional_office: @task_list.select { |hash| ["Change of employer (transfer)", "Amendment of Foreign worker info", "Special Renewal Approval (unfit)", "Update employer details", "Employer Registration Approval"].include?(hash[:task]) },
      human_capital: @task_list.select { |hash| ["Staff Claims Submission"].include?(hash[:task]) },
      management: @task_list.select { |hash| ["Approval for registration of service provider", "Activating new service provider"].include?(hash[:task]) }
    }
  end

  def tasks
    kpi_percentage = rand(2500..7000) / 100.0
    @params ||= {}
    [
      {
        KPI: kpi_round_off, # yet to be discussed
        task: 'Email',
        TAT: 'First response time within 24 business hours',
        target: '80%'
      },
      {
        KPI: kpi_round_off, # yet to be discussed
        task: 'Chat',
        TAT: 'First response time within 24 business hours ',
        target: '80%'
      },
      {
        KPI: kpi_round_off, # yet to be discussed
        task: 'Bypass fingerprint approval',
        TAT: '24 business hours',
        target: '80%'
      },
      {
        KPI: kpi_round_off,
        task: 'Employer Registration',
        TAT: '2wd',
        target: '80%'
      },
      {
        KPI: kpi_round_off,
        task: 'Agency Registration',
        TAT: '14wd',
        target: '80%'
      },
      {
        KPI: kpi_round_off, # yet to be discussed
        task: 'Foreign Worker Amendment',
        TAT: '3wd',
        target: '80%'
      },
      {
        KPI: kpi_round_off,
        task: 'Change Employer (transfer worker)',
        TAT: '3wd',
        target: '80%'
      },
      
      {
        KPI: kpi_round_off,
        task: 'Update Employer Detail Approval (Employer)',
        TAT: '3wd',
        target: '80%'
      },
      {
        KPI: kpi_round_off,
        task: 'Review - Normal chest X-ray',
        TAT: '72 hours from the date of certification',
        target: '80%'
      },
      {
        KPI: kpi_round_off,
        task: 'Audit - Abnormal chest X-ray',
        TAT: '48 hours from the date of certification',
        target: '80%'
      },
      {
        KPI: kpi_round_off, # yet to be discussed
        task: 'XQCC Amendment',
        TAT: 'Four (4) weeks from the date of confirmation',
        target: '80%'
      },
      {
        KPI: kpi_round_off,
        task: 'Laboratory',
        TAT: 'Calendar year',
        target: '100%'
      },
      {
        KPI: kpi_round_off,
        task: 'Doctor Visit',
        TAT: 'Calendar year',
        target: '100%'
      },
      {
        KPI: kpi_round_off,
        task: 'X-ray Visit',
        TAT: 'Calendar year',
        target: '100%'
      },
      {
        KPI: kpi_round_off, # yet to be discussed
        task: 'Payment to service providers (Doctor, X-ray, Laboratory)',
        TAT: 'For every 7 working days, Finance team will generate data from Nios and transmit those data to Sage, our accounting system, to perform the payment processes.The payments will be generated into 5 batches based on the certification dates:(1st - 6th) (7th - 12th) (13th -18th) (19th -24th) (25th -30th)',
        target: '100%'
      },
      {
        KPI: kpi_round_off, # yet to be discussed
        task: 'Refund to Employers',
        TAT: 'For every 7 working days, Finance team will generate data from Nios and transmit those data to Sage, our accounting system, to perform the payment processes.The payments will be generated into 5 batches based on the certification dates:(1st - 6th) (7th - 12th) (13th -18th) (19th -24th) (25th -30th)',
        target: '80%'
      },
      {
        KPI: kpi_round_off, # yet to be discussed
        task: 'Insurance payment to Fomema Global Sdn Bhd',
        TAT: 'For every 7 working days, Finance team will generate data from Nios and transmit those data to Sage, our accounting system, to perform the payment processes.The payments will be generated into 5 batches based on the certification dates:(1st - 6th) (7th - 12th) (13th -18th) (19th -24th) (25th -30th)',
        target: '80%'
      },
      {
        KPI: kpi_round_off, # yet to be discussed
        task: 'Appeal cases',
        TAT: '28wd',
        target: '90%'
      },
      {
        KPI: kpi_round_off, # yet to be discussed
        task: 'Pending Review Cases',
        TAT: '3wd',
        target: '90%'
      },
      {
        KPI: kpi_round_off, # yet to be discussed
        task: 'TCUPI Cases',
        TAT: '28wd',
        target: '90%'
      },
      {
        KPI: kpi_round_off, # yet to be discussed
        task: 'Employer Enquiry JIVO',
        TAT: '24 hours',
        target: '100%'
      },
      {
        KPI: kpi_round_off,
        task: 'Change of employer (transfer)',
        TAT: '3wd',
        target: '80%'
      },
      {
        KPI: kpi_round_off,
        task: 'Amendment of Foreign worker info',
        TAT: '3wd',
        target: '80%'
      },
      {
        KPI: kpi_round_off,
        task: 'Special Renewal Approval (unfit)',
        TAT: '3wd',
        target: '80%'
      },
      {
        KPI: kpi_round_off,
        task: 'Update employer details',
        TAT: '3wd',
        target: '80%'
      },
      {
        KPI: kpi_round_off,
        task: 'Employer Registration Approval',
        TAT: '2wd',
        target: '80%'
      },
      {
        KPI: kpi_round_off,
        task: 'Staff Claims Submission',
        TAT: 'One Week from date HODs approved to HCM verification',
        target: '90%'
      },
      {
        KPI: kpi_round_off,
        task: 'Approval for registration of service provider',
        TAT: '14wd',
        target: '80%'
      },
      {
        KPI: kpi_round_off,
        task: 'Activating new service provider',
        TAT: '10wd',
        target: '80%'
      }
    ]
  end

  def kpi_percentage(model_name, tat)
    achieved_count = 0
    not_achieved_count = 0
    total_count = 0

    if params[:dateRange].present?
      start_date, end_date = params[:dateRange].split(" - ").map { |date| Date.strptime(date, "%d/%m/%Y") }
    else
      start_date = @beginning_of_year
      end_date = @end_of_year
    end

    case model_name
    when "Employer"
      achieved_count = Employer.where("created_at <= registration_approved_at + interval '? days'", tat).count
      not_achieved_count = Employer.where("created_at > registration_approved_at + interval '? days'", tat).count

    when "Agencies"
      achieved_count = Agency.where("created_at <= registration_approved_at + interval '? days'", tat).count
      not_achieved_count = Agency.where("created_at > registration_approved_at + interval '? days'", tat).count

    when "ApprovalRequest"
      achieved_count = ApprovalRequest.where("approved_at <= requested_at + interval '? days'", tat).count
      not_achieved_count = ApprovalRequest.where("approved_at > requested_at + interval '? days'", tat).count

    when "FwChangeEmployer"
      achieved_count = FwChangeEmployer.where("approval_at <= requested_at + interval '? days'", tat).count
      not_achieved_count = FwChangeEmployer.where("approval_at > requested_at + interval '? days'", tat).count

    when "Laboratory"
      total_active = Laboratory.where(status: 'ACTIVE').count
      #total_visit = VisitReport.where(visit_date: start_date..end_date).count

    when "DoctorVisit"
      total_active = Doctor.where(status: 'ACTIVE').count
      #total_visit = VisitReport.where(visit_date: start_date..end_date).count

    when "XrayFacility"
      total_active = XrayFacility.where(status: 'ACTIVE').count
      #total_visit = VisitReport.where(visit_date: start_date..end_date).count

    when "ApprovalandActivation"
      doctor_achieved = Doctor.where("registration_approved_at <= created_at + interval '? days'", tat).count
      doctor_not_achieved = Doctor.where("registration_approved_at > created_at + interval '? days'", tat).count
      xray_achieved = XrayFacility.where("registration_approved_at <= created_at + interval '? days'", tat).count
      xray_not_achieved = XrayFacility.where("registration_approved_at > created_at + interval '? days'", tat).count
      lab_achived = Laboratory.where("registration_approved_at <= created_at + interval '? days'", tat).count
      lab_not_achieved = Laboratory.where("registration_approved_at > created_at + interval '? days'", tat).count
      achieved_count = doctor_achieved + xray_achieved + lab_achived
      not_achieved_count = doctor_not_achieved + xray_not_achieved + lab_not_achieved
    end

    if model_name == "Laboratory" || model_name == "DoctorVisit" || model_name == "XrayFacility"
      #achieved_count = total_visit
      total_count = total_active
    else
      total_count = achieved_count + not_achieved_count
    end

    kpi_percentage = total_count > 0 ? (achieved_count.to_f / total_count) * 100 : 0
    kpi_percentage.round(1) # Round to one decimal place
  end

  def review_xray
    achieved_count = 0
    not_achieved_count = 0

    if params[:dateRange].present?
      start_date, end_date = params[:dateRange].split(" - ").map { |date| Date.strptime(date, "%d/%m/%Y") }
    else
      start_date = @beginning_of_year
      end_date = @end_of_year
    end

    achieved_count = Transaction.joins("INNER JOIN xray_reviews ON xray_reviews.id = transactions.xray_review_id")
                                .where("xray_reviews.transmitted_at <= transactions.certification_date + INTERVAL '3' DAY")
                                .where(transactions: { transaction_date: start_date..end_date })
                                .count

    not_achieved_count = Transaction.joins("INNER JOIN xray_reviews ON xray_reviews.id = transactions.xray_review_id")
                                    .where("xray_reviews.transmitted_at > transactions.certification_date + INTERVAL '3' DAY")
                                    .where(transactions: { transaction_date: start_date..end_date })
                                    .count

    total_count = achieved_count + not_achieved_count
    kpi_percentage = total_count > 0 ? (achieved_count.to_f / total_count) * 100 : 0
    kpi_percentage.round(1) # Round to one decimal place

  end

  def pcr_xray
    achieved_count = 0
    not_achieved_count = 0

    if params[:dateRange].present?
      start_date, end_date = params[:dateRange].split(" - ").map { |date| Date.strptime(date, "%d/%m/%Y") }
    else
      start_date = @beginning_of_year
      end_date = @end_of_year
    end

    achieved_count = PcrReview.joins("INNER JOIN transactions ON transactions.pcr_review_id = pcr_reviews.id")
                              .where("pcr_reviews.transmitted_at <= (transactions.certification_date + INTERVAL '2 days') AT TIME ZONE 'UTC'")
                              .where(transactions: { transaction_date: start_date..end_date })
                              .count

    not_achieved_count = PcrReview.joins("INNER JOIN transactions ON transactions.pcr_review_id = pcr_reviews.id")
                                  .where("pcr_reviews.transmitted_at > (transactions.certification_date + INTERVAL '2 days') AT TIME ZONE 'UTC'")
                                  .where(transactions: { transaction_date: start_date..end_date })
                                  .count

    total_count = achieved_count + not_achieved_count
    kpi_percentage = total_count > 0 ? (achieved_count.to_f / total_count) * 100 : 0
    kpi_percentage.round(1)

  end

  def filter_params(query = {}, records = 0)
    records = records
    query.each do |key, value|
      case key
      when "dateRange"
        start_date, end_date = value.split(" - ").map { |date| Date.strptime(date, "%d/%m/%Y") }
        records = records.where(created_at: start_date.beginning_of_day..end_date.end_of_day)
      when "month"
        unless value == "Select Monthly"
          current_year = Date.today.year
          selected_month = Date::MONTHNAMES.index(value.split(" ").last)
          records = records.where("EXTRACT(MONTH FROM created_at) = ? AND EXTRACT(YEAR FROM created_at) = ?", selected_month, current_year)
        end
        # when "week"
        #   unless value == "Select Week"
        #     selected_week = value.split(" ").last.to_i
        #     records = records.where("EXTRACT(WEEK FROM created_at) = ?", selected_week)
        #   end
      end
    end
    records
  end

  def kpi_round_off
    rand(2500..7000) / 100.0
  end


end