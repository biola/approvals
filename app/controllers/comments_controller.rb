class CommentsController < ApplicationController

  def create
    @proposal = Proposal.find(params[:proposal_id])
    @comment = @proposal.comments.new(comment_params)
    authorize @comment

    if @comment.save && @proposal.save
      flash[:info] = "Comment was successfully created."
    else
      flash[:error] = "There was a problem saving your comment."
    end

    redirect_to @proposal
  end


  protected

  def comment_params
    params.require(:comment).permit([:text]).merge({
      user_id: current_user.id,
      name: current_user.name,
      email: current_user.email,
      photo_url: current_user.photo_url
    })
  end
end
