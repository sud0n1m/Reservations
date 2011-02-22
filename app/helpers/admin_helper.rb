module AdminHelper
  def admin_user
    redirect_to(root_path) unless current_user.admin? 
  end
end