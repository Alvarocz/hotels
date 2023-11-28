# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(agent)
    can :all
    can :manage, Booking
    can :manage, Contact
    can :manage, Passenger
    return unless agent_signed_in?
    can :manage, Hotel, agent: agent
    can :manage, RoomType, hotel: { agent: agent }
    can :manage, Room, hotel: { agent: agent }
  end
end
