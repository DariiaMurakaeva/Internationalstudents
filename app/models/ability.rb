# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the user here. For example:
    #
    can :read, Post
    can :read, Discussion
    can :read, Comment
    can :create, Subscription

    return unless user.present?  # additional permissions for logged in users (they can read their own posts)
    can :read, Post
    can :manage, Discussion, user: user
    can :manage, Comment, user: user
    can :bookmark, Post
    can :bookmark, Discussion 

    if user.user_role == 'international_student'
      can :create, ApplicationForm
      can :read, ApplicationForm, user: user
    elsif user.user_role == 'buddy'      
      can :read, ApplicationForm
    elsif user.user_role == 'admin'
      can :manage, :all
    end
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
    #   can :update, Article, published: true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md
  end
end
