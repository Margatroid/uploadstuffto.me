module ImagesHelper
  def show_edit_mode?
    user_signed_in? && @user.images.count > 0 && current_user == @user
  end

  def edit_mode?
    params[:edit_mode]
  end

  def show_gallery_pagination(collection)
    if collection.total_pages > 1
      render 'images/gallery_pagination', :collection => collection
    end
  end
end
