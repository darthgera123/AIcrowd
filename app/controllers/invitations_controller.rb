class InvitationsController < ApplicationController
  before_action :set_challenge

  def import
    InvitationImporter.new(file: params[:file], challenge_id: @challenge.id).call
    # TODO: Make sure change of redirect URL doesn't cause issues
    redirect_to edit_challenge_path(@challenge)
  end

  def set_challenge
    @challenge = Challenge.friendly.find(params[:challenge_id])
  end
end
