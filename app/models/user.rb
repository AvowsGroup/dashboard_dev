class User < ApplicationRecord
    STATUSES = {
        "ACTIVE" => "Active",
        "INACTIVE" => "Inactive"
    }

    # full user types
    USERABLE_TYPES = {
        "Organization" => "FOMEMA",
        "Employer" => "EMPLOYER",
        "Doctor" => "DOCTOR",
        "Laboratory" => "LABORATORY",
        "Radiologist" => "RADIOLOGIST",
        "XrayFacility" => "X-RAY FACILITY",
        "Agency" => "AGENCY"
    }

    # for new - only organization
    USERABLE_TYPES_NEW = {
        "Organization" => "FOMEMA"
    }

    attr_writer :login
    attr_writer :login_type
    attr_writer :login_from
    attr_writer :login_user_type

    # audited
    # include CaptureAuthor
    # acts_as_paranoid
    # acts_as_approval_user

    # Include default devise modules. Others available are:
    # :lockable, :omniauthable
    # devise :database_authenticatable, :registerable, :recoverable, :confirmable, :rememberable, :trackable, :password_expirable, :password_archivable, :session_limitable, :timeoutable, request_keys: [:subdomain]

    # has_many :permissions, foreign_key: "user_id", class_name: "UserPermission"

    
end