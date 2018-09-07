class User < ApplicationRecord
  acts_as_token_authenticatable
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  scope :search_name, -> (name) { where('lower(name) LIKE ?', "%#{name.downcase}%") }
  scope :search_email, -> (email) { where('lower(email) LIKE ?', "%#{email.downcase}%") }
  scope :search_facebook_present, -> () { where.not(facebook_url: nil) }
  scope :search_facebook_twitter, -> () { where.not(twitter: nil) }

	class << self
	  def filter_users filters, page
	  	users = self.where(nil)
	   filters.each do |key, value|
	     users = users.public_send("search_#{key}", value ) if value.present?
	   end
	   Kaminari.paginate_array(users).page(page).per(10)
	  end
	end

end
