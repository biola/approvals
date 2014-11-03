class ApprovalsController < ApplicationController

  before_filter :new_approval_from_params, only: [:new, :create]
  before_filter :set_proposal
  before_filter :set_approval

  def create
  end

  def update
    authorize (@approval || Approval)

    @approval.attributes = approval_params

    if @approval.save
      flash[:info] = "Your decision has been successfully recorded."
    else
      flash[:warning] = "Something went wrong. Please try again."
    end

    redirect_to @proposal
  end

  def decide
    render partial: 'decide'
  end

  protected
  def set_approval
    @approval = @proposal.approvals.find(params[:id]) if params[:id]
  end

  def set_proposal
    @proposal = Proposal.find(params[:proposal_id]) if params[:proposal_id]
  end

  def approval_params
    params.require(:approval).permit([:approved, :text]).merge({
      user_id: current_user.id.to_s,
      name: current_user.name,
      email: current_user.email,
      photo_url: current_user.photo_url
    })
  end
end
