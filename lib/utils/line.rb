module Utils::Line
    class Line
        attr_accessor :access_token
        def initialize
            @access_token=''
            @access_token_uri = "https://api.line.me/oauth2/v2.1/token"

        end



        #アクセストークンを取得する
        def get_access_token(code)
            access_token_response = self.get_access_token_response(code)
            if access_token_response.code != '200'
                return false
            else
                access_token_body = JSON.parse(access_token_response.body)
                @access_token = access_token_body["access_token"]
                return true
            end
        end

        #access_tokenのレスポンスを取得する
        def get_access_token_response(code)
            uri = URI.parse(@access_token_uri)
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


    end
end
