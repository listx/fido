class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  before_action :logged_in_user, only: [:new, :edit, :update, :destroy]

  before_action :correct_user, only: [:edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    if logged_in?
      # FIXME: only show own (authored) posts; for admins, show all posts
      @posts = admin_user? ? Post.all : Post.where(user_id: current_user.id)
      @is_admin = admin_user?
    else
      respond_to do |format|
        format.html { redirect_to root_url, notice: 'Cannot view all posts.' }
      end
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @user = User.find(@post.user_id)
  end

  # GET /posts/new
  def new
    @post = Post.new\
      published: true
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params.merge!\
      user_id: current_user.id
    )

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:user_id, :title, :body, :published)
    end

    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      if @post.nil?
        redirect_to posts_url
      end
    end
end
