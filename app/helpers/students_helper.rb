module StudentsHelper
    def get_access_token(code)
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

    def get_line_user_info(access_token)
        uri = URI.parse("https://api.line.me/v2/profile")
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        http.start do
          req = Net::HTTP::Get.new(uri.path)
          #req.set_form_data(Authorization: a_token)
          req.initialize_http_header("Bearer "+access_token)
          return http.request(req)
        end    
    end

end
