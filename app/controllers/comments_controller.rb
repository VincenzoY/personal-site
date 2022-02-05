class CommentsController < ApplicationController
    before_action :own_comment?, only: [:destroy]
    before_action :authenticate_user!

    def create
        @post = Post.find(params[:post_id])
        @comment = @post.comments.new(comment_params)
        @comment.user_id = current_user.id

        respond_to do |format|
            if @comment.save
              format.html { redirect_to post_url(@comment.post), notice: "Comment created." }
              format.json { render :show, status: :created, location: @post }
            else
              format.html { redirect_to post_path(@comment.post) , alert: "Missing field." }
              format.json { render json: @post.errors, status: :unprocessable_entity }
            end
        end
    end

    def destroy
        @comment = Post.find(params[:post_id]).comments.find(params[:id])
        @comment.destroy

        respond_to do |format|
            format.html { redirect_to post_url(params[:post_id]), notice: "Comment was successfully destroyed." }
            format.json { head :no_content }
        end
    end

    private

    def comment_params
        params.require(:comment).permit(:body)
    end

    def own_comment?
        @comment = Post.find(params[:post_id]).comments.find(params[:id])
        unless @comment.user == current_user || current_user.admin
            flash[:alert] = "Unauthorized Access"
            redirect_to posts_path
        end
    end
end
