class ThirdDashboardController < ApplicationController
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
    @params ||= {}
    [
      {
        KPI: 0, # as there is no table menthioned in the doc
        task: 'Email',
        TAT: 'First response time within 24 business hours',
        target: '80%'
      },
      {
        KPI: 0, # as there is no table menthioned in the doc so pasting 0 in value
        task: 'Chat',
        TAT: 'First response time within 24 business hours ',
        target: '80%'
      },
      {
        KPI: kpi_percentage("Biometric", "request_date", "approval_date", 3, false, @params),
        task: 'Bypass fingerprint approval',
        TAT: '24 business hours',
        target: '80%'
      },
      {
        KPI: kpi_percentage("Employer", "registration_approved_at", "created_at", 2, false, @params),
        task: 'Employer Registration',
        TAT: '2wd',
        target: '80%'
      },
      {
        KPI: kpi_percentage("Agency", "registration_approved_at", "created_at", 14, true, @params),
        task: 'Agency Registration',
        TAT: '14wd',
        target: '80%'
      },
      {
        KPI: kpi_percentage("ApprovalRequest", "requested_at", "approved_at", 3, true, @params),
        task: 'Foreign Worker Amendment',
        TAT: '3wd',
        target: '80%'
      },
      {
        KPI: kpi_percentage("FwChangeEmployer", "requested_at", "approval_at", 3, true, @params),
        task: 'Change Employer (transfer worker)',
        TAT: '3wd',
        target: '80%'
      },
      {
        KPI: kpi_percentage("ApprovalRequest", "requested_at", "approved_at", 3, true, @params),
        task: 'Special Renewal Approval (unfit)',
        TAT: '2wd',
        target: '80%'
      },
      {
        KPI: kpi_percentage("ApprovalRequest", "requested_at", "approved_at", 3, true, @params),
        task: 'Update Employer Detail Approval (Employer)',
        TAT: '3wd',
        target: '80%'
      },
      {
        KPI: review_xray(@params),
        task: 'Review - Normal chest X-ray',
        TAT: '72 hours from the date of certification',
        target: '80%'
      },
      {
        KPI: pcr_xray(@params),
        task: 'Audit - Abnormal chest X-ray',
        TAT: '48 hours from the date of certification',
        target: '80%'
      },
      {
        KPI: xqcc_Amd(@params),
        task: 'XQCC Amendment',
        TAT: 'Four (4) weeks from the date of confirmation',
        target: '80%'
      },
      {
        KPI: 0, # as there is no table menthioned in the doc
        task: 'Laboratory',
        TAT: 'Calendar year',
        target: '100%'
      },
      {
        KPI: 0, # as there is no table menthioned in the doc
        task: 'Doctor Visit',
        TAT: 'Calendar year',
        target: '100%'
      },
      {
        KPI: 0, # as there is no table menthioned in the doc
        task: 'X-ray Visit',
        TAT: 'Calendar year',
        target: '100%'
      },
      {
        KPI: 10,
        task: 'Payment to service providers (Doctor, X-ray, Laboratory)',
        TAT: 'For every 7 working days, Finance team will generate data from Nios and transmit those data to Sage, our accounting system, to perform the payment processes.\n\nThe payments will be generated into 5 batches based on the certification dates:\n\na) 1st - 6th\nb) 7th - 12th\nc) 13th -18th\nd) 19th -24th\ne) 25th -30th',
        target: '100%'
      },
      {
        KPI: 10,
        task: 'Refund to Employers',
        TAT: '80%',
        target: ''
      },
      {
        KPI: 10,
        task: 'Insurance payment to Fomema Global Sdn Bhd',
        TAT: '100%',
        target: '80%'
      },
      {
        KPI: 10,
        task: 'Appeal cases',
        TAT: '28 Days',
        target: '90%'
      },
      {
        KPI: 10,
        task: 'Pending Review Cases',
        TAT: '3 Working days',
        target: '90%'
      },
      {
        KPI: 10,
        task: 'TCUPI Cases',
        TAT: '28 Days',
        target: '90%'
      },
      {
        KPI: 0, # data from CS new system
        task: 'Employer Enquiry JIVO',
        TAT: '24 hours',
        target: '100%'
      },
      {
        KPI: kpi_percentage("FwChangeEmployer", "requested_at", "approval_at", 3, true, @params),
        task: 'Change of employer (transfer)',
        TAT: '3 WD',
        target: '80%'
      },
      {
        KPI: kpi_percentage("ApprovalRequest", "requested_at", "approved_at", 3, true, @params),
        task: 'Amendment of Foreign worker info',
        TAT: '3 WD',
        target: '80%'
      },
      {
        KPI: kpi_percentage("ApprovalRequest", "requested_at", "approved_at", 3, true, @params),
        task: 'Special Renewal Approval (unfit)',
        TAT: '3 WD',
        target: '80%'
      },
      {
        KPI: 0, # kpi_percentage("ApprovalRequest","requested_at","approved_at",3,true,@params),
        task: 'Update employer details',
        TAT: '3 WD',
        target: '80%'
      },
      {
        KPI: kpi_percentage("ApprovalRequest", "requested_at", "approved_at", 3, true, @params),
        task: 'Employer Registration Approval',
        TAT: '2 WD',
        target: '80%'
      },
      {
        KPI: 0, # Avows System (Claims Management)
        task: 'Staff Claims Submission',
        TAT: 'One Week from date HODs approved to HCM verification',
        target: '90%'
      },
      {
        KPI: 10,
        task: 'Approval for registration of service provider',
        TAT: '14 working days',
        target: '80%'
      },
      {
        KPI: 10,
        task: 'Activating new service provider',
        TAT: '10 working days',
        target: '80%'
      }
    ]
  end

  def percentage(total, current_count)
    return nil unless total.is_a?(Numeric) && current_count.is_a?(Numeric)
    if total.zero?
      0.0
    else
      percent = (current_count / total.to_f) * 100
      percent.round(1)
    end
  end

  def kpi_percentage(model_name, attr_1, attr_2, tat = 1.day, flag = true, query = {})
    begin
      klass = model_name.constantize
      records = klass.all

      records = filter_params(query, records)

      if flag == true
        count = records.where("EXTRACT(EPOCH FROM (#{attr_1} - #{attr_2})) / 86400 < ?", tat).count
      else
        count = records.where("(#{attr_1} - #{attr_2})/86400 < ? ", tat).count
      end
      percentage(records.count, count)
    rescue
      0.0
    end
  end

  def review_xray(query = {})
    records = filter_params(query, XrayReview.joins(:fw_transactions))
    count = records.joins(:fw_transactions).where("xray_reviews.created_at >= transactions.certification_date").where("xray_reviews.created_at <= transactions.certification_date + INTERVAL '3 days'").uniq.count rescue 0
    percentage(XrayReview.count, count)
  end

  def pcr_xray(query = {})
    records = PcrReview.joins(:fw_transactions)
    count = records.where("pcr_reviews.created_at >= transactions.certification_date").where("pcr_reviews.created_at <= transactions.certification_date + INTERVAL '2 days'").uniq.count
    percentage(PcrReview.count, count)
  end

  def xqcc_Amd(query = {})
    records = Transaction.joins(:xray_pending_decision)
    count = records.where("EXTRACT(EPOCH FROM (transactions.created_at - xray_pending_decisions.reviewed_at))/86400  < 28").count
    percentage(Transaction.count, count)
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
      when "week"
        unless value == "Select Week"
          selected_week = value.split(" ").last.to_i
          records = records.where("EXTRACT(WEEK FROM created_at) = ?", selected_week)
        end
      end
    end
    records
  end

end