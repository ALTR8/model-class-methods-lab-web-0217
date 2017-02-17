require 'pry'

class Captain < ActiveRecord::Base
  has_many :boats
  has_many :boat_classifications, through: :boats
  has_many :classifications, through: :boat_classifications

  def self.catamaran_operators
    with_classifications.where(classifications: {name: 'Catamaran'}) #captains: {admiral: false}) ...to add :)
  end

  def self.sailors
    with_classifications.where(classifications: {name: "Sailboat"}).uniq
  end

  def self.motorboaters
    with_classifications.where(classifications: {name: "Motorboat"}).uniq
  end

  def self.talented_seamen
  	mb = motorboaters.pluck(:id)
  	sb = sailors.pluck(:id) #find ones that match
  	where(id: (mb & sb))
  end

  def self.non_sailors
  	sailors = with_classifications.where(classifications: {name: "Sailboat"}).uniq
  	sailor_id = sailors.pluck(:id)
  	where.not(id: (sailor_id))
  end

  def self.with_classifications
  	joins(:classifications)
  end
end
