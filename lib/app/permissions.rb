module App::Permissions
  protected

  def unauthorized!
    if current_user
      render 'shared/403', :status => 403
    else
      flash[:error] = "You must be logged in to access this area"
      redirect_to new_user_session_url
    end
  end

  def allowed_to?(permission, object)
    if can? permission, object
      yield
    else
      unauthorized!
    end
  end
end