class ApplicationController < ActionController::API
    include JsonWebToken

    before_action :authenticate_request, unless: :admin_request?

    private

    def authenticate_request
        header = request.headers["Authorization"]
        header = header.split(" ").last if header.present?
        token = header
      
        decoded = jwt_decode(token) if token.present?
        if decoded.nil?
          render json: { error: "Unauthorized" }, status: :unauthorized
          return
        end
      
        @current_user = User.find(decoded[:user_id])
        p @current_user
    end

    def admin_request? 
      controller_path.start_with?("admin/")
    end
      
end
