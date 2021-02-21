class StudentsController < ApplicationController
  def index
    #アクセストークンが有効であれば
    if is_logined == false
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
