class FavoriteLocation < ApplicationRecord
  belongs_to :user

  validates_presence_of :user, :location_id
  validate :check_for_dups


  private

  def check_for_dups
  	existing_locations = FavoriteLocation.where(user_id: self.user_id).pluck(:location_id)
  	if existing_locations.include? self.location_id
  		errors.add(:base, 'This location is already favorite.')
  	end
  end

end
