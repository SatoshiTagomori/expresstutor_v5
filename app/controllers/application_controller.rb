class ApplicationController < ActionController::Base
    require 'net/https'
    require 'uri'
    require 'json'
    require 'base64'
    include StudentsHelper
end
