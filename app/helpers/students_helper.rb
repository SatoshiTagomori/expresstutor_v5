module StudentsHelper

    def current_user
        if @current_user.blank?
            if session[:user_type]
                user_type = session[:user_type]
                eval(user_type.capitalize+'.find_by(:id=>session[:user_id])')
            else
                nil
            end
        else
            @current_user
        end
    end


    def set_student_data(line)
        #lineidでテーブルを検索
        student = Student.find_by(:lineid => line.user["userId"])
        #存在しなければ生成
        if student.blank?
            student = Student.create(:name=>line.user["displayName"],:lineid=>line.user["userId"])
        else
            #存在すれば表示名をアップデート
            student.update(:name=>line.user["displayName"])
        end
        #セッションに値を入れる
        session[:access_token]=line.access_token
        session[:user_type] = 'student'
        session[:user_id] = student.id
    end

    def is_logined
        #セッションにstudent_idがあるかどうかでログインしているかどうかを判断。
        #ただし、なんらかの事情でstudent_idが欠損していたとしてもアクセストークンが
        #有効であればログイン済みの状態にする

        #まずはローカル環境
        if `hostname`.strip == 'tagomorisounoMac-mini.local'
            student = Student.find(1)
            session[:user_id] = student.id
            session[:user_type]='student'
            return true
        end

        if session[:user_id].blank?
            return false
        else
            return true
        end
    end

    def sign_out_action
        sign_out
        redirect_to root_path
    end

    def sign_out
        session[:student_id]=nil
        session[:access_token]=nil
        session[:user_id]=nil
        session[:user_type]=nil
        current_user=nil
    end

end
