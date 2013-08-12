class UsersController < ApplicationController

  before_filter :autenticate_user, :only => [:show, :edit, :update]

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    @user.password = User.encrypt_password(@user.password)

    respond_to do |format|
      if @user.save
        # Auto login
        session[:user_id] = @user.id
        format.html { redirect_to chirps_path, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /logout
  def logout
    session.clear
    redirect_to login_path
  end

  # GET /login
  def login
    @user = User.new
  end

  # POST /login
  def create_session
    email = params[:user][:email]
    password = params[:user][:password]
    if email and password and not (email.blank? or password.blank?)
      if user = User.find_by_email(email) and user.does_password_match?(password)
        session[:user_id] = user.id
        redirect_to root_path
      else
        redirect_to login_path, :notice => "Email and password did not match!"
      end
    else
      redirect_to login_path, :notice => "Both email and password are required!"
    end
  end

end