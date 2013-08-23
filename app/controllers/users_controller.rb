class UsersController < ApplicationController
  
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]
  before_filter :require_vinay, :only => :index
  # GET /users
  # GET /users.json
 
 respond_to :html, :json, :js
 def index
    @users = User.search(params[:search])
    @quests = Quest.all
    @q = Q.where(:title => "Add a Q")
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
      format.xml  { render :xml => @users }
      format.js # index.js.erb
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
	@posts = @user.posts()
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user.as_json(only: [:name, :email]) }
    end
  end
  

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new
    render :layout => false
 
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
       flash[:notice] = "Thanks for signing up, we've delivered an email to you with instructions on how to complete your registration!"
      UserMailer.verification_instructions(@user).deliver
        format.html { redirect_to "/about" }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
    UserMailer.welcome_email(@user).deliver
  end

  # PUT /users/1
  # PUT /users/1.json
def update
  @user = User.find(params[:id])
  @user.update_attributes(params[:user])
  respond_with @user
end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
