class StudentsController < ApplicationController
  def index
    require 'net/https'
    require 'uri'
    require 'json'
    require 'base64'

    @res = get_access_token(params[:code])
    @res3 = JSON.parse(@res.body)
    @res2 = get_line_user_info(@res3["access_token"])
    res4 = Base64.decode64(@res2.body)
    @res5 = JSON.parse(res4)
  end
end
