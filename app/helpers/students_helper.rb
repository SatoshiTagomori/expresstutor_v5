module StudentsHelper
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
        if access_token_response.code != '200'
            set_error('アクセストークンの取得に失敗しました。')
        else
            access_token_body = JSON.parse(access_token_response.body)
            session[:access_token] = access_token_body["access_token"]
            return access_token_body["access_token"]
        end
    end

    def get_user_info(access_token)
        user_info_response = get_line_user_info_response(access_token)
        if user_info_response.code !='200'
            set_error('ユーザー情報の取得に失敗しました')
        else
            return JSON.parse(user_info_response.body)
        end
    end

end