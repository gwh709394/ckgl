module V1
  class Base < Grape::API
    version 'v1', :using => :path
    mount V1::SessionsApi
    
    
    rescue_from :all, backtrace: true
    # error_formatter :json, API::ErrorFormatter
    format :json
    before do
      # error!("401 Unauthorized, 401") unless authenticated
      error!({result: -1, message: '无效或者过期的授权'}, 401) unless authenticated
    end
  
    helpers do
      def warden
        env['warden']
      end
    
      def authenticated
        return true if warden.authenticated?
        params[:access_token] && @user = User.find_by_access_token(params[:access_token])
      end
    
      def current_user
        warden.user || @user  
      end
    
    end
    add_swagger_documentation(
      :api_version => "api/v1",
      hide_documentation_path: true,
      hide_format: true
    )
    mount V1::StocksApi
    
  
  end
end