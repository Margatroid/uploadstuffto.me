module CanCreateNewAlbum extend ActiveSupport::Concern
  def new_album
    @album = Album.new
    render 'albums/new'
  end
end