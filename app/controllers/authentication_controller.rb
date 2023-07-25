class AuthenticationController < ApplicationController
    skip_before_action :authenticate_request

    def login 
        @user = User.find_by_email(params[:email])
        if @user&.authenticate(params[:password])
            token = jwt_encode(user_id: @user.id)
            render json: {
                user: @user,
                 token: token,
                 status: "success",
                 }, status: :ok 
            p "logged in in auth controller"
            p token
        else
            render json: { error: 'unauthorized' }, status: :unauthorized
        end
    end
end
