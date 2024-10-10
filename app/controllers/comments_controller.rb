class CommentsController < ApplicationController
  before_action :authenticate_user!, only: %i[ new edit create update destroy]
  before_action :set_post, only: %i[ new create edit update ]
  before_action :set_comment, only: %i[ edit update destroy ]

  # GET /comments/1/edit
  def edit
  end

  def new
    @comment = Comment.new(post: @post)
  end

  # POST /comments or /comments.json
  def create
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id
    @comment.post_id = @post.id

    respond_to do |format|
      if @comment.save
        format.html { redirect_to user_post_path(@post.user, @post), notice: "Comment was successfully created."}

        flash[:notice] = "Comment was successfully created."

      else
        format.html { redirect_to user_post_path, notice: "Comment was not successfully created."}
      end
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to user_post_path(current_user), notice: "Comment was successfully updated." }
      else
        format.html { redirect_to user_post_path , notice: "Comment was not successfully updated." }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy!

    #respond_to do |format|
      #format.html { redirect_to user_post_path, status: :see_other, notice: "Comment was successfully destroyed." }
      #format.json { head :no_content }
    #end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def set_user_id
      @user = current_user.id
    end

    def set_post
      @post = Post.find(params[:post_id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:body)
    end
end

