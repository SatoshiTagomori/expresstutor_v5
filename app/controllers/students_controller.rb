class StudentsController < ApplicationController
  def index
    require 'net/https'
    require 'uri'
    require 'json'

    uri = URI.parse("https://api.line.me/oauth2/v2.1/token")

    http = Net::HTTP.new(uri.host, uri.port)

    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    grant_type = "authorization_code"

    http.start do
      req = Net::HTTP::Post.new(uri.path)
      req.set_form_data(grant_type: grant_type,code: params[:code],redirect_uri: 'https://expresstutor.tokyo/students',client_id: '1655604727',client_secret: '9bf7eeb456791ccd36b8c775531f9ecf')
      @res = http.request(req)
    end

  end
end
