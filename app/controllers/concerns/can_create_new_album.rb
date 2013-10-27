module CanCreateNewAlbum extend ActiveSupport::Concern
  def new_album
    if params[:add_to_album] && params[:selected].any?
      @images = Image.where(:user_id => current_user.id).find(params[:selected])
    end

    @album = Album.new
    @album.title = 'Untitled'
    render 'albums/new'
  end
end