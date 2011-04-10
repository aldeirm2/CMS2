class Ability
  include CanCan::Ability

  def initialize(user)

    can :manage, CriticalProcess do |cp|
      cp.editors.include?(user)
    end

    can :manage, Review do |cp|
      cp.reviewers.include?(user)
    end

        # can only make changes to his own user profile
    can :edit, User do |user_for_edit|
       user_for_edit == user
    end

    # check if user is able to create new CP
    can :new, CriticalProcess if user.is_admin

    # Index page for users only for admins
    can :index, User if user.is_admin

    # check if user can view the CP

    if user.is_admin
      can :manage, :all
    else
      can :read, CriticalProcess
    end

  end
end