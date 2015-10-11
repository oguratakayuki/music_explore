class YoutubePlaylistsController < ApplicationController
  before_action :set_youtube_playlist, only: [:show, :edit, :update, :destroy]

  # GET /youtube_playlists
  # GET /youtube_playlists.json
  def index
    @youtube_playlists = YoutubePlaylist.all
  end

  # GET /youtube_playlists/1
  # GET /youtube_playlists/1.json
  def show
  end

  # GET /youtube_playlists/new
  def new
    @youtube_playlist = YoutubePlaylist.new
  end

  # GET /youtube_playlists/1/edit
  def edit
  end

  # POST /youtube_playlists
  # POST /youtube_playlists.json
  def create
    @youtube_playlist = YoutubePlaylist.new(youtube_playlist_params)

    respond_to do |format|
      if @youtube_playlist.save
        format.html { redirect_to @youtube_playlist, notice: 'Youtube playlist was successfully created.' }
        format.json { render :show, status: :created, location: @youtube_playlist }
      else
        debugger
        format.html { render :new }
        format.json { render json: @youtube_playlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /youtube_playlists/1
  # PATCH/PUT /youtube_playlists/1.json
  def update
    respond_to do |format|
      if @youtube_playlist.update(youtube_playlist_params)
        format.html { redirect_to @youtube_playlist, notice: 'Youtube playlist was successfully updated.' }
        format.json { render :show, status: :ok, location: @youtube_playlist }
      else
        format.html { render :edit }
        format.json { render json: @youtube_playlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /youtube_playlists/1
  # DELETE /youtube_playlists/1.json
  def destroy
    @youtube_playlist.destroy
    respond_to do |format|
      format.html { redirect_to youtube_playlists_url, notice: 'Youtube playlist was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_youtube_playlist
      @youtube_playlist = YoutubePlaylist.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def youtube_playlist_params
      params.require(:youtube_playlist).permit(:file)
    end
end
