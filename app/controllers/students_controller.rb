class StudentsController < ApplicationController
  def index
    require 'net/https'
    require 'uri'
    require 'json'

    @res = get_access_token(params[:code])
    @res2 = get_line_user_info(@res.access_token)
  end
end
