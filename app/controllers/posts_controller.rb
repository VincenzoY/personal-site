class PostsController < ApplicationController
  before_action :is_own_post?, only: %i[ edit update destroy ]
  before_action :authenticate_user!, only: %i[ new edit create update destroy ]
  before_action :is_admin?, only: %i[ new edit create update destroy ]

  # GET /posts or /posts.json
  def index
    @posts = Post.includes(:user).all.order("created_at DESC")
  end

  # GET /posts/1 or /posts/1.json
  def show
    @post = Post.includes(:user).find(params[:id])
    @comments = @post.comments.includes(:user).order("created_at DESC")
    @comment = @post.comments.new
  end

  # GET /posts/new
  def new
    @post = current_user.posts.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = current_user.posts.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_path, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def is_own_post?
      @post = Post.includes(:user).find(params[:id])
      unless @post.user == current_user || current_user.try(:admin)
        flash[:alert] = "Unauthorized Access"
        redirect_to posts_path
      end
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :body)
    end

    def is_admin?
      unless current_user.admin
        flash[:alert] = "User not authorized for access"
        redirect_to posts_path
      end
    end
end
