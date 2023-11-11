class Dashboards::RefreshDashboardsController < ApplicationController
  protect_from_forgery
  def create
    dashboard_name = params[:dashboard_name]
    dashboard_interval = params[:dashboard_interval]
    unless dashboard_name.present? && dashboard_interval.present?
      render json: { error: 'Dashboard name and value are required' }, status: :unprocessable_entity
      return
    end
    refresh_dashboard = RefreshDashboard.first
    if refresh_dashboard.blank?
      refresh_dashboard = RefreshDashboard.create(
        geographical: 5 * 60 * 1000,
        fw_information: 5 * 60 * 1000,
        customer_satisfaction: 5 * 60 * 1000,
        dep_information: 5 * 60 * 1000,
        service_provider: 5 * 60 * 1000
      )
      render json: { status: 'Ok' }
    else
      if refresh_dashboard.respond_to?(dashboard_name)
        refresh_dashboard.update(dashboard_name => dashboard_interval)
        render json: { status: 'Ok' }
      else
        render json: { error: 'Invalid dashboard name' }, status: :unprocessable_entity
        return
      end
    end
  end

  def get_interval
    dashboard_name = params[:dashboard_name]
    refresh_dashboard = RefreshDashboard.first
  
    if refresh_dashboard.present?
      render json:  { dashboard_name: dashboard_name, interval: refresh_dashboard.as_json[dashboard_name] }
    else
      render json: { dashboard_name: dashboard_name, interval: 5 * 60 * 1000 } # Default to 5 minutes if not found
    end
  end  
end
