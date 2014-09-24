class ApprovalsController < ApplicationController

  before_filter :set_approval, only: [:show, :edit, :update]
  before_filter :new_approval_from_params, only: [:new, :create]
  before_filter :pundit_authorize

  def index
    @approvals = policy_scope(Approval)
  end

  def show
  end

  def new
  end

  def create
    if @approval.save
      flash[:info] = "Approval was successfully created."
      redirect_to @approval
    else
      render :new
    end
  end

  def add_comment

  end


  protected

  def new_approval_from_params
    if params[:approval]
      @approval = Approval.new(approval_params)
    else
      @approval = Approval.new
    end
  end

  def approval_params
    params.require(:approval).permit([:title, :description, :attachment, :set_approver_emails])
  end

  def set_approval
    @approval = Approval.find(params[:id]) if params[:id]
  end

  def pundit_authorize
    authorize (@approval || Approval)
  end
end
