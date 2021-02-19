class StudentsController < ApplicationController
  def index
    require 'net/https'
    require 'uri'
    require 'json'

    @res = get_access_token
  end
end
