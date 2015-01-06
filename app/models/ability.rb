class Ability
  include CanCan::Ability

  # Guest user assigned to a nil-valued user.
  def initialize(user)
    user ||= User.new
    if user.id.nil?
      can :manage, User,  :id => user.id
    else
      can :manage, Event, :host_id => user.id
      can :manage, User,  :id => user.id
      can :manage, Commitment, :user_id => user.id 
      can :manage, Comment, :user_id => user.id
      can :manage, MovieInterest, :user_id => user.id
      can :manage, Rating, :user_id => user.id
      can :manage, Friendship 
      can :read, Event do |ev|
       ev.host.is_friend?(user)
     end
     can :read, User do |us|
      us.is_friend?(user)
    end
    can :read, MovieInterest do |mi|
      mi.user.is_friend?(user)
    end   
    can :read, Rating do |rt|
      rt.user.is_friend?(user)
    end             
  end
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
