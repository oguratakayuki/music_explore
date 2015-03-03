class ItunesController < ApplicationController
  before_action :set_itune, only: [:show, :edit, :update, :destroy]

  # GET /itunes
  # GET /itunes.json
  def index
    @itunes = Itune.all
  end

  # GET /itunes/1
  # GET /itunes/1.json
  def show
  end

  # GET /itunes/new
  def new
    @itune = Itune.new
  end

  # GET /itunes/1/edit
  def edit
  end

  # POST /itunes
  # POST /itunes.json
  def create
    @itune = Itune.new(itune_params)

    respond_to do |format|
      if @itune.save
        format.html { redirect_to @itune, notice: 'Itune was successfully created.' }
        format.json { render :show, status: :created, location: @itune }
      else
        format.html { render :new }
        format.json { render json: @itune.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /itunes/1
  # PATCH/PUT /itunes/1.json
  def update
    respond_to do |format|
      if @itune.update(itune_params)
        format.html { redirect_to @itune, notice: 'Itune was successfully updated.' }
        format.json { render :show, status: :ok, location: @itune }
      else
        format.html { render :edit }
        format.json { render json: @itune.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /itunes/1
  # DELETE /itunes/1.json
  def destroy
    @itune.destroy
    respond_to do |format|
      format.html { redirect_to itunes_url, notice: 'Itune was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_itune
      @itune = Itune.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def itune_params
      params.require(:itune).permit(:name, :file)
    end
end
