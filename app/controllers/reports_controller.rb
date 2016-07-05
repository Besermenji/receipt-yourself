class ReportsController < ApplicationController

  respond_to :json

  def create
    parsed_reports = ActiveSupport::JSON.decode(params[:reports].to_json)
    user_id = parsed_reports['user']['id']
    report_type = parsed_reports['type']
    bp_contact_card_id = parsed_reports['bp_contact_card_id']
    respond_with(user_id)
  end

  def kif
    # temp user
    u = User.first
    info = JSON.parse(OutputInvoice.where(company: u.company).to_json)
    sendJSON(u.email, u.company, info, '/kif')
  end

  def kuf
    u = User.first
    input_invoices = []
    u.company.financial_years.each do |year|
      year.input_invoices.each do |ii|
        input_invoices << ii
      end
    end
    info = JSON.parse(input_invoices.to_json)
    sendJSON(u.email, u.company, info, '/kuf')
  end

  def partner_card
    u = User.first
    input_invoices = []
    output_invoices = []
    BusinessPartner.find_each do |partner|
      input_invoices << partner.input_invoices
      output_invoices << partner.output_invoices
    end
    ii = JSON.parse(input_invoices.to_json)
    oo = JSON.parse(output_invoices.to_json)
    sendJSON(u.email, u.company, [ii, oo], '/partner_card')
  end

  def ios
    u = User.first
    opened_output = JSON.parse(OutputInvoice.opened.to_json)
    opened_input = JSON.parse(InputInvoice.opened.to_json)
    sendJSON(u.email, u.company, [opened_output, opened_input], '/ios')
  end

  private
  
  def sendJSON(email, company, info, path)
    set_authorization_info
    set_JSON_destination
    RestClient.post @rg_address + path, {:data=> {email: email, 
                                                  company: company,
                                                  info: info}.to_json}
  end

  def set_JSON_destination
    @rg_address = if Rails.env.development?
                    "http://#{@username}:#{@password}@localhost:9292"
                  elsif Rails.env.production?
                    "https://#{@username}:#{@password}@ry-report-generator.herokuapp.com"
                  end
  end

  def set_authorization_info
    if Rails.env.development?
      @username = "admin"
      @password = "admin"
    elsif Rails.env.production?
      @username = ENV["SINATRA_USERNAME"]
      @password = ENV["SINATRA_PASSWORD"]
    end
  end

  def input_invoice_params
    params[:reports]
  end
end