class StudentsController < ApplicationController
  def index
    require 'net/https'
    require 'uri'
    require 'json'

    @res = get_access_token(params[:code])
    @res3 = JSON.parse(@res.body)
    @res2 = get_line_user_info(@res3["access_token"])
  end
end
