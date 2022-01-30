class CommentsController < ApplicationController

    def create
        @post = Post.find(params[:post_id])
        @comment = @post.comments.new(comment_params)
        @comment.user_id = current_user.id

        respond_to do |format|
            if @comment.save
              format.html { redirect_to post_url(@comment.post), notice: "Post was successfully created." }
              format.json { render :show, status: :created, location: @post }
            else
              format.html { redirect_to post_path(@comment.post) , status: :unprocessable_entity }
              format.json { render json: @post.errors, status: :unprocessable_entity }
            end
        end
    end

    def destroy
        @post = @comment.post
        @comment.destroy

        respond_to do |format|
            format.html { redirect_to posts_url(@post), notice: "Post was successfully destroyed." }
            format.json { head :no_content }
        end
    end

    private

    def comment_params
        params.require(:comment).permit(:body)
    end
end
