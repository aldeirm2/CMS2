class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new

    can :manage, CriticalProcess do |cp|
      if cp.editors
      cp.editors.include?(user)
      else
        false
      end
    end

    can :read, CriticalProcess do |cp|
      if cp == cp.latest_approved_revision
        true
      elsif user.has_access_to(cp)
        true
      end
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
      can :new, User
    end

  end
end