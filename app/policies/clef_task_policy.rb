class ClefTaskPolicy < ChallengePolicy
  def new?
    edit?
  end

  def create?
    new?
  end
end
