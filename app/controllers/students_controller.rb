class StudentsController < ApplicationController
  def index
    #ログイン状態でなければ
    if is_logined == false
      #アクセストークンを取得してセッションにいれる
      access_token = get_access_token(params[:code])
      #エラーがなければ
      if is_no_error()
        #ユーザー情報を取得する
        @user_info = get_user_info(access_token)
        @student = Student.find_by(:lineid => @user_info["userId"])
        @student = student_insert(@student,@user_info)
        session[:student_id]=@student.id
        session[:lineid]=@student.lineid
      end
    end

  end



end
