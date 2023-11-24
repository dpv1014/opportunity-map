class Ability
  include CanCan::Ability

  def initialize(user)
    can [:profile, :update_profile], User
    if user.admin?
      can :manage, :all
    end
  end
end
