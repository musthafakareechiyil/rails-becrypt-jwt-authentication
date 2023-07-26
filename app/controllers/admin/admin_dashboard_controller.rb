class Admin::AdminDashboardController < ApplicationController
    before_action :authenticate_admin


    private

    def authenticate_admin
        token = request.headers['Authorization']&.split(' ')&.last 
        decoded_token = JWT.decode(token, Rails.application.credentials.admin_auth[:secret_key_base] , true , algorithm: 'HS256')

        admin_id = decoded_token.first['admin_id']
        @current_admin = Admin.find(admin_id)

    rescue JWT::DecodeErorr, ActiveRecord::RecordNotFound 
        render json: { error: 'Unauthorized admin' }, status: :unauthorized
    end
end
