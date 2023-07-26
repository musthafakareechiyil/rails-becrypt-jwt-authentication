class Admin::AdminSessionsController < ApplicationController

    def create 
        admin = Admin.find_by(email: params[:email])

        if admin && admin.authenticate(params[:password])
            payload = { admin:admin}
            token = JWT.encode(payload, Rails.application.credentials.admin_auth[:secret_key_base], 'HS256')
            render json: { 
                token: token,
                admin: true,
                status: 'success',
                }, status: :ok 
                p token
        else
            render json: { error: 'something went wrong' },status: :unauthorized
        end
    end

end
