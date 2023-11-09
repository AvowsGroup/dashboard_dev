class VisitReport < ApplicationRecord
    STATUSES = {
        "DRAFT" => "DRAFT",
        "LEVEL_1_APPROVAL" => "PENDING FOR LEVEL 1 APPROVAL",
        "LEVEL_1_APPROVED" => "PENDING FOR LEVEL 2 APPROVAL",
        "LEVEL_2_APPROVED" => "LEVEL 2 APPROVED",
        "REJECTED" => "REJECTED",
        "EXECUTED" => "EXECUTED",
        "SUSPENDED" => "SUSPENDED"
    }

    CODE_PREFIX = {
        "Doctor" => "C",
        "Laboratory" => "L",
        "XrayFacility" => "X"
    }

    # audited
    # include CaptureAuthor

    belongs_to :visit_plan
    belongs_to :visit_plan_item
    belongs_to :visitable, polymorphic: true, optional: true
    belongs_to :laboratory_type, optional: true

    has_one :visit_report_doctor
    has_one :visit_report_xray_facility

    has_many :visit_report_laboratories
    has_one :visit_report_laboratory, -> { where category: 'MAIN' }, class_name: "VisitReportLaboratory"
    has_one :visit_report_laboratory_summary, -> { where category: 'SUMMARY' }, class_name: "VisitReportLaboratory"
    has_many :lqcc_letters
    has_one :last_lqcc_letter, -> { order(created_at: :desc) }, class_name: "LqccLetter"

    has_many :visit_report_visitors

    has_one :operating_hour, as: :operating_hourable

    accepts_nested_attributes_for :visit_report_doctor, :visit_report_xray_facility, :visit_report_laboratory, :operating_hour, :visit_report_laboratory_summary

    belongs_to :level1_approval_user, :class_name => :User, :foreign_key => "level_1_approval_by", :optional => true
    belongs_to :level2_approval_user, :class_name => :User, :foreign_key => "level_2_approval_by", :optional => true
    belongs_to :draft_by, :class_name => :User, :foreign_key => "created_by", :optional => true
    belongs_to :prepare_user, :class_name => :User, :foreign_key => "prepare_by", :optional => true

    after_create :update_visit_report_code

    # scopes

    scope :visitable_type, -> visitable_type { where(visitable_type: visitable_type) }

    scope :visit_date_from, -> visit_date_from { where("visit_date >= ?", visit_date_from) }

    scope :visit_date_to, -> visit_date_to { where("visit_date <= ?", visit_date_to) }

    scope :status, -> status { where(status: status) }

    scope :approval, -> {
        pending_approval_statuses = %w(LEVEL_1_APPROVAL LEVEL_2_APPROVAL LEVEL_1_APPROVED LEVEL_2_APPROVED REJECTED)
        where(status: pending_approval_statuses)
    }

    scope :levelone_approval, -> { where(status: 'LEVEL_1_APPROVAL') }

    scope :leveltwo_approval, -> { where(status: 'LEVEL_2_APPROVAL') }

    scope :code, -> code {where(code: code)}

    # end scopes

    def update_visit_report_code
        self.update({
			code: generate_code
		})
    end

    def generate_code
        sprintf("#{CODE_PREFIX[self.visitable_type]}%05d", get_sequence)
    end

    def seq_nextval(seq_name)
        ActiveRecord::Base.connection.execute("SELECT nextval('#{seq_name}')")[0]["nextval"]
    end

	def get_sequence
		sequence_name = "visit_report_code_#{self.visitable_type.downcase}_sequence"
        rs = ActiveRecord::Base.connection.execute("SELECT count(*) FROM information_schema.sequences where sequence_name = '#{sequence_name}'")
		if rs.first["count"] == 0
			sql = "create sequence #{sequence_name} 
			increment 1 
			cycle 
			start with 1"
			ActiveRecord::Base.connection.execute sql
		end
		seq_nextval(sequence_name)
    end

    def self.search_code(code)
        return all if code.blank?
        code = code.strip
        where('code = ?', code)
    end

    def self.search_service_provider_name(service_provider, name)
        return all if name.blank?
        name = name.strip
        collection_name = service_provider.constantize.model_name.collection
        if service_provider == 'XrayFacility'
            visitable_type(service_provider).joins("INNER JOIN "+collection_name+" on visitable_id = "+collection_name+".id").where(collection_name+".license_holder_name ILIKE ?", "%#{name}%")
        else
             visitable_type(service_provider).joins("INNER JOIN "+collection_name+" on visitable_id = "+collection_name+".id").where(collection_name+".name ILIKE ?", "%#{name}%")
        end
    end

    def self.search_service_provider_code(service_provider, code)
        return all if code.blank?
        code = code.strip
        collection_name = service_provider.constantize.model_name.collection
        visitable_type(service_provider).joins("INNER JOIN "+collection_name+" on visitable_id = "+collection_name+".id").where(collection_name+".code = ?", code)
    end

    def self.search_clinic_name(service_provider, name)
        return all if name.blank?
        name = name.strip
        collection_name = service_provider.constantize.model_name.collection
        visitable_type(service_provider).joins("INNER JOIN "+collection_name+" on visitable_id = "+collection_name+".id").where(collection_name+".clinic_name ILIKE ?", "%#{name}%")
    end

    def self.search_service_provider_status(service_provider, status)
        return all if status.blank?
        collection_name = service_provider.constantize.model_name.collection
        visitable_type(service_provider).joins("INNER JOIN "+collection_name+" on visitable_id = "+collection_name+".id").where(collection_name+".status = ?", status)
    end

    def self.search_license_holder_name(service_provider, license_holder_name)
        return all if license_holder_name.blank?
        license_holder_name = license_holder_name.strip
        collection_name = service_provider.constantize.model_name.collection
        visitable_type(service_provider).joins("INNER JOIN "+collection_name+" on visitable_id = "+collection_name+".id").where(collection_name+".license_holder_name ILIKE ?", "%#{license_holder_name}%")
    end

    def explanation_letter_reference
        "#{code}/#{visit_date.try(:strftime,'%Y-%m')}/INSP/#{TemplateVariable.find_by_code('INSPECTORATE_LETTER_SIGNEE_ABBR')&.value}"
    end

    def self.search_approved_by_visit_year(service_provider, start_date, end_date)
        return all if start_date.blank? || end_date.blank?
        where(:visitable_type => service_provider, :status => 'LEVEL_2_APPROVED')
        .where('visit_date BETWEEN ? AND ?', start_date.to_date.beginning_of_day, end_date.to_date.end_of_day)
    end
end