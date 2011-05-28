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

     # check if user can view the CP
    can :read, CriticalProcess do |cp|
      if cp == cp.latest_approved_revision
        true
      elsif user.has_access_to(cp)
        true
      end
    end

    can :read, Message do |message|
      user.received_messages.include?(message)
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

    # ensure that logged in user can read all users and view index page
    can :read, User if UserSession.find

    can :index, User if UserSession.find

    if user.is_admin
      can :manage, :all
    end

  end
end