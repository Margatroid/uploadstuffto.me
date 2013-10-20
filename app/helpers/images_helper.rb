module ImagesHelper
  def show_edit_mode?
    return unless @user
    user_signed_in? && @user.images.count > 0 && current_user == @user
  end

  def edit_mode?
    show_edit_mode? && params[:edit_mode]
  end

  def show_gallery_pagination(collection)
    if collection.total_pages > 1
      render 'images/gallery_pagination', :collection => collection
    end
  end

  def edit_mode_checkbox(image)
    return unless show_edit_mode? && edit_mode?
    sprintf('<input type="checkbox" name="selected[]" value="%d" />',
            image.id).html_safe
  end
end
