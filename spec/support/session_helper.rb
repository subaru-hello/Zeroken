class SessionHelper
    def current_user
      token = session[:token]
      if token.present?
        @user ||= User.find_by(id:session[:user_id])
      end
    end
  end
  