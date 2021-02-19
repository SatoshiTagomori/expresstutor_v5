class StudentsController < ApplicationController
  def index
    require 'net/https'
    require 'uri'
    require 'json'
    require 'base64'
=begin
    access_token_response = get_access_token(params[:code])
    if access_token_response.code != '200'
      set_error('アクセストークンの取得に失敗しました。')
      return
    end

    access_token_body = JSON.parse(access_token_response.body)
    session[:access_token] = access_token_body["access_token"]
=end
    #アクセストークンを取得してセッションにいれる
    access_token = get_access_token(params[:code])

    #エラーがなければ
    if is_no_error()
      @user_info = get_user_info(access_token)
    end
  end
end
