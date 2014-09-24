class CommentsController < ApplicationController

  def create
    @approval = Approval.find(params[:approval_id])
    @comment = @approval.comments.new(comment_params)
    authorize @comment

    # Mark the person as approving or denying on the parent approval
    if params[:button] == "approve"
      @approval.approve(current_user.email)
    elsif params[:button] == "deny"
      @approval.deny(current_user.email)
    end

    if @comment.save && @approval.save
      flash[:info] = "Comment was successfully created."
    else
      flash[:error] = "There was a problem saving your comment."
    end

    redirect_to @approval
  end


  protected

  def comment_params
    params.require(:comment).permit([:text]).merge({
      name: current_user.name,
      email: current_user.email,
      photo_url: current_user.photo_url,
      approved: params[:button] == "approve",
      denied: params[:button] == "deny",
    })
  end
end
