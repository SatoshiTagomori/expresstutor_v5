module Utils::Line
    class Line
        def initialize
            @access_token_uri = "https://api.line.me/oauth2/v2.1/token"

        end



        #access_tokenのレスポンスを取得する    
        def get_access_token_response(code)
            return get_api_res(@access_token_uri,'POST',[code])
        end

        def get_api_res(uri,request_method,arg=[])
            uri = URI.parse(@access_token_uri)
            http = Net::HTTP.new(uri.host, uri.port)
            http.use_ssl = true
            http.verify_mode = OpenSSL::SSL::VERIFY_NONE
            grant_type = "authorization_code"
            http.start do
              req = Net::HTTP::Post.new(uri.path)
              req.set_form_data(grant_type: grant_type,code: arg[0],redirect_uri: LINE_REDIRECT_URL,client_id: LINE_CLIENT_ID,client_secret: LINE_SECRET)
              return http.request(req)
            end    
        end


    end
end