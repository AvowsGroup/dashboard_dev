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
    @data = Transaction.find(params.keys[0].split(",")) rescue Transaction.all # Fetch data from your model
    respond_to do |format|
      format.xlsx do
        response.headers['Content-Disposition'] = 'attachment; filename="your_file.xlsx"'
        # Set other headers if necessary
        render xlsx: 'excel_generate', filename: 'your_file.xlsx'
      end
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
