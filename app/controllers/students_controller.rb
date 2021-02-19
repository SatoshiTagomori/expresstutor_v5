class StudentsController < ApplicationController
  def index
    require 'net/https'
    require 'uri'
    require 'json'
    require 'base64'
    @error = []

    access_token_response = get_access_token(params[:code])
    if access_token_response.code != '200'
      @error.push('アクセストークンの取得に失敗しました。')
      return
    end

    access_token_body = JSON.parse(access_token_response.body)
    
    user_info_response = get_line_user_info(access_token_body["access_token"])

    if user_info_response.code !='200'
      @error.push('ユーザー情報の取得に失敗しました')
      return
    end
    
    @user_info = JSON.parse(user_info_response.body)
  end
end
