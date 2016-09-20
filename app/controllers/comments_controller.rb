class CommentsController < ClientController

  def create
    @comment = current_user.comments.build comment_params
    if @comment.save
      flash[:success] = t "add_success"
      respond_to do |format|
        format.html {render partial: "comment", object: @comment, layout: false}
      end
    else
      flash[:danger] = t "add_fail"
    end
  end

  private
  def comment_params
    params.require(:comment).permit :content, :user_id, :product_id
  end
end
