class ProposalsController < ApplicationController
  layout false, only: :decide

  before_filter :set_proposal, only: [:show, :edit, :update, :decide]
  before_filter :set_approval, only: [:show, :edit, :update, :decide]
  before_filter :new_proposal_from_params, only: [:new, :create]
  before_filter :pundit_authorize

  def index
    @proposals = policy_scope(Proposal)
  end

  def show
  end

  def new
  end

  def edit
  end

  def update
    @proposal.attributes = proposal_params
    if @proposal.save
      @proposal.approver_emails.uniq.each do |ae|
        @proposal.approvals.new(email: ae).save unless @proposal.approvals.pluck(:email).include? ae
      end
      flash[:info] = "Your proposal was successfully updated."
      redirect_to @proposal
    else
      render :new
    end
  end

  def create
    if @proposal.save
      @proposal.approver_emails.each do |ae|
        @proposal.approvals.new(email: ae).save
      end
      flash[:info] = "Your proposal was successfully created."
      redirect_to @proposal
    else
      render :new
    end
  end

  protected

  def new_proposal_from_params
    if params[:proposal]
      @proposal = Proposal.new(proposal_params)
    else
      @proposal = Proposal.new
    end
  end

  def proposal_params
    params.require(:proposal).permit([:title, :description, :attachment, :set_approver_emails]).merge({
      user_id: current_user.id
    })
  end

  def set_proposal
    @proposal = Proposal.find(params[:id]) if params[:id]
  end

  def set_approval
    if @proposal.approver_emails.include? current_user.email
      @approval = @proposal.approvals.where(email: current_user.email).first
    end
  end

  def pundit_authorize
    authorize (@proposal || Proposal)
  end
end
