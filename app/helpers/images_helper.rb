module ImagesHelper
  def show_edit_mode?
    user_signed_in? && @user.images.count > 0 && current_user == @user
  end

  def edit_mode?
    params[:edit_mode]
  end
end
