class Admin::AdminSessionsController < ApplicationController

    def create 
        admin = Admin.find_by(email: params[:email])

        if admin && admin.authenticate(params[:password])
            token = JWT.encode({admin_id: admin.id}, Rails.application.credentials.admin_auth[:secret_key_base], 'HS256')
            render json: { token: token }, status: :ok 
        else
            render json: { error: 'Invalid email or password' },status: :unauthorized
        end
    end

end
