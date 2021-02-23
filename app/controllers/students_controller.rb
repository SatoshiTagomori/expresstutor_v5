class StudentsController < ApplicationController
  include Utils::Line
  def index
    @line = Line.new

    #アクセストークンを取得する
    if @line.get_access_token(params[:code]) != false
      #ユーザー情報を取得する
      if @line.get_user_info() != false
        #テーブルに値を入れて、セッションに必要事項を書く
        set_student_data(@line)
        flash.now[:success] = 'ログインしました'
      else
        flash.now[:danger] = 'ユーザー情報の取得に失敗しました'
      end
    else
      flash.now[:danger] = 'アクセストークンの取得に失敗しました。管理者にお問い合わせください' 
    end

=begin
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
=end

  end

  def edit
  end

  def update_personal
    current_user.personal.update(personal_update_params)
    redirect_to student_edit_path
  end

  def create
    Personal.create(personal_params)
    redirect_to students_path
  end

  def logout
    session[:student_id]=nil
    session[:access_token]=nil
    session[:user_id]=nil
    session[:user_type]=nil
    current_user=nil
    redirect_to root_path
  end



  private

  def personal_params
    params.require(:personal).permit(:name,:cname,:tel,:pref_id,:gakunen_id).merge(:student_id=>current_user.id)
  end

  def personal_update_params
    params.require(:personal).permit(:name,:cname,:tel,:pref_id,:gakunen_id)
  end


end
