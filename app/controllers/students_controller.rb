class StudentsController < ApplicationController
  include Utils::Line
  def index
    if is_logined
      return
    end

    @line = Line.new
    #アクセストークンが存在する場合ならば
    if session[:access_token].present?
      @line.access_token = session[:access_token]
      if @line.check_access_token()
        if @line.get_user_info() != false
          #テーブルに値を入れて、セッションに必要事項を書く
          set_student_data(@line)
        else
          flash[:danger] = 'ユーザー情報の取得に失敗しました。再度ログインしてください。'
          sign_out_action
        end
      else
        flash[:danger] = 'アクセストークンが有効期限切れです。再度ログインしてください。'
        sign_out_action
      end
    else
      #アクセストークンを取得する
      if @line.get_access_token(params[:code]) != false
        #ユーザー情報を取得する
        if @line.get_user_info() != false
          #テーブルに値を入れて、セッションに必要事項を書く
          set_student_data(@line)
          flash.now[:success] = 'ログインしました'
        else
          flash[:danger] = 'ユーザー情報の取得に失敗しました。管理者にお問い合わせください。'
          sign_out_action
        end
      else
        flash[:danger] = 'アクセストークンの取得に失敗しました。管理者にお問い合わせください。' 
        sign_out_action
      end
    end


  end

  def edit
  end

  def update_personal
    current_user.personal.update(personal_update_params)
    flash[:success] ='お客様情報を編集しました。'
    redirect_to students_path
  end

  def create
    personal_data = Personal.new(personal_params)
    if personal_data.save
      flash[:success]='登録しました'
      redirect_to students_path and return
    else
      flash[:danger] = '入力内容に不備がございます。再度ご確認ください。'
      redirect_to students_path and return
    end
    
  end

  def logout
    sign_out
    redirect_to root_path
  end

  def payment
    @products = Product.all
  end



  private

  def personal_params
    params.require(:personal).permit(:name,:cname,:tel,:pref_id,:gakunen_id,:email,:email_confirmation).merge(:student_id=>current_user.id)
  end

  def personal_update_params
    params.require(:personal).permit(:name,:cname,:tel,:pref_id,:gakunen_id,:email,:email_confirmation)
  end


end
