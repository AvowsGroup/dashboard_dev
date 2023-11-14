class FirstDashboardController < ApplicationController
  def index
    # data for filter drop down 
    @countries = Country.pluck(:name).compact
    @states = State.pluck(:name).compact.uniq
    @job_type = JobType.pluck(:name).compact.uniq
    @organizations = Organization.pluck(:name).uniq
    @foregin_worker_type = Transaction.pluck(:registration_type).uniq

    # unfiltered data for data_pints
    @current_year = Date.today.year
    @transactions = Transaction.where("extract(year from created_at) = ?", @current_year)
    @passed_examination_count = @transactions.where("EXTRACT(YEAR FROM medical_examination_date) = ? AND medical_examination_date < ?", @current_year, Date.current).count
    @certification_count = @transactions.where("EXTRACT(YEAR FROM certification_date) = ? AND certification_date < ?", @current_year, Date.current).count
    @final_result = @transactions.where(final_result: nil).count

    if request.format.js? && params[:value].nil?
      @filters = JSON.parse(params.keys.first)
      @filters = convert_values_to_arrays(@filters)

      # calling filter from here
      @transactions = apply_filter(@filters)

      if @transactions.present?
        # chart 2 and chart 4
        @pi_chart_data = [['Task', 'Hours per Day']]
        @transactions = Transaction.where(id: @transactions.ids)
        @transaction_line_cahrt = @transactions.transaction_data_last_5_years rescue {}

        # filtered data for data_pints
        @passed_examination_count = @transactions.where("EXTRACT(YEAR FROM medical_examination_date) = ? AND medical_examination_date < ?", @current_year, Date.current).count
        @certification_count = @transactions.where("EXTRACT(YEAR FROM certification_date) = ? AND certification_date < ?", @current_year, Date.current).count
        @final_result = @transactions.where(final_result: nil).count
        @side_bar_medical_appeals = @transactions.joins(:medical_appeals).count
        @block_fw = @transactions.joins(:myimms_transactions).pluck('myimms_transactions.status').map { |i| displayed_status(i) }.group_by { |status| status }.transform_values(&:count)
        @fw_insured = fw_insured(@transactions)

        @transactions.joins(:job_type).group('job_types.name').count.to_a.map { |i| @pi_chart_data << i }
        state_ids = @transactions.joins(doctor: :state).pluck('states.id')
        hash = {}
        state_ids.sort.uniq.each { |h| hash[h] = state_ids.count(h) }
        state_names = State.where(id: state_ids.sort.uniq).pluck(:name)
        converted_hash = {}
        state_names.each_with_index { |value, index| converted_hash[value] = hash.values[index] }
        @fw_reg_by_states = converted_hash.to_a
        @fw_Reg_by_countries = @transactions.joins(:country).group('countries.name').count.to_a
      end
    else
      @block_fw = Transaction.joins(:myimms_transactions).pluck('myimms_transactions.status').map { |i| displayed_status(i) }.group_by { |status| status }.transform_values(&:count)
      @fw_insured = fw_insured(@transactions)
      @transaction_line_cahrt = Transaction.transaction_data_last_5_years
      @side_bar_medical_appeals = Transaction.includes(:medical_appeals).find(@transactions.ids).count
      @pi_chart_data = [['Task', 'Hours per Day']]
      Transaction.joins(:job_type).group('job_types.name').count.to_a.map { |i| @pi_chart_data << i }
      @fw_reg_by_states = State.joins(doctors: :transactions).group('states.name').count.to_a
      @fw_Reg_by_countries = Transaction.joins(:country).group('countries.name').count.to_a
    end

    if @transaction_line_cahrt == {} || @transaction_line_cahrt.nil?
      @transaction_line_cahrt = {
        2019 => [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        2020 => [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        2021 => [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        2022 => [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        2023 => [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
      }
    end
    @fw_pending_view = {
      xqcc_pool: Transaction.joins(:xray_review, :xqcc_pool)
                            .where.not("transactions.certification_date": nil)
                            .pluck(:created_at, 'transactions.certification_date', 'xray_reviews.transmitted_at')
                            .count,
      pcr_pool: Transaction.joins(:pcr_review, :pcr_pool)
                           .where.not("transactions.certification_date": nil)
                           .pluck(:created_at, 'transactions.certification_date', 'pcr_reviews.transmitted_at')
                           .count,
      x_ray_pending_review: Transaction.joins(:xray_pending_review)
                                       .where.not("transactions.certification_date": nil)
                                       .pluck(:created_at, 'transactions.certification_date', 'xray_pending_reviews.transmitted_at')
                                       .count,
      x_ray_pending_decision: Transaction.joins(:xray_pending_decision)
                                         .where.not("transactions.certification_date": nil)
                                         .pluck(:created_at, 'transactions.certification_date', 'xray_pending_decisions.transmitted_at')
                                         .count,
      medical_review: MedicalReview.joins(:transaction)
                                   .where.not("transactions.certification_date IS NULL")
                                   .where.not("medical_reviews.created_at IS NULL")
                                   .where.not("medical_reviews.medical_mle1_decision_at IS NULL")
                                   .where(is_qa: true)
                                   .where.not("medical_reviews.qa_decision_at IS NULL")
                                   .count

    } rescue nil
    respond_to do |format|
      format.html
      format.js { render layout: false } # Add this line to you respond_to block
    end
  end

  def excel_generate
   @total_fw_registration = {}
    @examination_count = {}
    @certification_count = {}
    @xqcc_pool_received = {}
    @xqcc_pool_reviewed = {}
    @pcr_pool_received = {}
    @pcr_pool_reviewed = {}
    @xray_pending_review_received = {}
    @xray_pending_review_reviewed = {}
    @xray_pending_decision_received = {}
    @xray_pending_decision_reviewed = {}

    @countries = Country.pluck(:name).compact.uniq
    countries_with_ids = Country.where(name: @countries).pluck(:name, :id).to_h
    @countries.each do |country|
      country_id = countries_with_ids[country]

      total_fw_registration_count = Transaction.where(fw_country_id: country_id)
                                               .order(created_at: :desc)
                                               .limit(50)
                                               .count
      @total_fw_registration[country] = total_fw_registration_count

      examination_count = Transaction.where(fw_country_id: country_id)
                                     .where("EXTRACT(YEAR FROM medical_examination_date) = ? AND medical_examination_date < ?", Date.current.year, Date.current)
                                     .order(created_at: :desc)
                                     .limit(50)
                                     .count
      @examination_count[country] = examination_count

      certification_count = Transaction.where(fw_country_id: country_id)
                                       .where("EXTRACT(YEAR FROM medical_examination_date) = ? AND medical_examination_date < ?", Date.current.year, Date.current)
                                       .order(created_at: :desc)
                                       .limit(50)
                                       .count
      @certification_count[country] = certification_count

      xqcc_pool_received = Transaction.joins("JOIN xqcc_pools ON xqcc_pools.transaction_id = transactions.id").order('transactions.created_at DESC')
                                      .limit(50)
                                      .group('xqcc_pools.created_at, transactions.certification_date, transactions.created_at')
                                      .count
      @xqcc_pool_received[country] = xqcc_pool_received

      xqcc_pool_reviewed = Transaction.joins("JOIN xray_reviews ON xray_reviews.transaction_id = transactions.id").order('transactions.created_at DESC')
                                      .limit(50)
                                      .group('xray_reviews.transmitted_at, transactions.certification_date, transactions.created_at')
                                      .count
      @xqcc_pool_reviewed[country] = xqcc_pool_reviewed

      pcr_pool_received = Transaction.joins("JOIN pcr_pools ON pcr_pools.transaction_id = transactions.id").order('transactions.created_at DESC')
                                     .limit(50)
                                     .group('pcr_pools.created_at, transactions.certification_date, transactions.created_at')
                                     .count
      @pcr_pool_received[country] = pcr_pool_received

      pcr_pool_reviewed = Transaction.joins("JOIN pcr_reviews ON pcr_reviews.transaction_id = transactions.id").order('transactions.created_at DESC')
                                     .limit(50)
                                     .group('pcr_reviews.created_at,transactions.certification_date, transactions.created_at')
                                     .count.values
      @pcr_pool_reviewed[country] = pcr_pool_reviewed

      xray_pending_review_received = Transaction.joins("JOIN xray_pending_reviews ON xray_pending_reviews.transaction_id = transactions.id").order('transactions.created_at DESC')
                                                .limit(50)
                                                .group('xray_pending_reviews.created_at, transactions.certification_date, transactions.created_at')
                                                .count
      @xray_pending_review_received[country] = xray_pending_review_received

      xray_pending_review_reviewed = Transaction.joins("JOIN xray_pending_reviews ON xray_pending_reviews.transaction_id = transactions.id").order('transactions.created_at DESC')
                                                .limit(50)
                                                .group('xray_pending_reviews.transmitted_at, transactions.certification_date, transactions.created_at')
                                                .count
      @xray_pending_review_reviewed[country] = xray_pending_review_reviewed

      xray_pending_decision_received = Transaction.joins("JOIN xray_pending_decisions ON xray_pending_decisions.transaction_id = transactions.id").order('transactions.created_at DESC')
                                                  .limit(50)
                                                  .group('xray_pending_decisions.created_at, transactions.certification_date, transactions.created_at')
                                                  .count
      @xray_pending_decision_received[country] = xray_pending_decision_received

      xray_pending_decision_reviewed = Transaction.joins("JOIN xray_pending_decisions ON xray_pending_decisions.transaction_id = transactions.id").order('transactions.created_at DESC')
                                                  .limit(50)
                                                  .group('xray_pending_decisions.transmitted_at, transactions.certification_date, transactions.created_at')
                                                  .count
      @xray_pending_decision_reviewed[country] = xray_pending_decision_reviewed

    end

    @states = State.pluck(:name).compact.uniq
    states_with_ids = State.where(name: @states).pluck(:name, :id).to_h

    @states.each do |state|
      doctor_ids = Doctor.where(state_id: states_with_ids[state]).pluck(:id)

      total_fw_registration_count = Transaction.where(doctor_id: doctor_ids)
                                               .order(created_at: :desc)
                                               .limit(50)
                                               .count
      @total_fw_registration[state] = total_fw_registration_count

      examination_count = Transaction.where(doctor_id: doctor_ids)
                                     .where("EXTRACT(YEAR FROM medical_examination_date) = ? AND medical_examination_date < ?", Date.current.year, Date.current)
                                     .order(created_at: :desc)
                                     .limit(50)
                                     .count
      @examination_count[state] = examination_count

      certification_count = Transaction.where(doctor_id: doctor_ids)
                                       .where("EXTRACT(YEAR FROM medical_examination_date) = ? AND medical_examination_date < ?", Date.current.year, Date.current)
                                       .order(created_at: :desc)
                                       .limit(50)
                                       .count
      @certification_count[state] = certification_count

      xqcc_pool_received = Transaction.joins("JOIN xqcc_pools ON xqcc_pools.transaction_id = transactions.id").order('transactions.created_at DESC')
                                      .limit(50)
                                      .group('xqcc_pools.created_at, transactions.certification_date, transactions.created_at')
                                      .count
      @xqcc_pool_received[state] = xqcc_pool_received

      xqcc_pool_reviewed = Transaction.joins("JOIN xray_reviews ON xray_reviews.transaction_id = transactions.id").order('transactions.created_at DESC')
                                      .limit(50)
                                      .group('xray_reviews.transmitted_at, transactions.certification_date, transactions.created_at')
                                      .count
      @xqcc_pool_reviewed[state] = xqcc_pool_reviewed

      pcr_pool_received = Transaction.joins("JOIN pcr_pools ON pcr_pools.transaction_id = transactions.id").order('transactions.created_at DESC')
                                     .limit(50)
                                     .group('pcr_pools.created_at, transactions.certification_date, transactions.created_at')
                                     .count
      @pcr_pool_received[state] = pcr_pool_received

      pcr_pool_reviewed = Transaction.joins("JOIN pcr_reviews ON pcr_reviews.transaction_id = transactions.id").order('transactions.created_at DESC')
                                     .limit(50)
                                     .group('pcr_reviews.created_at,transactions.certification_date, transactions.created_at')
                                     .count.values
      @pcr_pool_reviewed[state] = pcr_pool_reviewed

      xray_pending_review_received = Transaction.joins("JOIN xray_pending_reviews ON xray_pending_reviews.transaction_id = transactions.id").order('transactions.created_at DESC')
                                                .limit(50)
                                                .group('xray_pending_reviews.created_at, transactions.certification_date, transactions.created_at')
                                                .count
      @xray_pending_review_received[state] = xray_pending_review_received

      xray_pending_review_reviewed = Transaction.joins("JOIN xray_pending_reviews ON xray_pending_reviews.transaction_id = transactions.id").order('transactions.created_at DESC')
                                                .limit(50)
                                                .group('xray_pending_reviews.transmitted_at, transactions.certification_date, transactions.created_at')
                                                .count
      @xray_pending_review_reviewed[state] = xray_pending_review_reviewed

      xray_pending_decision_received = Transaction.joins("JOIN xray_pending_decisions ON xray_pending_decisions.transaction_id = transactions.id").order('transactions.created_at DESC')
                                                  .limit(50)
                                                  .group('xray_pending_decisions.created_at, transactions.certification_date, transactions.created_at')
                                                  .count
      @xray_pending_decision_received[state] = xray_pending_decision_received

      xray_pending_decision_reviewed = Transaction.joins("JOIN xray_pending_decisions ON xray_pending_decisions.transaction_id = transactions.id").order('transactions.created_at DESC')
                                                  .limit(50)
                                                  .group('xray_pending_decisions.transmitted_at, transactions.certification_date, transactions.created_at')
                                                  .count
      @xray_pending_decision_reviewed[state] = xray_pending_decision_reviewed

    end

    @job_type = JobType.pluck(:name).compact.uniq
    job_type_with_ids = JobType.where(name: @job_type).pluck(:name, :id).to_h
    @job_type.each do |job|
      job_id = job_type_with_ids[job]

      total_fw_registration_count = Transaction.where(fw_job_type_id: job_id)
                                               .order(created_at: :desc)
                                               .limit(50)
                                               .count
      @total_fw_registration[job] = total_fw_registration_count

      examination_count = Transaction.where(fw_job_type_id: job_id)
                                     .where("EXTRACT(YEAR FROM medical_examination_date) = ? AND medical_examination_date < ?", Date.current.year, Date.current)
                                     .order(created_at: :desc)
                                     .limit(50)
                                     .count
      @examination_count[job] = examination_count

      certification_count = Transaction.where(fw_job_type_id: job_id)
                                       .where("EXTRACT(YEAR FROM medical_examination_date) = ? AND medical_examination_date < ?", Date.current.year, Date.current)
                                       .order(created_at: :desc)
                                       .limit(50)
                                       .count
      @certification_count[job] = certification_count

      xqcc_pool_received = Transaction.joins("JOIN xqcc_pools ON xqcc_pools.transaction_id = transactions.id").order('transactions.created_at DESC')
                                      .limit(50)
                                      .group('xqcc_pools.created_at, transactions.certification_date, transactions.created_at')
                                      .count
      @xqcc_pool_received[job] = xqcc_pool_received

      xqcc_pool_reviewed = Transaction.joins("JOIN xray_reviews ON xray_reviews.transaction_id = transactions.id").order('transactions.created_at DESC')
                                      .limit(50)
                                      .group('xray_reviews.transmitted_at, transactions.certification_date, transactions.created_at')
                                      .count
      @xqcc_pool_reviewed[job] = xqcc_pool_reviewed

      pcr_pool_received = Transaction.joins("JOIN pcr_pools ON pcr_pools.transaction_id = transactions.id").order('transactions.created_at DESC')
                                     .limit(50)
                                     .group('pcr_pools.created_at, transactions.certification_date, transactions.created_at')
                                     .count
      @pcr_pool_received[job] = pcr_pool_received

      pcr_pool_reviewed = Transaction.joins("JOIN pcr_reviews ON pcr_reviews.transaction_id = transactions.id").order('transactions.created_at DESC')
                                     .limit(50)
                                     .group('pcr_reviews.created_at,transactions.certification_date, transactions.created_at')
                                     .count.values
      @pcr_pool_reviewed[job] = pcr_pool_reviewed

      xray_pending_review_received = Transaction.joins("JOIN xray_pending_reviews ON xray_pending_reviews.transaction_id = transactions.id").order('transactions.created_at DESC')
                                                .limit(50)
                                                .group('xray_pending_reviews.created_at, transactions.certification_date, transactions.created_at')
                                                .count
      @xray_pending_review_received[job] = xray_pending_review_received

      xray_pending_review_reviewed = Transaction.joins("JOIN xray_pending_reviews ON xray_pending_reviews.transaction_id = transactions.id").order('transactions.created_at DESC')
                                                .limit(50)
                                                .group('xray_pending_reviews.transmitted_at, transactions.certification_date, transactions.created_at')
                                                .count
      @xray_pending_review_reviewed[job] = xray_pending_review_reviewed

      xray_pending_decision_received = Transaction.joins("JOIN xray_pending_decisions ON xray_pending_decisions.transaction_id = transactions.id").order('transactions.created_at DESC')
                                                  .limit(50)
                                                  .group('xray_pending_decisions.created_at, transactions.certification_date, transactions.created_at')
                                                  .count
      @xray_pending_decision_received[job] = xray_pending_decision_received

      xray_pending_decision_reviewed = Transaction.joins("JOIN xray_pending_decisions ON xray_pending_decisions.transaction_id = transactions.id").order('transactions.created_at DESC')
                                                  .limit(50)
                                                  .group('xray_pending_decisions.transmitted_at, transactions.certification_date, transactions.created_at')
                                                  .count
      @xray_pending_decision_reviewed[job] = xray_pending_decision_reviewed

    end

    @male_count = Transaction.where(fw_gender: 'M')
                             .order(created_at: :desc)
                             .limit(50)
                             .count

    @female_count = Transaction.where(fw_gender: 'F')
                               .order(created_at: :desc)
                               .limit(50)
                               .count

    @male_examination_count = Transaction.where(fw_gender: 'M')
                                         .where("EXTRACT(YEAR FROM medical_examination_date) = ? AND medical_examination_date < ?", Date.current.year, Date.current)
                                         .order(created_at: :desc)
                                         .limit(50)
                                         .count

    @female_examination_count = Transaction.where(fw_gender: 'F')
                                           .where("EXTRACT(YEAR FROM medical_examination_date) = ? AND medical_examination_date < ?", Date.current.year, Date.current)
                                           .order(created_at: :desc)
                                           .limit(50)
                                           .count

    @male_certification_count = Transaction.where(fw_gender: 'M')
                                           .where("EXTRACT(YEAR FROM medical_examination_date) = ? AND medical_examination_date < ?", Date.current.year, Date.current)
                                           .order(created_at: :desc)
                                           .limit(50)
                                           .count

    @female_certification_count = Transaction.where(fw_gender: 'F')
                                             .where("EXTRACT(YEAR FROM medical_examination_date) = ? AND medical_examination_date < ?", Date.current.year, Date.current)
                                             .order(created_at: :desc)
                                             .limit(50)
                                             .count

    @organizations = Organization.pluck(:name).uniq
    organization_with_ids = Organization.where(name: @organizations).pluck(:name, :id).to_h
    @organizations.each do |organization|
      organization_id = organization_with_ids[organization]

      total_fw_registration_count = Transaction.where(organization_id: organization_id)
                                               .order(created_at: :desc)
                                               .limit(50)
                                               .count
      @total_fw_registration[organization] = total_fw_registration_count

      examination_count = Transaction.where(organization_id: organization_id)
                                     .where("EXTRACT(YEAR FROM medical_examination_date) = ? AND medical_examination_date < ?", Date.current.year, Date.current)
                                     .order(created_at: :desc)
                                     .limit(50)
                                     .count
      @examination_count[organization] = examination_count

      certification_count = Transaction.where(organization_id: organization_id)
                                       .where("EXTRACT(YEAR FROM medical_examination_date) = ? AND medical_examination_date < ?", Date.current.year, Date.current)
                                       .order(created_at: :desc)
                                       .limit(50)
                                       .count
      @certification_count[organization] = certification_count

      xqcc_pool_received = Transaction.joins("JOIN xqcc_pools ON xqcc_pools.transaction_id = transactions.id").order('transactions.created_at DESC')
                                      .limit(50)
                                      .group('xqcc_pools.created_at, transactions.certification_date, transactions.created_at')
                                      .count
      @xqcc_pool_received[organization] = xqcc_pool_received

      xqcc_pool_reviewed = Transaction.joins("JOIN xray_reviews ON xray_reviews.transaction_id = transactions.id").order('transactions.created_at DESC')
                                      .limit(50)
                                      .group('xray_reviews.transmitted_at, transactions.certification_date, transactions.created_at')
                                      .count
      @xqcc_pool_reviewed[organization] = xqcc_pool_reviewed

      pcr_pool_received = Transaction.joins("JOIN pcr_pools ON pcr_pools.transaction_id = transactions.id").order('transactions.created_at DESC')
                                     .limit(50)
                                     .group('pcr_pools.created_at, transactions.certification_date, transactions.created_at')
                                     .count
      @pcr_pool_received[organization] = pcr_pool_received

      pcr_pool_reviewed = Transaction.joins("JOIN pcr_reviews ON pcr_reviews.transaction_id = transactions.id").order('transactions.created_at DESC')
                                     .limit(50)
                                     .group('pcr_reviews.created_at,transactions.certification_date, transactions.created_at')
                                     .count.values
      @pcr_pool_reviewed[organization] = pcr_pool_reviewed

      xray_pending_review_received = Transaction.joins("JOIN xray_pending_reviews ON xray_pending_reviews.transaction_id = transactions.id").order('transactions.created_at DESC')
                                                .limit(50)
                                                .group('xray_pending_reviews.created_at, transactions.certification_date, transactions.created_at')
                                                .count
      @xray_pending_review_received[organization] = xray_pending_review_received

      xray_pending_review_reviewed = Transaction.joins("JOIN xray_pending_reviews ON xray_pending_reviews.transaction_id = transactions.id").order('transactions.created_at DESC')
                                                .limit(50)
                                                .group('xray_pending_reviews.transmitted_at, transactions.certification_date, transactions.created_at')
                                                .count
      @xray_pending_review_reviewed[organization] = xray_pending_review_reviewed

      xray_pending_decision_received = Transaction.joins("JOIN xray_pending_decisions ON xray_pending_decisions.transaction_id = transactions.id").order('transactions.created_at DESC')
                                                  .limit(50)
                                                  .group('xray_pending_decisions.created_at, transactions.certification_date, transactions.created_at')
                                                  .count
      @xray_pending_decision_received[organization] = xray_pending_decision_received

      xray_pending_decision_reviewed = Transaction.joins("JOIN xray_pending_decisions ON xray_pending_decisions.transaction_id = transactions.id").order('transactions.created_at DESC')
                                                  .limit(50)
                                                  .group('xray_pending_decisions.transmitted_at, transactions.certification_date, transactions.created_at')
                                                  .count
      @xray_pending_decision_reviewed[organization] = xray_pending_decision_reviewed

    end

    @new_count = Transaction.where(registration_type: 0)
                            .order(created_at: :desc)
                            .limit(50)
                            .count

    @renewal_count = Transaction.where(registration_type: 1)
                                .order(created_at: :desc)
                                .limit(50)
                                .count

    @new_examination_count = Transaction.where(registration_type: 0)
                                        .where("EXTRACT(YEAR FROM medical_examination_date) = ? AND medical_examination_date < ?", Date.current.year, Date.current)
                                        .order(created_at: :desc)
                                        .limit(50)
                                        .count

    @renewal_examination_count = Transaction.where(registration_type: 1)
                                            .where("EXTRACT(YEAR FROM medical_examination_date) = ? AND medical_examination_date < ?", Date.current.year, Date.current)
                                            .order(created_at: :desc)
                                            .limit(50)
                                            .count

    @new_certification_count = Transaction.where(registration_type: 0)
                                          .where("EXTRACT(YEAR FROM medical_examination_date) = ? AND medical_examination_date < ?", Date.current.year, Date.current)
                                          .order(created_at: :desc)
                                          .limit(50)
                                          .count

    @renewal_certification_count = Transaction.where(registration_type: 1)
                                              .where("EXTRACT(YEAR FROM medical_examination_date) = ? AND medical_examination_date < ?", Date.current.year, Date.current)
                                              .order(created_at: :desc)
                                              .limit(50)
                                              .count

    @latest_transactions = Transaction.order(created_at: :desc).limit(50).pluck(:created_at).map { |date| date.strftime("%Y-%m-%d %H:%M:%S") }

    @raw_data_2023 = Transaction.where(created_at: (Time.new(2023, 1, 1)..Time.new(2023, 12, 31, 23, 59, 59)))
                                .order(created_at: :desc)
                                .limit(50)
                                .pluck(:created_at, :medical_examination_date, :certification_date)
                                .map { |record| record.map { |date| date&.strftime("%Y-%m-%d %H:%M:%S") } }

    @raw_data_2022 = Transaction.where(created_at: (Time.new(2022, 1, 1)..Time.new(2022, 12, 31, 23, 59, 59)))
                                .order(created_at: :desc)
                                .limit(50)
                                .pluck(:created_at, :medical_examination_date, :certification_date)
                                .map { |record| record.map { |date| date&.strftime("%Y-%m-%d %H:%M:%S") } }

    @raw_data_2021 = Transaction.where(created_at: (Time.new(2021, 1, 1)..Time.new(2021, 12, 31, 23, 59, 59)))
                                .order(created_at: :desc)
                                .limit(50)
                                .pluck(:created_at, :medical_examination_date, :certification_date)
                                .map { |record| record.map { |date| date&.strftime("%Y-%m-%d %H:%M:%S") } }

    @raw_data_2020 = Transaction.where(created_at: (Time.new(2020, 1, 1)..Time.new(2020, 12, 31, 23, 59, 59)))
                                .order(created_at: :desc)
                                .limit(50)
                                .pluck(:created_at, :medical_examination_date, :certification_date)
                                .map { |record| record.map { |date| date&.strftime("%Y-%m-%d %H:%M:%S") } }

    @raw_data_2019 = Transaction.where(created_at: (Time.new(2019, 1, 1)..Time.new(2019, 12, 31, 23, 59, 59)))
                                .order(created_at: :desc)
                                .limit(50)
                                .pluck(:created_at, :medical_examination_date, :certification_date)
                                .map { |record| record.map { |date| date&.strftime("%Y-%m-%d %H:%M:%S") } }

    @sheet_data = {
      'FW Reg. by Country' => [
        'FW Registration by Country',
        ['FW Registration by Country', 'Total FW Registration', 'FW went for medical examination', 'Certification', 'XQCC Pool (Film Received)', 'XQCC Pool (Film Reviewed)', 'PCR Pool (Film Received)', 'PCR Pool (Film Reviewed)', 'X-Ray Pending Review (Film Received)', 'X-Ray Pending Review (Film Reviewed)', 'X-Ray Pending Decision (Film Received)', 'X-Ray Pending Decision (Film Reviewed)', 'Medical Review (Received)', 'Medical Review (Reviewed)', 'Final Result Released', 'Result Transmitted to Immigration', 'Blocked FW', 'Appeal', 'FW Insured'],
      ],
      'FW Reg. by State' => [
        'FW Registration by State',
        ['FW Registration by State', 'Total FW Registration', 'FW went for medical examination', 'Certification', 'XQCC Pool (Film Received)', 'XQCC Pool (Film Reviewed)', 'PCR Pool (Film Received)', 'PCR Pool (Film Reviewed)', 'X-Ray Pending Review (Film Received)', 'X-Ray Pending Review (Film Reviewed)', 'X-Ray Pending Decision (Film Received)', 'X-Ray Pending Decision (Film Reviewed)', 'Medical Review (Received)', 'Medical Review (Reviewed)', 'Final Result Released', 'Result Transmitted to Immigration', 'Blocked FW', 'Appeal', 'FW Insured'],
      ],
      'FW Reg. by Sector' => [
        'FW Registration by Sector',
        ['FW Registration by Sector', 'Total FW Registration', 'FW went for medical examination', 'Certification', 'XQCC Pool (Film Received)', 'XQCC Pool (Film Reviewed)', 'PCR Pool (Film Received)', 'PCR Pool (Film Reviewed)', 'X-Ray Pending Review (Film Received)', 'X-Ray Pending Review (Film Reviewed)', 'X-Ray Pending Decision (Film Received)', 'X-Ray Pending Decision (Film Reviewed)', 'Medical Review (Received)', 'Medical Review (Reviewed)', 'Final Result Released', 'Result Transmitted to Immigration', 'Blocked FW', 'Appeal', 'FW Insured'],
      ],
      'FW Reg. by Gender' => [
        'FW Registration by Gender',
        ['FW Registration by Gender', 'Total FW Registration', 'FW went for medical examination', 'Certification', 'XQCC Pool (Film Received)', 'XQCC Pool (Film Reviewed)', 'PCR Pool (Film Received)', 'PCR Pool (Film Reviewed)', 'X-Ray Pending Review (Film Received)', 'X-Ray Pending Review (Film Reviewed)', 'X-Ray Pending Decision (Film Received)', 'X-Ray Pending Decision (Film Reviewed)', 'Medical Review (Received)', 'Medical Review (Reviewed)', 'Final Result Released', 'Result Transmitted to Immigration', 'Blocked FW', 'Appeal', 'FW Insured'],
      ],
      'FW Reg. by Registration at' => [
        'FW Registration by Registration at',
        ['FW Registration by Sector', 'Total FW Registration', 'FW went for medical examination', 'Certification', 'XQCC Pool (Film Received)', 'XQCC Pool (Film Reviewed)', 'PCR Pool (Film Received)', 'PCR Pool (Film Reviewed)', 'X-Ray Pending Review (Film Received)', 'X-Ray Pending Review (Film Reviewed)', 'X-Ray Pending Decision (Film Received)', 'X-Ray Pending Decision (Film Reviewed)', 'Medical Review (Received)', 'Medical Review (Reviewed)', 'Final Result Released', 'Result Transmitted to Immigration', 'Blocked FW', 'Appeal', 'FW Insured'],
      ],
      'FW Reg. by FW Type' => [
        'FW Registration by FW Type',
        ['FW Registration by FW Type', 'Total FW Registration', 'FW went for medical examination', 'Certification', 'XQCC Pool (Film Received)', 'XQCC Pool (Film Reviewed)', 'PCR Pool (Film Received)', 'PCR Pool (Film Reviewed)', 'X-Ray Pending Review (Film Received)', 'X-Ray Pending Review (Film Reviewed)', 'X-Ray Pending Decision (Film Received)', 'X-Ray Pending Decision (Film Reviewed)', 'Medical Review (Received)', 'Medical Review (Reviewed)', 'Final Result Released', 'Result Transmitted to Immigration', 'Blocked FW', 'Appeal', 'FW Insured'],
      ],
      'Trend of FW Reg. by year' => [
        'Trend of FW registration by Year',
        ['Transaction date by Month', 'Transaction date by Day', '2019', '2020', '2021', '2022', '2023', 'Count'],
      ],
      'Raw Data 2023' => [
        'Data 2023',
        ['Transaction Date (Month)', 'Medical Examination Date (Month)', 'Certification Date (Month)', 'State', 'Country', 'Age', 'Gender', 'Registration at', 'Foreign Worker Type', 'XQCC Pool (Film Received)', 'XQCC Pool (Film Reviewed)', 'PCR Pool (Film Received)', 'PCR Pool (Film Reviewed)', 'X-Ray Pending Review (Film Received)', 'X-Ray Pending Review (Film Reviewed)', 'X-Ray Pending Decision (Film Received)', 'X-Ray Pending Decision (Film Reviewed)', 'Medical Review (Received)', 'Medical Review (Reviewed)', 'Final Result Released', 'Result Transmitted to Immigration', 'Blocked FW', 'Appeal', 'FW Insured'],
      ],
      'Raw Data 2022' => [
        'Data 2022',
        ['Transaction Date (Month)', 'Medical Examination Date (Month)', 'Certification Date (Month)', 'State', 'Country', 'Age', 'Gender', 'Registration at', 'Foreign Worker Type', 'XQCC Pool (Film Received)', 'XQCC Pool (Film Reviewed)', 'PCR Pool (Film Received)', 'PCR Pool (Film Reviewed)', 'X-Ray Pending Review (Film Received)', 'X-Ray Pending Review (Film Reviewed)', 'X-Ray Pending Decision (Film Received)', 'X-Ray Pending Decision (Film Reviewed)', 'Medical Review (Received)', 'Medical Review (Reviewed)', 'Final Result Released', 'Result Transmitted to Immigration', 'Blocked FW', 'Appeal', 'FW Insured'],
      ],
      'Raw Data 2021' => [
        'Data 2021',
        ['Transaction Date (Month)', 'Medical Examination Date (Month)', 'Certification Date (Month)', 'State', 'Country', 'Age', 'Gender', 'Registration at', 'Foreign Worker Type', 'XQCC Pool (Film Received)', 'XQCC Pool (Film Reviewed)', 'PCR Pool (Film Received)', 'PCR Pool (Film Reviewed)', 'X-Ray Pending Review (Film Received)', 'X-Ray Pending Review (Film Reviewed)', 'X-Ray Pending Decision (Film Received)', 'X-Ray Pending Decision (Film Reviewed)', 'Medical Review (Received)', 'Medical Review (Reviewed)', 'Final Result Released', 'Result Transmitted to Immigration', 'Blocked FW', 'Appeal', 'FW Insured'],
      ],
      'Raw Data 2020' => [
        'Data 2020',
        ['Transaction Date (Month)', 'Medical Examination Date (Month)', 'Certification Date (Month)', 'State', 'Country', 'Age', 'Gender', 'Registration at', 'Foreign Worker Type', 'XQCC Pool (Film Received)', 'XQCC Pool (Film Reviewed)', 'PCR Pool (Film Received)', 'PCR Pool (Film Reviewed)', 'X-Ray Pending Review (Film Received)', 'X-Ray Pending Review (Film Reviewed)', 'X-Ray Pending Decision (Film Received)', 'X-Ray Pending Decision (Film Reviewed)', 'Medical Review (Received)', 'Medical Review (Reviewed)', 'Final Result Released', 'Result Transmitted to Immigration', 'Blocked FW', 'Appeal', 'FW Insured'],
      ],
      'Raw Data 2019' => [
        'Data 2019',
        ['Transaction Date (Month)', 'Medical Examination Date (Month)', 'Certification Date (Month)', 'State', 'Country', 'Age', 'Gender', 'Registration at', 'Foreign Worker Type', 'XQCC Pool (Film Received)', 'XQCC Pool (Film Reviewed)', 'PCR Pool (Film Received)', 'PCR Pool (Film Reviewed)', 'X-Ray Pending Review (Film Received)', 'X-Ray Pending Review (Film Reviewed)', 'X-Ray Pending Decision (Film Received)', 'X-Ray Pending Decision (Film Reviewed)', 'Medical Review (Received)', 'Medical Review (Reviewed)', 'Final Result Released', 'Result Transmitted to Immigration', 'Blocked FW', 'Appeal', 'FW Insured'],
      ]
    }

    respond_to do |format|
      format.xlsx { render xlsx: 'excel_generate', filename: 'Report.xlsx' }
    end
  end

  private

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
    transactions = Transaction.all
    filter_params.each do |param_key, param_value|
      case param_key
      when "DateRange"
        if param_value.present?
          start_date, end_date = param_value.split(" - ")
          transactions = transactions.where(created_at: start_date..end_date)
        end
      when "Sector"
        if param_value.present?
          sector_names = JobType.pluck(:name)
          selected_sector_names = sector_names & param_value
          transactions = transactions.joins(:job_type).where("job_types.name" => selected_sector_names)
        end
      when "Country"
        if param_value.present?
          transactions = transactions.joins(:country).where("countries.name" => param_value)
        end
      when "State"
        if param_value.present?
          state_ids = State.where(name: param_value).pluck(:id)
          doctor_ids = Doctor.where(state_id: state_ids).pluck(:id)
          transactions = transactions.where(doctor_id: doctor_ids)
        end
      when "Gender"
        if param_value.present?
          transactions = transactions.where(fw_gender: param_value)
        end
      when "age"
        if param_value.present?
          age_ranges = param_value.map { |age_range| age_range.split("-").map(&:to_i) }

          birth_years = age_ranges.map do |min_age, max_age|
            birth_year_min = Date.today.year - max_age - 1
            birth_year_max = Date.today.year - min_age
            [birth_year_min, birth_year_max]
          end

          # Find the overall minimum and maximum birth years
          overall_birth_year_min = birth_years.map(&:first).min
          overall_birth_year_max = birth_years.map(&:last).max

          transactions = transactions.where(fw_date_of_birth: Date.new(overall_birth_year_min)..Date.new(overall_birth_year_max))
        end
      when "ForeginWorker"
        if param_value.present?
          transactions = transactions.where(registration_type: param_value)
        end
      when "Registration"
        if param_value.present?
          organization_names = Organization.pluck(:name).uniq
          selected_organization_names = organization_names & param_value
          transactions = transactions.joins(:organization).where("organizations.name" => selected_organization_names)
        end
        # Add more cases for other filter keys here
      end
    end
    transactions
  end

  def displayed_status(status)
    resp_status = {
      '1' => "SUCCESS",
      '0' => "FAILED",
      '96' => 'IMM BLOCKED',
      '97' => 'YET TO PROCEED',
      '98' => "FOREIGN WORKER BLOCKED",
      "99" => "PHYSICAL NOT DONE"
    }
    resp_status[status]
  end

  def fw_insured(transactions)
    insurance_purchase_counts = {}
    transactions.ids.each do |transaction_id|
      transaction = Transaction.find_by(id: transaction_id)
      if transaction
        insurance_purchase_counts[transaction_id] = transaction.foreign_worker.insurance_purchases.count
      else
        insurance_purchase_counts[transaction_id] = 0
      end
    end
    insurance_purchase_counts.values.sum
  end

end
