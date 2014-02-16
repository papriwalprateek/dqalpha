class WikialgosController < ApplicationController
  # GET /wikialgos
  # GET /wikialgos.json
  def index
    @wikialgos = Wikialgo.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @wikialgos }
    end
  end

  # GET /wikialgos/1
  # GET /wikialgos/1.json
  def show
    @wikialgo = Wikialgo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @wikialgo }
    end
  end

  # GET /wikialgos/new
  # GET /wikialgos/new.json
  def new
    @wikialgo = Wikialgo.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @wikialgo }
    end
  end

  # GET /wikialgos/1/edit
  def edit
    @wikialgo = Wikialgo.find(params[:id])
  end

  # POST /wikialgos
  # POST /wikialgos.json
  def create
    @wikialgo = Wikialgo.new(params[:wikialgo])

    respond_to do |format|
      if @wikialgo.save
        format.html { redirect_to @wikialgo, notice: 'Wikialgo was successfully created.' }
        format.json { render json: @wikialgo, status: :created, location: @wikialgo }
      else
        format.html { render action: "new" }
        format.json { render json: @wikialgo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /wikialgos/1
  # PUT /wikialgos/1.json
  def update
    @wikialgo = Wikialgo.find(params[:id])
    params["pages"].each do |idd|
      t = @wikialgo.pages.find_by("_id"=>idd)
      t.destroy
    end  
    respond_to do |format|
      if @wikialgo.update_attributes(params[:wikialgo])
        format.html { redirect_to @wikialgo, notice: "Wikialgo was successfully updated." }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @wikialgo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wikialgos/1
  # DELETE /wikialgos/1.json
  def destroy
    @wikialgo = Wikialgo.find(params[:id])
    @wikialgo.destroy

    respond_to do |format|
      format.html { redirect_to wikialgos_url }
      format.json { head :no_content }
    end
  end
end
