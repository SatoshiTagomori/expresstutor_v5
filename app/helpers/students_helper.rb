module StudentsHelper

    #ログインしているかどうかのチェック
    def student
        #カレントユーザーがなければ
        if @student==nil
            #アクセストークンの有効性チェック
            if check_access_token
                #アクセストークンが問題なければ
                #ユーザー情報を取得して
                user_info= get_user_info(session[:access_token])
                #lineidからユーザー情報を取得する
                @student = Student.find_by(:lineid => @user_info["userId"])
                #dbになければinsertしておく
                student_insert
            else
                return nil
            end
        else
            #カレントユーザーがあれば特に何もしなくて良い
            @student
        end     
    end

    def student_insert
        if @student.blank?
            @student = Student.create(:name=>@user_info["displayName"],:lineid=>@user_info["userId"])
        end
    end


    #アクセストークンの有効性チェック
    def check_access_token()
        if session[:access_token].present?
            uri = URI.parse("https://api.line.me/oauth2/v2.1/verify")
            para = {:access_token => session[:access_token]}
            uri.query = URI.encode_www_form(para)
            res = Net::HTTP.get_response(uri)
            if res.code =="200"
              return true
            else
              return false
            end
        else
            return false
        end
    end

    def get_access_token_response(code)
        uri = URI.parse("https://api.line.me/oauth2/v2.1/token")
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        grant_type = "authorization_code"
        http.start do
          req = Net::HTTP::Post.new(uri.path)
          req.set_form_data(grant_type: grant_type,code: code,redirect_uri: LINE_REDIRECT_URL,client_id: LINE_CLIENT_ID,client_secret: LINE_SECRET)
          return http.request(req)
        end    
    end

    def get_line_user_info_response(access_token)
        uri = URI.parse("https://api.line.me/v2/profile")
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        headers={"Authorization" =>"Bearer "+access_token}
        http.start do
          req = Net::HTTP::Get.new(uri.path)
          req.initialize_http_header(headers)
          return http.request(req)
        end    
    end

    def set_error(msg)
        if session[:error].blank?
            session[:error]=[]
        end
        session[:error].push(msg)
    end

    def is_no_error
        return session[:error].blank?
    end

    def get_access_token(code)
        access_token_response = get_access_token_response(code)
        logger.debug access_token_response
        if access_token_response.code != '200'
            set_error(access_token_response.to_s)
            set_error('アクセストークンの取得に失敗しました。')
        else
            access_token_body = JSON.parse(access_token_response.body)
            session[:access_token] = access_token_body["access_token"]
            return access_token_body["access_token"]
        end
    end

    def get_user_info(access_token)
        user_info_response = get_line_user_info_response(access_token)
        logger.debug user_info_response
        if user_info_response.code !='200'
            set_error('ユーザー情報の取得に失敗しました')
        else
            return JSON.parse(user_info_response.body)
        end
    end

    

end
