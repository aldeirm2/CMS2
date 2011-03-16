class Ability
  include CanCan::Ability

  def initialize(user)

     can :manage, CriticalProcess
     if user.cps_as_editor.include?(CriticalProcess)

     end

    if user.is_admin
      can :manage, :all
    else
      can :read, CriticalProcess
    end

  end
end