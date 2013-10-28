class AlbumsController < ApplicationController
  before_action :set_album, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!,
                :only => [:new, :create, :update, :edit, :destroy]
  include CanCreateNewAlbum

  # GET /albums
  # GET /albums.json
  # GET /profile/:username/albums
  def index
    if params[:username]
      user = User.find_by_username(params[:username])
      @albums = user.albums
    else
      @albums = Album.all
    end
  end

  # GET /albums/1
  # GET /albums/1.json
  def show
    @images = @album.images
  end

  # GET /albums/new
  def new
    @images = []
    new_album
  end

  # GET /albums/1/edit
  def edit
  end

  # POST /albums
  # POST /albums.json
  def create
    @album = Album.new(album_params.except(:add_to_album, :selected))
    @album.user_id = current_user.id

    album_has_saved = @album.save

    # Add images to album after album has saved successfully.
    if album_has_saved && album_params[:add_to_album]
      @album.add_images(current_user, album_params[:selected])
    end

    respond_to do |format|
      if album_has_saved
        format.html { redirect_to @album, notice: 'Album was successfully created.' }
        format.json { render action: 'show', status: :created, location: @album }
      else
        format.html { render action: 'new' }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /albums/1
  # PATCH/PUT /albums/1.json
  def update
    respond_to do |format|
      if @album.update(album_params)
        format.html { redirect_to @album, notice: 'Album was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /albums/1
  # DELETE /albums/1.json
  def destroy
    @album.destroy
    respond_to do |format|
      format.html { redirect_to albums_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_album
      @album = Album.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def album_params
      params.require(:album)
            .permit(:title, :user_id, :add_to_album, :selected, { selected: [] })
    end
end
