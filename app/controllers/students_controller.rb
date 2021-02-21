class StudentsController < ApplicationController
  def index
    require 'net/https'
    require 'uri'
    require 'json'
    require 'base64'
    #アクセストークンが有効であれば
    if check_access_token
      @user_info= get_user_info(session[:access_token])
      @student = Student.find_by(:lineid => @user_info["userId"])
      if @student.blank?
        @student = Student.create(:name=>@user_info["displayName"],:lineid=>@user_info["userId"])
      end
    else
      #アクセストークンを取得してセッションにいれる
      access_token = get_access_token(params[:code])
      #エラーがなければ
      if is_no_error()
        #ユーザー情報を取得する
        @user_info = get_user_info(access_token)
        @student = Student.find_by(:lineid => @user_info["userId"])
        if @student.blank?
          @student = Student.create(:name=>@user_info["displayName"],:lineid=>@user_info["userId"])
        end
      end
    end

  end



end
