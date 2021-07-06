class Ride < ActiveRecord::Base
  belongs_to :user
  belongs_to :attraction

  def take_ride
    message = "";
    

    if enough_tickets? && tall_enough?
      
      tickets = self.user.tickets - self.attraction.tickets
      nausea = self.user.nausea + self.attraction.nausea_rating
      happiness = self.user.happiness + self.attraction.happiness_rating
      
      self.user.update(tickets: tickets, nausea: nausea, happiness: happiness)
      self.user.save
      message = "Thanks for riding the #{self.attraction.name}!"

    elsif !enough_tickets? && !tall_enough?
      message = "Sorry. You do not have enough tickets to ride the #{self.attraction.name}. You are not tall enough to ride the #{self.attraction.name}."
    
    elsif !enough_tickets?
      message = "Sorry. You do not have enough tickets to ride the #{self.attraction.name}."
    
    else
      message = "Sorry. You are not tall enough to ride the #{self.attraction.name}."
    end

    message
  end

  private
  
  def enough_tickets?
    return true unless self.attraction.tickets > self.user.tickets
  end

  def tall_enough?
    return true unless self.attraction.min_height > self.user.height
  end
end
