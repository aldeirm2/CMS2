class Ability
  include CanCan::Ability

  def initialize(user)

     can :manage, CriticalProcess do |cp|
        user.can_edit(cp)
     end

    if user.is_admin
      can :manage, :all
    else
      can :read, CriticalProcess
    end

  end
end