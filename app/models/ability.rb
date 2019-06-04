class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:

    user ||= User.new # guest user (not logged in)

    if user.has_role? :admin
      can :manage, :all
    else
      @permission = Permission.all
      @permission.each  do |p|

        if user.has_role? p.role.name.to_sym
          if p.action_read == true
            can :read, p.resource.name.constantize
          end
          if p.action_create == true
            can :create, p.resource.name.constantize
          end
          if p.action_update == true
            can :update, p.resource.name.constantize
          end
          if p.action_destroy == true
            can :destroy, p.resource.name.constantize
          end
        end
      end
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
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
