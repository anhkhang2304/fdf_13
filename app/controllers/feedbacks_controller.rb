class FeedbacksController < ClientController

  def show
    @feedback = Feedback.new
  end

  def create
    @feedback = current_user.feedbacks.build feedback_params
    if @feedback.save
      flash[:success] = "Thank you for your feedback!"
    else
      flash[:danger] = t "add_fail"
    end
    redirect_to :back
  end

  private
  def feedback_params
    params.require(:feedback).permit :content, :user_id, :name
  end
end
